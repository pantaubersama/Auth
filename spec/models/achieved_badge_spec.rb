require 'rails_helper'

RSpec.describe AchievedBadge, type: :model do
  before do
    @user = FactoryBot.create :user
    2.times do
      FactoryBot.create :badge
    end
    FactoryBot.create :badge, code: "biodata"
    FactoryBot.create :badge, code: "biodata_lapor"
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

    it "achieve biodata badge" do
      user = FactoryBot.create :user, full_name: "yunan helmy", username: "yunan", location: "Yogya",  about: "About me",
        education: "UGM", occupation: "Juru Masak"
      expect(user.is_complete?).to eq(true)
      expect(user.badges.last.code).to eq("biodata")
    end

    it "achieve biodata lapor" do
      user = FactoryBot.create :user
      informant = FactoryBot.create(:informant, user_id: user.id, pob: "123", dob: Time.now, identity_number: "123", gender: 0, occupation: "asd", nationality: "asd", address: "awd", phone_number: "0012")
      expect(informant.is_complete?).to eq(true)
      expect(informant.user.badges.last.code).to eq("biodata_lapor")
    end

  end
end
