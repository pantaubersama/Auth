module API
  module V1
    module Dashboard
      module Badges
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Dashboard::Badges::Resources::Badges
        end
      end
    end
  end
end
