require 'rails_helper'

RSpec.describe "Api::V1::Clusters", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }


  describe "empty record" do
    it "has no error" do
      Cluster.reindex
      get "/v1/clusters"
      expect(response.status).to eq(200)
      expect(json_response[:data][:clusters].size).to eq(0)
    end
  end
end