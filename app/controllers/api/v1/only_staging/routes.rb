module API
  module V1
    module OnlyStaging
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::OnlyStaging::Resources::RoleChanger
        mount API::V1::OnlyStaging::Resources::VerificationChanger
        mount API::V1::OnlyStaging::Resources::Badges
        mount API::V1::OnlyStaging::Resources::Clusters
        mount Api::V1::OnlyStaging::Resources::Token
      end
    end
  end
end
