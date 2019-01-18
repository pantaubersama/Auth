require 'rails_helper'
RSpec.describe "Api::V1::Dashboard::Clusters", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    @category = FactoryBot.create :category
    @cluster  = create :cluster, requester: user, is_displayed: false, status: :requested, category: @c
    expect(@cluster.is_displayed).to eq(false)
    user.make_me_admin!

    3.times do
      FactoryBot.create :cluster, is_displayed: true, status: :approved
    end

    2.times do
      FactoryBot.create :cluster, is_displayed: true, status: :requested
    end

    5.times do
      FactoryBot.create :cluster, is_displayed: true, status: :rejected
    end
  end

  describe "[GET] Endpoint /dashboard/v1/clusters/approve" do
    it "should returns 201 with valid params when success" do
      post "/dashboard/v1/clusters/approve/#{ @cluster.id}",
           params:  {
             id: @cluster.id,
           },
           headers: { Authorization: token.token }

      expect(json_response[:data][:cluster][:is_displayed]).to eq(true)
      expect(response.status).to eq(201)
    end
  end

  describe "Add and remove member" do
    it "Add" do
      new_user = FactoryBot.create :user
      put "/dashboard/v1/clusters/make_members/#{ @cluster.id }", headers: {Authorization: token.token},
        params: {
          user_id: new_user.id
        }
      expect(json_response["data"]["user"]["cluster"]["id"]).to eq(@cluster.id)
      expect(@cluster.members_count).to eq(1)
    end

    it "Remove" do
      new_user = FactoryBot.create :user
      put "/dashboard/v1/clusters/make_members/#{ @cluster.id }", headers: {Authorization: token.token},
        params: {
          user_id: new_user.id
        }
      
      delete "/dashboard/v1/clusters/remove_members/#{ @cluster.id }", headers: {Authorization: token.token},
        params: {
          user_id: new_user.id
        }
        expect(json_response["data"]["user"]["cluster"]).to eq(nil)
        expect(@cluster.members_count).to eq(0)
    end
  end

  describe "List cluster" do
    it "list" do
      Cluster.reindex
      get "/dashboard/v1/clusters", headers: { Authorization: token.token }
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(11)
    end

    it "approved only" do
      Cluster.reindex
      get "/dashboard/v1/clusters", headers: { Authorization: token.token },
        params: { status: "approved" }
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(3)
      expect(json_response[:data][:clusters].map{|x| [x[:status]]}.uniq).to eq([["approved"]])
    end

    it "requested only" do
      Cluster.reindex
      get "/dashboard/v1/clusters", headers: { Authorization: token.token },
        params: { status: "requested" }
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(3)
      expect(json_response[:data][:clusters].map{|x| [x[:status]]}.uniq).to eq([["requested"]])
    end

    it "rejected only" do
      Cluster.reindex
      get "/dashboard/v1/clusters", headers: { Authorization: token.token },
        params: { status: "rejected" }
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(5)
      expect(json_response[:data][:clusters].map{|x| [x[:status]]}.uniq).to eq([["rejected"]])
    end

  end

  describe "create" do
    it "success" do
      category = FactoryBot.create :category
      creator = FactoryBot.create :user

      post "/dashboard/v1/clusters", headers: {Authorization: token.token},
        params: {
          name: "Cluster 1",
          description: "Mbel lah",
          category_id: category.id,
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          status: "approved",
          requester_id: creator.id
        }
      expect(response.status).to  eq(201)
      expect(json_response[:data][:cluster][:name]).to  eq("Cluster 1")
      expect(json_response[:data][:cluster][:description]).to  eq("Mbel lah")
      expect(json_response[:data][:cluster][:category_id]).to  eq(category.id)
      expect(json_response[:data][:cluster][:is_displayed]).to  eq(true)
      expect(creator.reload.has_role?(MODERATOR, Cluster.find(json_response[:data][:cluster][:id]))).to  eq(true)
    end
  end

  describe "update" do
    it "success" do
      category = FactoryBot.create :category
      creator = FactoryBot.create :user

      post "/dashboard/v1/clusters", headers: {Authorization: token.token},
        params: {
          name: "Cluster 1",
          description: "Mbel lah",
          category_id: category.id,
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          status: "requested",
          requester_id: creator.id
        }
      expect(creator.reload.has_role?(MODERATOR, Cluster.find(json_response[:data][:cluster][:id]))).to  eq(false)

      c = Cluster.find json_response[:data][:cluster][:id]
      
      put "/dashboard/v1/clusters/#{c.id}", headers: {Authorization: token.token},
        params: {
          name: "Cluster 2",
          description: "Mbel iki",
          status: "approved"
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:cluster][:name]).to eq("Cluster 2")
      expect(json_response[:data][:cluster][:description]).to eq("Mbel iki")
      expect(json_response[:data][:cluster][:is_displayed]).to eq(true)
      expect(creator.reload.has_role?(MODERATOR, Cluster.find(json_response[:data][:cluster][:id]))).to  eq(true)
    end
  end

  describe "delete" do
    it "success" do
      c = FactoryBot.create :cluster
      delete "/dashboard/v1/clusters/#{c.id}", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)
    end
  end

end