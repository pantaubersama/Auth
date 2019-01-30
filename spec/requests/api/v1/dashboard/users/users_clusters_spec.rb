require 'rails_helper'

RSpec.describe "Api::V1::Dashboard::UsersClusters", type: :request do
  let!(:user) { FactoryBot.create :user }
  let!(:application) { FactoryBot.create :application }
  let!(:token2) { FactoryBot.create :access_token, :application => application, :resource_owner_id => user.id }

  before do
    @cluster = FactoryBot.create :cluster
    user.make_me_admin!
    user.add_role MODERATOR, @cluster
    
    10.times do
      u = FactoryBot.create :user
      u.make_me_moderator! @cluster
    end
    @user_last = User.last
    User.reindex
  end

  describe "Users" do
    it "List" do
      get "/dashboard/v1/users_clusters", headers: { Authorization: token2.token }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(11)
      expect(json_response[:data][:users][0][:cluster][:id]).to  eq(@cluster.id)
    end

    it "Search by ID" do
      get "/dashboard/v1/users_clusters", headers: { Authorization: token2.token },
        params: {
          ids: [User.last.id, User.first.id].join(", ")
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data][:users].size).to  eq(2)
    end

    it "Search by query" do
      get "/dashboard/v1/users_clusters", headers: { Authorization: token2.token },
        params: {
          q: @user_last.full_name,
          o: "and",
          m: "word"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data].size).to be >= 1
    end

    it "Filter" do
      get "/dashboard/v1/users_clusters", headers: { Authorization: token2.token },
        params: {
          filter_by: "verified_true"
        }
      expect(response.status).to  eq(200)
      expect(json_response[:data].size).to be >= 1
    end

    it "Success" do
      get "/dashboard/v1/users_clusters?ids=&q=&o=&m=&filter_by=", headers: { Authorization: token2.token }
      expect(response.status).to  eq(200)
    end
  end

  describe "pagination" do
    it "paginate searchkick page 1" do
      # total record = 11
      get "/dashboard/v1/users_clusters", headers: { Authorization: token2.token },
        params: {page: 1, per_page: 3}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(4)
      expect(json_response[:data][:meta][:pages][:page]).to eq(1)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(3)
    end

    it "paginate searchkick page 2" do
      # total record = 11
      get "/dashboard/v1/users_clusters", headers: { Authorization: token2.token },
        params: {page: 2, per_page: 3}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(4)
      expect(json_response[:data][:meta][:pages][:page]).to eq(2)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(3)
    end

    it "paginate searchkick page 3" do
      # total record = 11
      get "/dashboard/v1/users_clusters", headers: { Authorization: token2.token },
        params: {page: 3, per_page: 3}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(3)
      expect(json_response[:data][:meta][:pages][:total]).to eq(4)
      expect(json_response[:data][:meta][:pages][:page]).to eq(3)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(3)
    end

    it "paginate searchkick page 4" do
      # total record = 11
      get "/dashboard/v1/users_clusters", headers: { Authorization: token2.token },
        params: {page: 4, per_page: 3}
      expect(response.status).to eq(200)
      expect(json_response[:data][:users].size).to eq(2)
      expect(json_response[:data][:meta][:pages][:total]).to eq(4)
      expect(json_response[:data][:meta][:pages][:page]).to eq(4)
      expect(json_response[:data][:meta][:pages][:per_page]).to eq(3)
    end

  end

end
