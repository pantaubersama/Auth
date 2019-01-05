require 'rails_helper'

RSpec.describe "Api::V1::Clusters", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    4.times do
      FactoryBot.create :cluster, is_displayed: true, status: :approved
    end
    @c        = FactoryBot.create :category
    @cluster  = Cluster.first
    @cluster2 = FactoryBot.create :cluster, category: @c, is_displayed: true, status: :approved
  end

  describe "Clusers" do
    it "list" do
      get "/v1/clusters"
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(5)
    end  

    it "filter" do
      get "/v1/clusters", params: { filter_by: "category_id", filter_value: @c.id }
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(1)
      expect(json_response[:data][:clusters].last[:category_id]).to eq(@c.id)
    end

    it "search" do
      get "/v1/clusters", params: { q: @cluster.name }
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(1)
      expect(json_response[:data][:clusters].last[:name]).to eq(@cluster.name)
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

end