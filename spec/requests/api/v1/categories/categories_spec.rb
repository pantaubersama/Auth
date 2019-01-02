require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    5.times do
      FactoryBot.create :category
    end
    @category = Category.last
    @category2 = Category.first
  end

  describe "Categories" do
    it "list" do
      get "/v1/categories"
      expect(response.status).to eq(200)
      expect(json_response[:data][:categories].size).to eq(5)
    end

    it "search" do
      get "/v1/categories", params: {ids: @category.id}
      expect(response.status).to eq(200)
      expect(json_response[:data][:categories].size).to eq(1)
    end

    it "search 2" do
      get "/v1/categories", params: {ids: [@category.id, @category2.id].join(", ")}
      expect(response.status).to eq(200)
      expect(json_response[:data][:categories].size).to eq(2)
    end

    it "display" do
      get "/v1/categories/#{@category.id}"
      expect(response.status).to eq(200)
      expect(json_response[:data][:category][:id]).to eq(@category.id)
    end

    it "create" do
      post "/v1/categories", headers: {Authorization: token.token}, 
        params: { name: Faker::Lorem.sentence(2), creator: user }
      expect(response.status).to eq(201)
    end

    it "search" do
      get "/v1/categories", params: {name: @category.name}
      expect(response.status).to eq(200)
      expect(json_response[:data][:categories].size).to eq(1)
      expect(json_response[:data][:categories][0][:name]).to eq(@category.name)
    end

  end
  
end