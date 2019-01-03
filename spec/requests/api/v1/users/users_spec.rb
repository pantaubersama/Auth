require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  before do
    5.times do
      FactoryBot.create :user
    end
    cluster = FactoryBot.create :cluster
    @user = User.last
    @user.make_me_moderator! cluster
  end

  describe "Users" do
    it "List" do
      get "/v1/users", headers: {PantauAuthKey: ENV["PANTAU_AUTH_KEY"]}
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(5)
    end

    it "Search" do
      get "/v1/users", headers: {PantauAuthKey: ENV["PANTAU_AUTH_KEY"]},
        params: {
          ids: [User.last.id, User.first.id].join(", ")
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(2)
    end

    it "Display" do
      get "/v1/users/#{@user.id}", headers: {PantauAuthKey: ENV["PANTAU_AUTH_KEY"]}
      expect(response.status).to  eq(200)
      expect(json_response[:data][:user][:id]).to  eq(@user.id)
      expect(json_response[:data][:user][:cluster]).not_to  eq(nil)
      expect(json_response[:data][:user][:informant]).not_to  eq(nil)
    end

    it "Display full" do
      get "/v1/users/#{@user.id}/full", headers: {PantauAuthKey: ENV["PANTAU_AUTH_KEY"]}
      expect(response.status).to  eq(200)
      expect(json_response[:data][:user][:id]).to  eq(@user.id)
      expect(json_response[:data][:user][:cluster]).not_to  eq(nil)
      expect(json_response[:data][:user][:informant]).not_to  eq(nil)
    end
  end
end