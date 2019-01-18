module Api
  module V1
    module Me
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount Api::V1::Me::Resources::Me
        mount Api::V1::Me::Resources::UpdateMe
        mount Api::V1::Me::Resources::Password
      end
    end
  end
end
