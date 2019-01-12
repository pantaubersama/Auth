require 'rails_helper'
RSpec.describe "Api::V1::Dashboard::politicalParty", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:admin) { FactoryBot.create :user }
  let!(:admin_token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => admin.id }
  let!(:user) { FactoryBot.create :user }
  let!(:user_token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    @party = FactoryBot.create :political_party
    admin.make_me_admin!
  end

  describe "Authorized" do
    it "authorized" do
      get "/dashboard/v1/political_parties/#{@party.id}", headers: {Authorization: admin_token.token}
      expect(response.status).to  eq(200)
    end
    it "not authorized" do
      get "/dashboard/v1/political_parties/#{@party.id}", headers: {Authorization: user_token.token}
      expect(response.status).to  eq(403)
    end
  end

  describe "update" do
    it "success" do
      put "/dashboard/v1/political_parties/#{@party.id}", headers: {Authorization: admin_token.token},
        params: {
          name: "Hello",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:political_party][:name]).to  eq("Hello")
    end
  end

  describe "create" do
    it "success" do
      post "/dashboard/v1/political_parties", headers: {Authorization: admin_token.token},
        params: {
          name: "Hello",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png')))
        }
      expect(response.status).to  eq(201)
      expect(json_response[:data][:political_party][:name]).to  eq("Hello")
    end
  end

  describe "delete" do
    it "success" do
      delete "/dashboard/v1/political_parties/#{@party.id}", headers: {Authorization: admin_token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)
    end
  end

end