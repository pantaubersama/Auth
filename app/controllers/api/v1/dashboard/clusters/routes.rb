module API::V1::Dashboard::Clusters
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Dashboard::Clusters::Resources::Clusters
  end
end
