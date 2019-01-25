require 'rails_helper'
RSpec.describe "Api::V1::Dashboard::Home", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:admin) { FactoryBot.create :user }
  let!(:admin_token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => admin.id }
  
  before do
    admin.make_me_admin!
  end

  describe "Poll" do
    it "success" do
      get "/dashboard/v1/home/poll", headers: {Authorization: admin_token.token}
      expect(response.status).to  eq(200)
    end
  end

  describe "Statistics" do
    it "success" do
      get "/dashboard/v1/home/statistics", headers: {Authorization: admin_token.token}
      expect(response.status).to  eq(200)
    end
  end

  describe "User Registration" do
    it "success" do
      get "/dashboard/v1/home/users", headers: {Authorization: admin_token.token}
      expect(response.status).to  eq(200)
    end
  end

end