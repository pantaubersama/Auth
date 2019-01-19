require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  # let!(:application) { FactoryBot.create :application }
  # let!(:user) { FactoryBot.create :user }
  # let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }


  describe "empty record" do
    it "has no error" do
      User.reindex
      get "/v1/users"
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(0)
    end
  end
end