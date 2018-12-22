module API
  module V1
    module OnlyStaging
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::OnlyStaging::Resources::RoleChanger
      end
    end
  end
end
