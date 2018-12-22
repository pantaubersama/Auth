require 'rails_helper'

RSpec.describe Cluster, type: :model do
  describe "Creation" do
    it "create simple cluster" do
      cluster = Cluster.create name: "Test Cluster"
      expect(cluster.name).to eq "Test Cluster"
    end
  end
end
