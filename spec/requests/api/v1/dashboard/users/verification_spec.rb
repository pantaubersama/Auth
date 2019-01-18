require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::Users", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    user.make_me_admin!
  end

  describe "Approve verification" do
    it "success" do
      post "/dashboard/v1/users/approve", headers: { Authorization: token.token },
        params: {
          id: user2.id
        }
      expect(response.status).to  eq(201)
      expect(json_response[:data][:user][:verified]).to eq(true)
      expect(user2.verification.reload.status).to eq("verified")
    end
  end

  describe "Reject verification" do
    it "success" do
      delete "/dashboard/v1/users/reject", headers: { Authorization: token.token },
        params: {
          id: user2.id
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:user][:verified]).to eq(false)
      expect(user2.verification.reload.status).to eq("rejected")
    end
  end
end