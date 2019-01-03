require 'rails_helper'

RSpec.describe "Api::V1::PoliticalParties", type: :request do
  
  describe "political_parties" do
    before do
      data = [
        {
          name: "PARTAI KEBANGKITAN BANGSA",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/1.jpeg')))
        },
        {
          name: "PARTAI GERAKAN INDONESIA RAYA",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/political_party/2.jpg')))
        }
      ]
  
      PoliticalParty.create(data)
    end
    it "list" do
      get "/v1/political_parties"
      expect(response.status).to eq(200)
      expect(json_response[:data][:political_parties].size).to eq(2)
    end 
  end

  
end