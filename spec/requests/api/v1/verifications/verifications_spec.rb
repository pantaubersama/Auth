require 'rails_helper'

RSpec.describe "Api::V1::Verifications", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) do
    User.reindex
    FactoryBot.create :user
  end
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  describe "Verifications" do
    it "step 1" do
      put "/v1/verifications/ktp_number", headers: { Authorization: token.token }, params: { ktp_number: "337501" }
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:step]).to eq(1)
      expect(json_response[:data][:user][:next_step]).to eq(2)
      expect(json_response[:data][:user][:is_verified]).to eq(false)
    end

    it "step 2" do
      put "/v1/verifications/ktp_number", headers: { Authorization: token.token }, params: { ktp_number: "337501" }

      put "/v1/verifications/ktp_selfie", headers: { Authorization: token.token },
          params:                                  { ktp_selfie: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }
      expect(response.status).to eq(200)

      expect(json_response[:data][:user][:step]).to eq(2)
      expect(json_response[:data][:user][:next_step]).to eq(3)
      expect(json_response[:data][:user][:is_verified]).to eq(false)
    end

    it "step 2 directly" do
      put "/v1/verifications/ktp_selfie", headers: { Authorization: token.token },
          params:                                  { ktp_selfie: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }
      expect(response.status).to eq(200)

      expect(json_response[:data][:user][:step]).to eq(nil)
      expect(json_response[:data][:user][:next_step]).to eq(1)
      expect(json_response[:data][:user][:is_verified]).to eq(false)
    end

    it "step 3" do
      put "/v1/verifications/ktp_number", headers: { Authorization: token.token }, params: { ktp_number: "337501" }

      put "/v1/verifications/ktp_selfie", headers: { Authorization: token.token },
          params:                                  { ktp_selfie: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }

      put "/v1/verifications/ktp_photo", headers: { Authorization: token.token },
          params:                                 { ktp_photo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }

      expect(response.status).to eq(200)

      expect(json_response[:data][:user][:step]).to eq(3)
      expect(json_response[:data][:user][:next_step]).to eq(4)
      expect(json_response[:data][:user][:is_verified]).to eq(false)
    end

    it "step 3 directly" do
      put "/v1/verifications/ktp_photo", headers: { Authorization: token.token },
          params:                                 { ktp_photo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }

      expect(response.status).to eq(200)

      expect(json_response[:data][:user][:step]).to eq(nil)
      expect(json_response[:data][:user][:next_step]).to eq(1)
      expect(json_response[:data][:user][:is_verified]).to eq(false)
    end

    it "step 4" do
      put "/v1/verifications/ktp_number", headers: { Authorization: token.token }, params: { ktp_number: "337501" }

      put "/v1/verifications/ktp_selfie", headers: { Authorization: token.token },
          params:                                  { ktp_selfie: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }

      put "/v1/verifications/ktp_photo", headers: { Authorization: token.token },
          params:                                 { ktp_photo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }

      put "/v1/verifications/signature", headers: { Authorization: token.token },
          params:                                 { signature: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }

      expect(response.status).to eq(200)

      expect(json_response[:data][:user][:step]).to eq(4)
      expect(json_response[:data][:user][:next_step]).to eq(5)
      expect(json_response[:data][:user][:is_verified]).to eq(false)
    end

    it "step 4 directly" do
      put "/v1/verifications/signature", headers: { Authorization: token.token },
          params:                                 { signature: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))) }

      expect(response.status).to eq(200)

      expect(json_response[:data][:user][:step]).to eq(nil)
      expect(json_response[:data][:user][:next_step]).to eq(1)
      expect(json_response[:data][:user][:is_verified]).to eq(false)
    end

  end
end