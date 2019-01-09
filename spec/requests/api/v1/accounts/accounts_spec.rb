require 'rails_helper'

RSpec.describe "Api::V1::Accounts", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    stub_twitter_request "YOUR_TOKEN", "YOUR_SECRET"
    stub_twitter_request_invalidate "YOUR_TOKEN", "YOUR_SECRET"
  end

  describe "Accounts" do
    it "connect twitter" do
      post "/v1/accounts/connect", headers: {Authorization: token.token},
        params: {
          account_type: "twitter",
          oauth_access_token: 'YOUR_TOKEN',
          oauth_access_token_secret: 'YOUR_SECRET',
        }
      expect(response.status).to  eq(201)
      expect(json_response[:data][:account][:user][:twitter]).to  eq(true)

      get "/v1/me", headers: {Authorization: token.token}
      expect(json_response[:data][:user][:twitter]).to  eq(true)
    end

    it "disconnect twitter not found" do
      delete "/v1/accounts/disconnect", headers: {Authorization: token.token},
        params: {
          account_type: "twitter"
        }
      expect(response.status).to  eq(404)
    end

    it "disconnect twitter" do
      post "/v1/accounts/connect", headers: {Authorization: token.token},
        params: {
          account_type: "twitter",
          oauth_access_token: 'YOUR_TOKEN',
          oauth_access_token_secret: 'YOUR_SECRET',
        }

      delete "/v1/accounts/disconnect", headers: {Authorization: token.token},
        params: {
          account_type: "twitter"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:account][:user][:twitter]).to  eq(false)

      get "/v1/me", headers: {Authorization: token.token}
      expect(json_response[:data][:user][:twitter]).to  eq(false)
    end
  end
end