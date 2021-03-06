require 'rails_helper'

RSpec.describe Cluster, type: :model do
  describe "Creation" do
    it "create simple cluster" do
      cluster = Cluster.create name: "Test Cluster"
      expect(cluster.name).to eq "Test Cluster"
    end

    it "should be success" do
      cluster = FactoryBot.create :cluster
      expect(cluster).to be_valid
    end

    it "should have magic link" do
      cluster = FactoryBot.create :cluster
      expect(cluster.magic_link).not_to eq(nil)
      expect(cluster.is_link_active).to eq(false)
    end
  end

  describe "List and find" do
    it "should not be visible" do
      cluster = FactoryBot.create :cluster
      expect{
        Cluster.visible.find cluster.id
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should be visible" do
      cluster = FactoryBot.create :cluster
      cluster.update_attribute :is_displayed, true
      c = Cluster.find cluster.id
      expect(c.is_displayed).to eq(true)
    end
    
  end
  
end
