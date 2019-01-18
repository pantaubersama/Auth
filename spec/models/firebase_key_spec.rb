require 'rails_helper'

RSpec.describe FirebaseKey, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe "Assign" do
    it "success create" do
      fcm = SecureRandom.hex(32)
      f = FirebaseKey.assign! user.id, "ios", fcm
      expect(f.user_id).to eq(user.id)  
      expect(f.key_type).to eq("ios")  
      expect(f.content).to eq(fcm)  
    end

    it "success update" do
      fcm = SecureRandom.hex(32)
      fcm2 = SecureRandom.hex(32)

      f = FirebaseKey.assign! user.id, "ios", fcm
      expect(f.user_id).to eq(user.id)  
      expect(f.key_type).to eq("ios")  
      expect(f.content).to eq(fcm)  

      f = FirebaseKey.assign! user.id, "ios", fcm2
      expect(f.user_id).to eq(user.id)  
      expect(f.key_type).to eq("ios")  
      expect(f.content).to eq(fcm)

      total = FirebaseKey.all.size
      expect(total).to eq(1)  
    end

    it "saved" do
      fcm = SecureRandom.hex(32)
      fcm2 = SecureRandom.hex(32)
      fcm3 = SecureRandom.hex(32)
      fcm4 = SecureRandom.hex(32)

      f = FirebaseKey.assign! user.id, "ios", fcm
      f2 = FirebaseKey.assign! user.id, "android", fcm
      f3 = FirebaseKey.assign! user.id, "web", fcm
      f4 = FirebaseKey.assign! user.id, "web", fcm

      expect(user.firebase_keys.size).to eq 3
    end
  end
end
