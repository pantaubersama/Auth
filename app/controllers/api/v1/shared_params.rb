module API
  module V1
    module SharedParams
      extend Grape::API::Helpers

      params :optional_access_token do
        optional :access_token, type: String, desc: 'Access Token'
      end

      params :required_access_token do
        optional :access_token, type: String, desc: '[REQUIRED] Access Token', allow_blank: false
      end

    end
  end
end