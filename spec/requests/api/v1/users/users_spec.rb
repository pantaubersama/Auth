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
      User.reindex
      get "/v1/users"
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(5)
    end

    it "Search by ID" do
      User.reindex
      get "/v1/users",
        params: {
          ids: [User.last.id, User.first.id].join(", ")
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(2)
    end

    it "Search by query" do
      User.reindex
      get "/v1/users",
        params: {
          q: @user.full_name,
          o: "and",
          m: "word"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data].size).to be >= 1
    end

    it "Filter" do
      User.reindex
      get "/v1/users",
        params: {
          filter_by: "verified_true"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data].size).to be >= 1
    end

    it "Success" do
      User.reindex
      get "/v1/users?ids=&q=&o=&m=&filter_by="
      expect(response.status).to  eq(200)
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

    it "Display simple" do
      get "/v1/users/#{@user.id}/simple"
      expect(response.status).to  eq(200)
      expect(json_response[:data][:user][:id]).to  eq(@user.id)
      expect(json_response[:data][:user][:cluster]).to  eq(nil)
      expect(json_response[:data][:user][:informant]).to  eq(nil)
    end
  end
end