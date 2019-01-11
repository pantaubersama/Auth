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

end