module API
  module V1
    module Challenges
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::Challenges::Resources::Accept
        mount API::V1::Challenges::Resources::Invite
      end
    end
  end
end
