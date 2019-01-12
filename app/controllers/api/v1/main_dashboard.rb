require "grape-swagger"
require 'doorkeeper/grape/helpers'

module API
  module V1
    class MainDashboard < Grape::API
      # Default Config API
      include API::V1::Config

      # Exception Handlers
      include API::V1::ExceptionHandlers

      helpers Doorkeeper::Grape::Helpers
      use ::WineBouncer::OAuth2

      # Mounting Modules Api
      mount API::V1::Dashboard::Clusters::Routes
      mount API::V1::Dashboard::Users::Routes
      mount API::V1::Dashboard::Categories::Routes
      mount API::V1::Dashboard::Badges::Routes

      # Swagger config
      add_swagger_documentation(
          array_use_braces:        true,
          api_version:             'v1',
          doc_version:             'v1',
          hide_documentation_path: true,
          mount_path:              "doc/api",
          hide_format:             true,
          info:                    {
              title:       "Pantau Auth API Dashboard",
              description: "This API consists of user module of Pantau Bersama"
          }
      )
    end
  end
end