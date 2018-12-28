module API
  module V1
    module Categories
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::Categories::Resources::CategoriesInternal
        mount API::V1::Categories::Resources::Categories
      end
    end
  end
end
