require 'rails_helper'

RSpec.describe "Api::V1::Resources::Examples", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }
  
  describe "[GET] Public endpoint /public" do
    it "success" do
      get "/v1/examples/public"
      expect(response.status).to eq(200)
      expect(json_response[:data][:current_user]).to eq(nil)
    end
  end

  describe "[GET] Optional endpoint /optional" do
    it "success with access token" do
      get "/v1/examples/optional", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:current_user]).not_to eq(nil)
    end

    it "success without access token" do
      get "/v1/examples/optional"
      expect(response.status).to eq(200)
      expect(json_response[:data][:current_user]).to eq(nil)
    end
  end

  describe "[GET] Protected endpoint /protected" do
    it "success with access token" do
      get "/v1/examples/protected", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:current_user]).not_to eq(nil)
    end

    it "fail without access token" do
      get "/v1/examples/protected"
      expect(response.status).to eq(401)
    end
  end
  
end