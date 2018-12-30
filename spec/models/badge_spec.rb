require 'rails_helper'

RSpec.describe Badge, type: :model do
  describe "Creation" do
    it "should be success" do
      badge = FactoryBot.create :badge
      expect(badge).to be_valid
    end
  end
end
