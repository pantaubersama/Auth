module API
  module V1
    module PoliticalParties
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::PoliticalParties::Resources::PoliticalParties
      end
    end
  end
end
