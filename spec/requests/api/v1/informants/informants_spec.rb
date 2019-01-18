require 'rails_helper'

RSpec.describe "Api::V1::Informants", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:token)  { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    
  end

  describe "Clusers" do
    it "Update" do
      put "/v1/informants", headers: {Authorization: token.token},
        params: {
          identity_number: "337501",
          pob: "Yoygyakarta",
          dob: "1990-06-08",
          gender: 1,
          occupation: "Juru masak",
          nationality: "Indonesia",
          address: "Jalan ABC",
          phone_number: "085642",
        }
      expect(response.status).to eq(200)
      expect(json_response[:data][:informant][:user_id]).to eq(user.id)
      expect(json_response[:data][:informant][:identity_number]).to eq("337501")
      expect(json_response[:data][:informant][:pob]).to eq("Yoygyakarta")
      expect(json_response[:data][:informant][:dob]).to eq("1990-06-08")
      expect(json_response[:data][:informant][:gender]).to eq(1)
      expect(json_response[:data][:informant][:occupation]).to eq("Juru masak")
      expect(json_response[:data][:informant][:nationality]).to eq("Indonesia")
      expect(json_response[:data][:informant][:address]).to eq("Jalan ABC")
      expect(json_response[:data][:informant][:phone_number]).to eq("085642")

      get "/v1/me", headers: {Authorization: token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:informant][:user_id]).to eq(user.id)
      expect(json_response[:data][:user][:informant][:identity_number]).to eq("337501")
      expect(json_response[:data][:user][:informant][:pob]).to eq("Yoygyakarta")
      expect(json_response[:data][:user][:informant][:dob]).to eq("1990-06-08")
      expect(json_response[:data][:user][:informant][:gender]).to eq(1)
      expect(json_response[:data][:user][:informant][:occupation]).to eq("Juru masak")
      expect(json_response[:data][:user][:informant][:nationality]).to eq("Indonesia")
      expect(json_response[:data][:user][:informant][:address]).to eq("Jalan ABC")
      expect(json_response[:data][:user][:informant][:phone_number]).to eq("085642")
    end  
  end
  
end