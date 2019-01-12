module API
  module V1
    module Dashboard
      module PoliticalParties
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Dashboard::PoliticalParties::Resources::PoliticalParties
        end
      end
    end
  end
end
