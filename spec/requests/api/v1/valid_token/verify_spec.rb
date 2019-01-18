require 'rails_helper'

RSpec.describe "Api::V1::ValidToken", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  describe "Valid token" do
    it "is valid" do
      get "/v1/valid_token/verify", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:credential][:access_token]).to eq(token.token)
      expect(json_response[:data][:info][:email]).to eq(user.email)
    end

    it "is not valid" do
      get "/v1/valid_token/verify", headers: {Authorization: SecureRandom.hex(32)}
      expect(response.status).to eq(401)
    end

    it "is not valid because revoked" do
      token.revoke
      get "/v1/valid_token/verify", headers: {Authorization: token.token}
      expect(response.status).to eq(401)
    end
  end
end