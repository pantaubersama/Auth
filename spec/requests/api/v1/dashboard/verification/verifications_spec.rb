require 'rails_helper'
RSpec.describe "Api::V1::Dashboard::Verifications", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }
  let!(:yusuf) {FactoryBot.create :user}


  before do
    user.make_me_admin!
    yusuf.build_verification_model
  end

  describe "not authorized" do
    it "cannot add user verification" do
      post "/dashboard/v1/verifications/user",
           params:  {
             email: yusuf.email,
           }
      expect(response.status).to eq(401)
    end

    it "cannot access list user verification" do
      get "/dashboard/v1/users/verifications",
        params: {
          page: 1,
          q: "*",
          o: "and",
          m: "word_start",
        }
      expect(response.status).to eq(401)
    end

  end

  describe "authorized" do
    it "update note" do
      put '/dashboard/v1/verifications/note',
        headers: {Authorization: token.token},
        params: {
          id: yusuf.id,
          note: "KTP Buram"
        }
      expect(response.status).to eq(200)
      expect(json_response['data']).to eq(true)
    end

    it "success reset" do
      put '/dashboard/v1/verifications/note',
        headers: {Authorization: token.token},
        params: {
          id: yusuf.id,
          note: "KTP Buram"
        }

      put '/dashboard/v1/verifications/reset',
        headers: {Authorization: token.token},
        params: {
          id: yusuf.id,
          step: 1
        }

      expect(response.status).to eq(200)
      expect(json_response["data"]).to eq(true)
    end

    it "success verification" do
      post '/dashboard/v1/verifications/user',
        params:{
          email: yusuf.email,
          ktp_number: "091923981923989",
          ktp_selfie: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          ktp_photo: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          signature: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
        },
        headers: {Authorization: token.token}
        expect(response.status).to eq(201)
        expect(json_response['data']['status']).to eq('verified')
    end

    it "can access list user verification" do
      get "/dashboard/v1/users/verifications",
        params: {
          page: 1,
          q: "*",
          o: "and",
          m: "word_start",
        },
        headers: {Authorization: token.token}
      expect(response.status).to eq(200)
    end

  end


end