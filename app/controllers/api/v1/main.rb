require "grape-swagger"
require 'doorkeeper/grape/helpers'

module API
  module V1
    class Main < Grape::API
      # Default Config API
      include API::V1::Config

      helpers Doorkeeper::Grape::Helpers

      use ::WineBouncer::OAuth2

      rescue_from WineBouncer::Errors::OAuthUnauthorizedError do |e|
        error!(e.message + " 401 Unauthorized", 401)
      end
      rescue_from WineBouncer::Errors::OAuthForbiddenError do |e|
        error!("You don't have scope " + e.to_s.gsub("\\n", ", "), 401)
      end

      # Mounting Modules Api
      mount API::V1::Infos::Routes
      mount API::V1::Callback::Routes
      mount API::V1::ValidToken::Routes
      mount API::V1::OnlyStaging::Routes unless Rails.env.production?
      mount Api::V1::Me::Routes
      mount Api::V1::Users::Routes
      mount API::V1::Verifications::Routes

      # Swagger config
      add_swagger_documentation(
        array_use_braces:        true,
        api_version:             'v1',
        doc_version:             'v1',
        hide_documentation_path: true,
        mount_path:              "doc/api",
        hide_format:             true,
        info: {
          title: "Pantau Auth API",
          description: "This API consists of authentication module of Pantau Bersama"
        }
      )
    end
  end
end