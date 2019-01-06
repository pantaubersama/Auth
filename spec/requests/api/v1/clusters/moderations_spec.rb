require 'rails_helper'

RSpec.describe "Api::V1::Moderations", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user }
  let!(:cluster) { FactoryBot.create :cluster, requester: user }
  let!(:cluster2) { FactoryBot.create :cluster, requester: user2}
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }
  let!(:token2) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user2.id }

  before do
    cluster.approve!
    cluster2.approve!
    user.make_me_moderator! cluster
    user2.add_me_to_cluster! cluster
    user2.make_me_moderator! cluster2
  end

  describe "quit cluster" do
    it "quit" do
      delete "/v1/me/clusters", headers: {Authorization: token.token}
      expect(json_response[:data][:status]).to eq(true)

      get "/v1/me", headers: {Authorization: token.token}
      expect(json_response[:data][:user][:cluster]).to eq(nil)
    end
  end

  describe "join cluster" do
    it "via magic link" do
      post "/v1/clusters/#{cluster2.id}/magic_link", headers: {Authorization: token2.token},
        params: { enable: true }

      get "/v1/clusters/join", headers: {Authorization: token.token},
        params: { magic_link: cluster2.magic_link }

      expect(json_response[:data][:cluster][:members_count]).to eq(2)
      expect(cluster2.reload.referal_count).to eq(1)
    end

    it "cannot join" do
      get "/v1/clusters/join", headers: {Authorization: token.token},
        params: { magic_link: cluster2.magic_link }
        
      expect(response.status).to eq(403)
    end
  end

  describe "magic link" do
    it "enabled" do
      post "/v1/clusters/#{cluster.id}/magic_link", headers: {Authorization: token.token},
        params: { enable: true }
      expect(json_response[:data][:cluster][:is_link_active]).to eq(true)

      get "/v1/me", headers: {Authorization: token.token}
      expect(json_response[:data][:user][:cluster][:is_link_active]).to eq(true)
    end

    it "disabled" do
      post "/v1/clusters/#{cluster.id}/magic_link", headers: {Authorization: token.token},
        params: { enable: false }
      expect(json_response[:data][:cluster][:is_link_active]).to eq(false)

      get "/v1/me", headers: {Authorization: token.token}
      expect(json_response[:data][:user][:cluster][:is_link_active]).to eq(false)
    end

    it "not authorized" do
      post "/v1/clusters/#{cluster.id}/magic_link", headers: {Authorization: token2.token},
        params: { enable: true }
      expect(response.status).to eq(403)
    end
  end
end