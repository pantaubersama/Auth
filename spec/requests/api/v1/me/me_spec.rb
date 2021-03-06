require 'rails_helper'

RSpec.describe "Api::V1::Me", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:cluster) { FactoryBot.create :cluster }
  let!(:badge) { FactoryBot.create :badge }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    user.make_me_moderator! cluster
  end

  describe "Clusers" do
    it "me detail" do
      get "/v1/me", headers: { Authorization: token.token }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:cluster][:id]).to eq(cluster.id)
      expect(json_response[:data][:user][:cluster][:members_count]).to eq(1)
    end

    it "me detail" do
      get "/v1/me/simple", headers: { Authorization: token.token }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:id]).to eq(user.id)
    end

    it "update profile" do
      put "/v1/me", headers: { Authorization: token.token },
          params:            {
            full_name:  "John Doe",
            username:   "johndoe",
            about:      "about",
            location:   "location",
            education:  "education",
            occupation: "occupation"
          }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:full_name]).to eq("John Doe")
      expect(json_response[:data][:user][:username]).to eq("johndoe")
      expect(json_response[:data][:user][:about]).to eq("about")
      expect(json_response[:data][:user][:location]).to eq("location")
      expect(json_response[:data][:user][:education]).to eq("education")
      expect(json_response[:data][:user][:occupation]).to eq("occupation")
    end

    it "update username" do
      put "/v1/me/username", headers: { Authorization: token.token },
          params:                     {
            username: "johndoe",
          }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:username]).to eq("johndoe")
    end

    it "update username failed" do
      put "/v1/me/username", headers: { Authorization: token.token },
          params:                     {
            username: "johndoe&%",
          }
      expect(response.status).to eq(422)
      expect(json_response[:error][:errors]).to eq(["Validation failed: Username can only contain letters, underscore, and numbers."])
    end

    it "update avatar" do
      put "/v1/me/avatar", headers: { Authorization: token.token },
          params:                   {
            avatar: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:avatar][:medium]).not_to eq(nil)
    end

    it "update vote preference" do
      put "/v1/me/vote_preference", headers: { Authorization: token.token },
          params:                            {
            vote_preference: 2
          }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:vote_preference]).to eq(2)
    end

    it "My verification" do
      get "/v1/me/verifications", headers: { Authorization: token.token }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:is_verified]).to eq(false)
    end

    it "My informants" do
      get "/v1/me/informants", headers: { Authorization: token.token }
      expect(response.status).to eq(200)
      expect(json_response[:data][:informant][:user_id]).to eq(user.id)
    end

    it "have achieved badges" do
      b = AchievedBadge.create user: user, badge: badge

      get "/v1/me/badges", headers: { Authorization: token.token }
      expect(response.status).to eq(200)

      expect(json_response[:data][:achieved_badges].size).to eq(1)
      expect(json_response[:data][:achieved_badges][0][:badge][:name]).to eq(badge.name)
      expect(json_response[:data][:achieved_badges][0][:achieved_id]).not_to eq(nil)
    end

    it "update firebase key" do
      put "/v1/me/firebase_keys", headers: { Authorization: token.token },
          params:                          {
            firebase_key: "Cinta adalah misteri", firebase_key_type: "android"
          }
      expect(response.status).to eq(200)
      expect(json_response[:data][:firebase_key][:content]).to eq("Cinta adalah misteri")
      expect(json_response[:data][:firebase_key][:key_type]).to eq("android")
    end

  end

end