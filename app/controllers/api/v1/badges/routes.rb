module API::V1::Badges
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Badges::Resources::Badges
    mount API::V1::Badges::Resources::AchievedBadges
    mount API::V1::Badges::Resources::BadgesInternal
  end
end