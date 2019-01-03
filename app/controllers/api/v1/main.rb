require "grape-swagger"
require 'doorkeeper/grape/helpers'

module API
  module V1
    class Main < Grape::API
      # Default Config API
      include API::V1::Config

      # Exception Handlers
      include API::V1::ExceptionHandlers

      helpers Doorkeeper::Grape::Helpers
      use ::WineBouncer::OAuth2

      # Mounting Modules Api
      mount API::V1::Infos::Routes
      mount API::V1::Callback::Routes
      mount API::V1::ValidToken::Routes
      mount API::V1::OnlyStaging::Routes unless Rails.env.production?
      mount Api::V1::Me::Routes
      mount Api::V1::Users::Routes
      mount API::V1::Verifications::Routes
      mount API::V1::Informants::Routes
      mount API::V1::Badges::Routes
      mount API::V1::Categories::Routes
      mount API::V1::Clusters::Routes
      mount API::V1::Examples::Routes unless Rails.env.production?
      mount API::V1::PoliticalParties::Routes

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