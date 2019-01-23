module API::V1::Dashboard::Verifications
  class Routes < Grape::API
    # Format response
    formatter :json, ::API::SuccessFormatter
    error_formatter :json, ::API::ErrorFormatter

    mount API::V1::Dashboard::Verifications::Resources::Verifications
  end
end
