module API
  module V1
    module Verifications
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::Verifications::Resources::Verifications
      end
    end
  end
end
