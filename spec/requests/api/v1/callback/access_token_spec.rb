require 'rails_helper'

RSpec.describe "Api::V1::Callback", type: :request do
  describe "Success callback" do
    let!(:application) { FactoryBot.create :application }
    let!(:user) { FactoryBot.create :user }
    let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }
    let!(:provider_token) { SecureRandom.hex(32) }

    before do
      stub_credentials_request provider_token
      stub_credential_verify provider_token
    end

    it "generate client token" do
      get "/v1/callback", params: {provider_token: provider_token}
      expect(json_response[:data][:access_token]).not_to eq(nil)
      expect(json_response[:data][:refresh_token]).not_to eq(nil)

      u = User.find_by email: "helmy@extrainteger.com"
      expect(u.username).to eq("yunanhelmy")
      expect(u.email).to eq("helmy@extrainteger.com")
      expect(u.full_name).to eq("Yunan Helmy")
    end

    it "generate client token with firebase token updated" do
      get "/v1/callback", params: {provider_token: provider_token, firebase_key: "Hello", firebase_key_type: "android"}
      expect(json_response[:data][:access_token]).not_to eq(nil)
      expect(json_response[:data][:refresh_token]).not_to eq(nil)
    end
  end
end