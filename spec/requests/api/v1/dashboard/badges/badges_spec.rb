require 'rails_helper'
RSpec.describe "Api::V1::Dashboard::badges", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:admin) { FactoryBot.create :user }
  let!(:admin_token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => admin.id }
  let!(:user) { FactoryBot.create :user }
  let!(:user_token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    @badge = FactoryBot.create :badge
    admin.make_me_admin!
  end

  describe "Authorized" do
    it "authorized" do
      put "/dashboard/v1/badges/#{@badge.id}", headers: {Authorization: admin_token.token},
        params: {
          name: "Hello",
          description: "hello bro",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          position: 1,
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:badge][:name]).to  eq("Hello")
      expect(json_response[:data][:badge][:description]).to  eq("hello bro")
    end
    it "not authorized" do
      put "/dashboard/v1/badges/#{@badge.id}", headers: {Authorization: user_token.token},
        params: {
          name: "Hello",
          description: "hello bro",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          position: 1,
        }
      expect(response.status).to  eq(403)
    end
  end

  describe "update" do
    it "success" do
      put "/dashboard/v1/badges/#{@badge.id}", headers: {Authorization: admin_token.token},
        params: {
          name: "Hello",
          description: "Mbel",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          position: 1,
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:badge][:name]).to  eq("Hello")
      expect(json_response[:data][:badge][:description]).not_to  eq(nil)
    end
  end

  describe "delete" do
    it "success" do
      delete "/dashboard/v1/badges/#{@badge.id}", headers: {Authorization: admin_token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)
    end
  end

end