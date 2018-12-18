module API
  module V1
    module SecureAdventures
      class Routes < Grape::API
        # Format response
        formatter :json, ::API::SuccessFormatter
        error_formatter :json, ::API::ErrorFormatter

        mount API::V1::SecureAdventures::Resources::SecureAdventures
      end
    end
  end
end
