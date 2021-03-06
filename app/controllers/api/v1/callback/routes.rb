module API
  module V1
    module Callback
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::Callback::Resources::AccessToken
        mount API::V1::Callback::Resources::Invitation
      end
    end
  end
end
