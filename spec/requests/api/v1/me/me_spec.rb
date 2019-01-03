require 'rails_helper'

RSpec.describe "Api::V1::Me", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:cluster) { FactoryBot.create :cluster }
  let!(:badge) { FactoryBot.create :badge }
  let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    user.make_me_moderator! cluster
  end

  describe "Clusers" do
    it "me detail" do
      get "/v1/me", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:cluster][:id]).to eq(cluster.id)
    end 

    it "me detail" do
      get "/v1/me/simple", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:id]).to eq(user.id)
    end 
    
    it "update profile" do
      put "/v1/me", headers: {Authorization: token.token},
        params: {
          first_name: "John",
          last_name: "Doe",
          username: "johndoe",
          about: "about",
          location: "location",
          education: "education",
          occupation: "occupation"
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:first_name]).to eq("John")
      expect(json_response[:data][:user][:last_name]).to eq("Doe")
      expect(json_response[:data][:user][:username]).to eq("johndoe")
      expect(json_response[:data][:user][:about]).to eq("about")
      expect(json_response[:data][:user][:location]).to eq("location")
      expect(json_response[:data][:user][:education]).to eq("education")
      expect(json_response[:data][:user][:occupation]).to eq("occupation")
    end 

    it "update username" do
      put "/v1/me/username", headers: {Authorization: token.token},
        params: {
          username: "johndoe",
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:username]).to eq("johndoe")
    end 

    it "update username failed" do
      expect{
        put "/v1/me/username", headers: {Authorization: token.token},
          params: {
            username: "johndoe&%",
          }
      }.to raise_error ActiveRecord::RecordInvalid
    end 

    it "update avatar" do
      put "/v1/me/avatar", headers: {Authorization: token.token},
        params: {
          avatar: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:avatar][:medium]).not_to eq(nil)
    end
    
    it "update vote preference" do
      put "/v1/me/vote_preference", headers: {Authorization: token.token},
        params: {
          vote_preference: 2
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:vote_preference]).to eq(2)
    end

    it "My verification" do
      get "/v1/me/verifications", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:is_verified]).to eq(false)
    end

    it "My informants" do
      get "/v1/me/informants", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:informant][:user_id]).to eq(user.id)
    end

    it "have achieved badges" do
      b = AchievedBadge.create user: user, badge: badge

      get "/v1/me/badges", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      
      expect(json_response[:data][:badges].size).to eq(1)
      expect(json_response[:data][:badges][0][:name]).to eq(badge.name)
    end
  end
  
end