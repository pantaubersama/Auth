require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Role changing" do
    before do
      @user = ::User.create email: Faker::Internet.email 
      @cluster = ::Cluster.find_or_create_by name: "Test Cluster"
      FactoryBot.create :badge, code: "pantaubersama"
    end

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
    
    it "success omniauth callback" do
      auth = { provider: "identitas", uid: "1", info: {
          email: "helmy@extrainteger.com",
          first_name: "Yunan",
          last_name: "Helmy",
          full_name: "Yunan Helmy",
          username: "yunanhelmy"
        }
      }

      class DataStruct < OpenStruct
        def as_json(*args)
          super.as_json['table']
        end
      end

      o = JSON.parse(auth.to_json, object_class: DataStruct)
      u = User.from_omniauth(o)
      
      expect(u.email).to eq("helmy@extrainteger.com")
      expect(u.full_name).to eq("Yunan Helmy")
      expect(u.username).to eq("yunanhelmy")
      expect(u.achieved_badges.size).to eq(1)
      expect(u.badges.last.code).to eq("pantaubersama")
    end


  end
end
