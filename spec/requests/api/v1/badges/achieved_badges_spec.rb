require 'rails_helper'

RSpec.describe "Api::V1::AchievedBadges", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    5.times do
      FactoryBot.create :badge
    end
    @badge = Badge.last
  end

  describe "Achieved Badges" do
    
    it "display achieved badges" do
      b = AchievedBadge.create user: user, badge: @badge

      get "/v1/achieved_badges/#{b.id}", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      
      expect(json_response[:data][:achieved_badge][:achieved_id]).not_to eq(nil)
      expect(json_response[:data][:achieved_badge][:badge][:name]).to eq(@badge.name)
      expect(json_response[:data][:achieved_badge][:user][:email]).to eq(user.email)
    end

  end
  

end