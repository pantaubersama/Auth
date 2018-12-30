require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Creation" do
    it "should be success" do
      category = FactoryBot.create :category
      expect(category).to be_valid
    end
  end
end
