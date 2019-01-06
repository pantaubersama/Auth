require 'rails_helper'

RSpec.describe "Api::V1::Clusters", type: :request do
  describe "invite and callback" do
    let!(:application) { FactoryBot.create :application }
    let!(:user) { FactoryBot.create :user }
    let!(:cluster) { FactoryBot.create :cluster, requester: user }
    let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

    before do
      cluster.approve!
      user.make_me_moderator! cluster
      stub_symbolic "m.yunan.helmy@gmail.com", "27515767c7_0"
      stub_symbolic "menik.damayanti.p@gmail.com", "27515767c7_1"
    end

    it "invited and success callback" do
      # invite
      post "/v1/clusters/invite", headers: {Authorization: token.token},
      params: {
        emails: "m.yunan.helmy@gmail.com",
        invite_code: "27515767c7"
      }
      expect(response.status).to  eq(201)
      expect(json_response[:data][0][:id]).not_to  eq(nil)
      expect(json_response[:data][0][:email]).to  eq("m.yunan.helmy@gmail.com")
      expect(json_response[:data][0][:status]).not_to  eq(nil)

      u = User.find_by invite_code: "27515767c7_0"

      expect(u.reload.has_role?(:member, cluster)).to eq(false)

      # invite callback
      post "/v1/callback/invitation", params: { invite_code: "27515767c7_0" }
      expect(response.status).to eq(201)
      expect(json_response[:data]).to eq(true)
      
      expect(u.reload.has_role?(:member, cluster)).to eq(true)
    end

    it "invites multiple email" do
      post "/v1/clusters/invite", headers: {Authorization: token.token},
      params: {
        emails: "m.yunan.helmy@gmail.com, menik.damayanti.p@gmail.com",
        invite_code: "27515767c7"
      }
      expect(response.status).to  eq(201)
      expect(json_response[:data].size).to  eq(2)
    end

  end
end