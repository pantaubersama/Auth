class API::V1::Dashboard::Home::Resources::Summary < API::V1::ApplicationResource
  helpers API::V1::Helpers

  before do
    authorize_admin!
  end

  resource "home" do

    desc "Poll" do
      detail "Poll percentage Jokowi / Prabowo"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/poll" do
      total = User.all.count
      grouped = User.group(:vote_preference).count
      present :preference, {total: total, grouped: grouped}, with: API::V1::Dashboard::Home::Entities::Poll
    end

    desc "Statistics" do
      detail "Statistics"
      headers AUTHORIZATION_HEADERS
    end
    oauth2
    get "/statistics" do
      present :users, User.all.count
      present :clusters, Cluster.all.count
    end

  end

end
