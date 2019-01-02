require 'rails_helper'

RSpec.describe Badge, type: :model do
  describe "Creation" do
    it "should be success" do
      badge = FactoryBot.create :badge
      expect(badge).to be_valid
    end
  end

  describe "Achieved" do
    it "success" do
      badge = FactoryBot.create :badge
      user = FactoryBot.create :user
      b = AchievedBadge.create! user: user, badge: badge
      expect(user.achieved_badges.size).to eq(1)
    end

    it "success even with double badge" do
      badge = FactoryBot.create :badge
      user = FactoryBot.create :user
      
      b = AchievedBadge.create! user: user, badge: badge

      expect{
        AchievedBadge.create! user: user, badge: badge
      }.to raise_error ActiveRecord::RecordInvalid

      expect(user.achieved_badges.size).to eq(1)
    end
  end
end
