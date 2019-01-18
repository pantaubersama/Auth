require 'rails_helper'

RSpec.describe AchievedBadge, type: :model do
  before do
    @user = FactoryBot.create :user
    2.times do
      FactoryBot.create :badge
    end
  end

  describe "Achieved badge" do
    it "should be success" do
      badge = AchievedBadge.create badge: Badge.first, user: @user
      expect(badge).to be_valid
    end

    it "should be have achieved badges" do
      badge = AchievedBadge.create badge: Badge.last, user: @user
      expect(badge).to be_valid
    end
  end
end
