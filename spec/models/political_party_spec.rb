require 'rails_helper'

RSpec.describe PoliticalParty, type: :model do
  describe "Political party" do
    it "create" do
      p = FactoryBot.create :political_party
      expect(p).to be_valid 
    end
  end
end
