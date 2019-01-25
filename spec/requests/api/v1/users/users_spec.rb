require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  before do
    5.times do
      FactoryBot.create :user
    end
    @cluster = FactoryBot.create :cluster
    @user = User.last
    @user.make_me_moderator! @cluster
  end

  describe "Users" do
    it "List" do
      User.reindex
      get "/v1/users"
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(5)
      expect(json_response[:data][:users][0][:cluster][:id]).to  eq(@cluster.id)
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
      expect(json_response[:data][:user][:cluster][:id]).to  eq(@cluster.id)
      expect(json_response[:data][:user][:informant]).to  eq(nil)
    end
  end

  describe "pagination" do
    it "paginate searchkick page 1" do
      8.times do
        FactoryBot.create :user
      end
      User.reindex
      # total record = 13
      get "/v1/users",
        params: {page: 1, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 2" do
      8.times do
        FactoryBot.create :user
      end
      User.reindex
      # total record = 13
      get "/v1/users",
        params: {page: 2, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(2)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 3" do
      8.times do
        FactoryBot.create :user
      end
      User.reindex
      # total record = 13
      get "/v1/users",
        params: {page: 3, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(3)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 4" do
      8.times do
        FactoryBot.create :user
      end
      User.reindex
      # total record = 13
      get "/v1/users",
        params: {page: 4, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(0)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(4)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end
  end

  describe "Users Clusters" do
    it "List" do
      User.reindex
      get "/v1/users_clusters"
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(5)
      expect(json_response[:data][:users][0][:cluster][:id]).to  eq(@cluster.id)
    end

    it "Search by ID" do
      User.reindex
      get "/v1/users_clusters",
        params: {
          ids: [User.last.id, User.first.id].join(", ")
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(2)
    end

    it "Search by query" do
      User.reindex
      get "/v1/users_clusters",
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
      get "/v1/users_clusters",
        params: {
          filter_by: "verified_true"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data].size).to be >= 1
    end

    it "Success" do
      User.reindex
      get "/v1/users_clusters?ids=&q=&o=&m=&filter_by="
      expect(response.status).to  eq(200)
    end

  end

  describe "pagination" do
    it "paginate searchkick page 1" do
      8.times do
        FactoryBot.create :user
      end
      User.reindex
      # total record = 13
      get "/v1/users_clusters",
        params: {page: 1, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 2" do
      8.times do
        FactoryBot.create :user
      end
      User.reindex
      # total record = 13
      get "/v1/users_clusters",
        params: {page: 2, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(5)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(2)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 3" do
      8.times do
        FactoryBot.create :user
      end
      User.reindex
      # total record = 13
      get "/v1/users_clusters",
        params: {page: 3, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(3)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end

    it "paginate searchkick page 4" do
      8.times do
        FactoryBot.create :user
      end
      User.reindex
      # total record = 13
      get "/v1/users_clusters",
        params: {page: 4, per_page: 5}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(0)
      expect(json_response[:data][:meta][:pages][:total]).to eq(3)
      expect(json_response[:data][:meta][:pages][:page]).to eq(4)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(5)
    end
  end

end