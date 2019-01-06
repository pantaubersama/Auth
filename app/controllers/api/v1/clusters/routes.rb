module API
  module V1
    module Clusters
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::Clusters::Resources::Moderations
        mount API::V1::Clusters::Resources::Clusters
      end
    end
  end
end
