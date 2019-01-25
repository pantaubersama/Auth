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

    desc "User registrations chart" do
      detail "User registrations chart"
      headers AUTHORIZATION_HEADERS
    end
    params do
      optional :month_from, values: (1..12).to_a, type: Integer
      optional :year_from, values: (2018..2024).to_a, type: Integer
      optional :month_to, values: (1..12).to_a, type: Integer
      optional :year_to, values: (2018..2024).to_a, type: Integer
    end
    oauth2
    get "/users" do
      res = User.all
      if params.month_from.present? && params.year_from.present?
        res = res.where("created_at >= ?", Date.new(params.year_from, params.month_from, 1).to_s) 
      end
      if params.month_to.present? && params.year_to.present?
        res = res.where("created_at <= ?", Date.civil(params.year_to, params.month_to, -11).to_s)
      end
      data = res.group_by_month(:created_at, format: "%b %Y").count
      present data
    end

  end

end
