require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::UsersClusters", type: :request do
  before do
    10.times do
      FactoryBot.create :user
    end
    @cluster = FactoryBot.create :cluster
    @users = User.all
    @user1 = @users[0].make_me_moderator! @cluster
    @user2 = @users[1].make_me_moderator! @cluster
    @user3 = @users[2].make_me_moderator! @cluster
    @user4 = @users[3].make_me_moderator! @cluster
    @user5 = @users[4].make_me_moderator! @cluster
    @user6 = @users[5].make_me_moderator! @cluster
    @user7 = @users[6].make_me_moderator! @cluster
    @user8 = @users[7].make_me_moderator! @cluster
    @user9 = @users[8].make_me_moderator! @cluster
    @user10 = @users[9].make_me_moderator! @cluster

    @user_last = User.last
  end

  describe "Users" do
    it "List" do
      User.reindex
      get "/dashboard/v1/users_clusters"
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(10)
      expect(json_response[:data][:users][0][:cluster][:id]).to  eq(@cluster.id)
    end

    it "Search by ID" do
      User.reindex
      get "/dashboard/v1/users_clusters",
        params: {
          ids: [User.last.id, User.first.id].join(", ")
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(2)
    end

    it "Search by query" do
      User.reindex
      get "/dashboard/v1/users_clusters",
        params: {
          q: @user_last.full_name,
          o: "and",
          m: "word"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data].size).to be >= 1
    end

    it "Filter" do
      User.reindex
      get "/dashboard/v1/users_clusters",
        params: {
          filter_by: "verified_true"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data].size).to be >= 1
    end

    it "Success" do
      User.reindex
      get "/dashboard/v1/users_clusters?ids=&q=&o=&m=&filter_by="
      expect(response.status).to  eq(200)
    end
  end

  describe "pagination" do
    it "paginate searchkick page 1" do
      User.reindex
      # total record = 10
      get "/dashboard/v1/users_clusters",
        params: {page: 1, per_page: 3}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(4)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(3)
    end

    it "paginate searchkick page 2" do
      User.reindex
      # total record = 10
      get "/dashboard/v1/users_clusters",
        params: {page: 2, per_page: 3}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(4)
      expect(json_response[:data][:meta][:pages][:page]).to eq(2)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(3)
    end

    it "paginate searchkick page 3" do
      User.reindex
      # total record = 10
      get "/dashboard/v1/users_clusters",
        params: {page: 3, per_page: 3}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(4)
      expect(json_response[:data][:meta][:pages][:page]).to eq(3)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(3)
    end

    it "paginate searchkick page 4" do
      User.reindex
      # total record = 10
      get "/dashboard/v1/users_clusters",
        params: {page: 4, per_page: 3}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(1)
      expect(json_response[:data][:meta][:pages][:total]).to eq(4)
      expect(json_response[:data][:meta][:pages][:page]).to eq(4)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(3)
    end

  end

end
