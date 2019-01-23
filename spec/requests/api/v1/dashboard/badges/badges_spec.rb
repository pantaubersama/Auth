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
          namespace: "badge_pantau_bersama",
          code: Faker::Lorem.sentence(2)
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:badge][:name]).to  eq("Hello")
      expect(json_response[:data][:badge][:description]).to  eq("hello bro")
      expect(json_response[:data][:badge][:image][:url]).not_to  eq(nil)
      expect(json_response[:data][:badge][:image_gray][:url]).to  eq(nil)
    end
    it "not authorized" do
      put "/dashboard/v1/badges/#{@badge.id}", headers: {Authorization: user_token.token},
        params: {
          name: "Hello",
          description: "hello bro",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          position: 1,
          namespace: "badge_pantau_bersama",
          code: Faker::Lorem.sentence(2)
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
          image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          position: 1,
          namespace: "badge_pantau_bersama",
          code: Faker::Lorem.sentence(2)
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:badge][:name]).to  eq("Hello")
      expect(json_response[:data][:badge][:description]).not_to  eq(nil)
      expect(json_response[:data][:badge][:image][:url]).not_to  eq(nil)
      expect(json_response[:data][:badge][:image_gray][:url]).not_to  eq(nil)
    end
  end

  describe "create" do
    it "success" do
      post "/dashboard/v1/badges", headers: {Authorization: admin_token.token},
        params: {
          name: "Hello",
          description: "Mbel",
          image: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          image_gray: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/images/html.png'))),
          position: 1,
          namespace: "badge_pantau_bersama",
          code: Faker::Lorem.sentence(2)
        }
      expect(response.status).to  eq(201)
      expect(json_response[:data][:badge][:name]).to  eq("Hello")
      expect(json_response[:data][:badge][:description]).not_to  eq(nil)
    end
  end

  describe "grant badge to user" do
    it "success" do
      post "/dashboard/v1/badges/#{@badge.id}/grant", headers: {Authorization: admin_token.token},
        params: {
          user_id: user.id
        }
      expect(response.status).to eq(201)
      expect(json_response[:data][:badge][:id]).to eq(@badge.id)
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