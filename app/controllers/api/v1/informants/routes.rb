module API
  module V1
    module Informants
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::Informants::Resources::Informants
      end
    end
  end
end
