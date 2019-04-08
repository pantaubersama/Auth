require 'rails_helper'

RSpec.describe "API::V1::Challenge::Invite", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }
  let!(:token2) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user2.id }

  # /v1/challenges/direct/invite
  describe "Invite twitter user" do
    it "success" do
      post "/v1/challenges/direct/invite", params: {
        invite_code: "ABC",
        invitation_id: "38895958",
        type: "twitter"
      }
      expect(response.status).to eq(201)
      expect(json_response[:data][:challenge][:accepted_at]).to eq(nil)
      expect(json_response[:data][:challenge][:invite_code]).to eq("ABC")
      expect(json_response[:data][:challenge][:invitation_id]).to eq("38895958")
      expect(json_response[:data][:challenge][:type]).to eq("twitter")
    end
  end

  # /v1/challenges/direct/invite
  describe "Invite pantau user" do
    it "success" do
      post "/v1/challenges/direct/invite", params: {
        invite_code: "ABC",
        invitation_id: user2.id,
        type: "user"
      }
      expect(response.status).to eq(201)
      expect(json_response[:data][:challenge][:accepted_at]).to eq(nil)
      expect(json_response[:data][:challenge][:invite_code]).to eq("ABC")
      expect(json_response[:data][:challenge][:invitation_id]).to eq(user2.id)
      expect(json_response[:data][:challenge][:type]).to eq("user")
    end
  end
end