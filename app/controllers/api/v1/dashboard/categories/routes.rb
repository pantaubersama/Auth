module API
  module V1
    module Dashboard
      module Categories
        class Routes < Grape::API
          # Format response
          formatter :json, ::API::SuccessFormatter
          error_formatter :json, ::API::ErrorFormatter

          mount API::V1::Dashboard::Categories::Resources::Categories
        end
      end
    end
  end
end
