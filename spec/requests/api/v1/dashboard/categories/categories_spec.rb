require 'rails_helper'
RSpec.describe "Api::V1::Dashboard::Categories", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:admin) { FactoryBot.create :user }
  let!(:admin_token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => admin.id }
  let!(:user) { FactoryBot.create :user }
  let!(:user_token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    @category = FactoryBot.create :category
    admin.make_me_admin!
  end

  describe "Authorized" do
    it "authorized" do
      put "/dashboard/v1/categories/#{@category.id}", headers: {Authorization: admin_token.token},
        params: {
          name: "Hello",
          description: "hello bro"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:category][:name]).to  eq("Hello")
      expect(json_response[:data][:category][:description]).to  eq("hello bro")
    end
    it "not authorized" do
      put "/dashboard/v1/categories/#{@category.id}", headers: {Authorization: user_token.token}
      expect(response.status).to  eq(403)
    end
  end

  describe "update" do
    it "success" do
      put "/dashboard/v1/categories/#{@category.id}", headers: {Authorization: admin_token.token},
        params: {
          name: "Hello"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:category][:name]).to  eq("Hello")
      expect(json_response[:data][:category][:description]).not_to  eq(nil)
    end
  end

  describe "delete" do
    it "success" do
      delete "/dashboard/v1/categories/#{@category.id}", headers: {Authorization: admin_token.token}
      expect(response.status).to eq(200)
      expect(json_response[:data][:status]).to eq(true)
    end
  end

end