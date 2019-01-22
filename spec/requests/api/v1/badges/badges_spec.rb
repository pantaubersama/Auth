require 'rails_helper'

RSpec.describe "Api::V1::Badges", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  let!(:admin) { FactoryBot.create :user }
  let!(:admin_token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => admin.id }

  before do
    5.times do
      FactoryBot.create :badge
    end
    @badge = Badge.last
    admin.make_me_admin!
  end

  describe "Badges" do
    it "list" do
      get "/v1/badges", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:achieved_badges].size).to eq(0)
      expect(json_response[:data][:badges].size).to eq(5)
    end

    it "list as admin" do
      get "/v1/badges", headers: {Authorization: admin_token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:badges][0][:code]).not_to eq(nil)
      expect(json_response[:data][:badges][0][:namespace]).not_to eq(nil)
    end

    it "have achieved badges" do
      b = AchievedBadge.create user: user, badge: @badge

      get "/v1/badges", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      
      expect(json_response[:data][:badges].size).to eq(4)
      expect(json_response[:data][:achieved_badges].size).to eq(1)
      expect(json_response[:data][:achieved_badges][0][:achieved_id]).not_to eq(nil)
      expect(json_response[:data][:achieved_badges][0][:badge][:name]).to eq(@badge.name)
      expect(json_response[:data][:badges].size).to eq(4)
    end

    it "display" do
      get "/v1/badges/#{@badge.id}", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
    end

    it "display as admin" do
      get "/v1/badges/#{@badge.id}", headers: {Authorization: admin_token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:badge][:code]).not_to eq(nil)
      expect(json_response[:data][:badge][:namespace]).not_to eq(nil)
    end
  end
  
  describe "Create badge" do
    it "create a badge" do
      puts "not used anymore .... :("
      # post "/v1/badges", headers: {PantauAuthKey: ENV["PANTAU_AUTH_KEY"]}, 
      #   params: { name: Faker::Lorem.sentence(2), description: Faker::Lorem.sentence(2), 
      #     image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))), 
      #     position: 1
      #   }
      # expect(response.status).to eq(201)
    end
  end

end