require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Role changing" do
    before { 
      @user = ::User.create email: Faker::Internet.email 
      @cluster = ::Cluster.find_or_create_by name: "Test Cluster"
    }

    it "became admin" do
      @user.make_me_admin!
      expect(@user.has_role? ADMIN).to eq true  
    end

    it "remove admin" do
      @user.make_me_admin!
      @user.remove_admin!
      expect(@user.has_role? ADMIN).to eq false  
    end

    it "became moderator of cluster" do
      @user.make_me_moderator! @cluster
      expect(@user.has_role? MODERATOR, @cluster).to eq true  
    end

    it "became member of cluster" do
      @user.add_me_to_cluster! @cluster
      expect(@user.has_role? MEMBER, @cluster).to eq true  
    end

    it "display cluster" do
      @user.add_me_to_cluster! @cluster
      expect(@user.cluster.name).to eq "Test Cluster"  
    end

  end
end
