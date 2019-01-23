require 'rails_helper'

RSpec.describe "Api::V1::Badges", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  let!(:admin) { FactoryBot.create :user }
  let!(:admin_token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => admin.id }

  before do
    5.times do
      FactoryBot.create :badge
    end
    @badge = Badge.last
    admin.make_me_admin!
  end

  describe "Badges" do
    it "list by user" do
      badge = FactoryBot.create :badge
      AchievedBadge.create(badge: badge, user: user)
      get "/v1/badges/user/#{user.id}"
      expect(response.status).to eq(200)
      expect(json_response[:data][:achieved_badges].size).to eq(1)
      expect(json_response[:data][:badges].size).to eq(5)
    end
  end
  
end