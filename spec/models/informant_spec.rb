require 'rails_helper'

RSpec.describe Informant, type: :model do
  describe "Creation" do
    it "should be success" do
      user = FactoryBot.create(:user)
      informant = FactoryBot.build :informant
      expect(informant.new_record?).to eq(true)
    end
  end
end
