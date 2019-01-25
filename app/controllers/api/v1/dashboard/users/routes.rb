module API::V1::Dashboard::Users
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Dashboard::Users::Resources::Users
    mount API::V1::Dashboard::Users::Resources::UsersClusters
  end
end
