module Api
  module V1
    module Users
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount Api::V1::Users::Resources::Users
      end
    end
  end
end
