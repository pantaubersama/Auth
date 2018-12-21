module API
  module V1
    module ValidToken
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::ValidToken::Resources::ValidToken
      end
    end
  end
end
