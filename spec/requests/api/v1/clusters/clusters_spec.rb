require 'rails_helper'

RSpec.describe "Api::V1::Clusters", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    4.times do
      FactoryBot.create :cluster, is_displayed: true, status: :approved
    end
    @c        = FactoryBot.create :category
    @cluster  = Cluster.first
    @cluster2 = FactoryBot.create :cluster, category: @c, is_displayed: true, status: :approved, name: "No Name"
    user2.add_me_to_cluster! @cluster
    Cluster.reindex
  end

  describe "Clusers" do
    it "list" do
      Cluster.reindex
      get "/v1/clusters"
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(5)
      expect(json_response[:data][:clusters][0][:members_count]).to eq(1)
    end

    it "filter" do
      get "/v1/clusters", params: { filter_by: "category_id", filter_value: @c.id }
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(1)
      expect(json_response[:data][:clusters].last[:category_id]).to eq(@c.id)
    end

    it "Success" do
      get "/v1/clusters?filter_by=category_id&filter_value="
      expect(response.status).to  eq(200)
    end

    it "Success" do
      get "/v1/clusters?filter_by=category_id&filter_value="
      expect(response.status).to  eq(200)
    end

    it "search" do
      puts "refactored using word_start"
      get "/v1/clusters", params: { q: "LEN" }
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(0)
    end

    it "display" do
      get "/v1/clusters/#{@cluster.id}"
      expect(response.status).to eq(200)
      expect(json_response[:data][:cluster][:id]).to eq(@cluster.id)
    end

    it "request" do
      post "/v1/clusters", headers: { Authorization: token.token },
           params:                  { name: "Test Request", category_id: @c.id, description: Faker::Lorem.sentence(5), image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }
      expect(response.status).to eq(201)
      expect(json_response[:data][:cluster][:category_id]).to eq(@c.id)
      expect(json_response[:data][:cluster][:name]).to eq("Test Request")
      expect(json_response[:data][:cluster][:is_displayed]).to eq(false)
    end
  end

  describe "pagination" do
    it "paginate searchkick page 1" do
      8.times do
        FactoryBot.create :cluster, category: @c, is_displayed: true, status: :approved, name: "No Name"
      end
      Cluster.reindex
      # total record = 13
      get "/v1/clusters",
        params: {page: 1, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 2" do
      8.times do
        FactoryBot.create :cluster, category: @c, is_displayed: true, status: :approved, name: "No Name"
      end
      Cluster.reindex
      # total record = 13
      get "/v1/clusters",
        params: {page: 2, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(2)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 3" do
      8.times do
        FactoryBot.create :cluster, category: @c, is_displayed: true, status: :approved, name: "No Name"
      end
      Cluster.reindex
      # total record = 13
      get "/v1/clusters",
        params: {page: 3, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(3)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 4" do
      8.times do
        FactoryBot.create :cluster, category: @c, is_displayed: true, status: :approved, name: "No Name"
      end
      Cluster.reindex
      # total record = 13
      get "/v1/clusters",
        params: {page: 4, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(0)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(4)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end
  end

end