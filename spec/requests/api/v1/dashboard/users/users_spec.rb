require 'rails_helper'
RSpec.describe "Api::V1::Dashboard::Clusters", type: :request do
  let!(:application) { FactoryBot.create :application }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user }
  let!(:user3) { FactoryBot.create :user }
  let!(:token) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }
  let!(:token2) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user2.id }

  before do
    user.make_me_admin!
  end

  describe "not authorized" do
    it "cannot access" do
      post "/dashboard/v1/users/admin",
           params:  {
             id: user3.id,
           },
           headers: { Authorization: token2.token }

      expect(response.status).to eq(403)
    end
  end

  describe "authorized" do
    it "make admin" do
      post "/dashboard/v1/users/admin",
        params:  {
          id: user3.id,
        },
        headers: { Authorization: token.token }

      expect(response.status).to eq(201)
      expect(json_response[:data][:user][:is_admin]).to eq(true)
    end

    it "remove admin" do
      post "/dashboard/v1/users/admin",
        params:  {
          id: user3.id,
        },
        headers: { Authorization: token.token }

      delete "/dashboard/v1/users/admin",
        params:  {
          id: user3.id,
        },
        headers: { Authorization: token.token }

      expect(response.status).to eq(200)
      expect(json_response[:data][:user][:is_admin]).to eq(false)
    end

    it "list user verification" do
      pending "add some examples to (or delete) #{__FILE__}"
    end
    it "update user detail" do
      pending "add some examples to (or delete) #{__FILE__}"
    end
    it "Update user informant" do
      pending "add some examples to (or delete) #{__FILE__}"
    end
    it "Update avatar" do
      pending "add some examples to (or delete) #{__FILE__}"
    end
    it "show user verification" do
      pending "add some examples to (or delete) #{__FILE__}"
    end
  end

end