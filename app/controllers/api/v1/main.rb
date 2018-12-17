require "grape-swagger"
module API
  module V1
    class Main < Grape::API
      # Default Config API
      include API::V1::Config

      # Mounting Modules Api
      mount API::V1::Adventures::Routes
      mount API::V1::Infos::Routes

      # Swagger config
      add_swagger_documentation(
          api_version:             'not set',
          doc_version:             'not set',
          hide_documentation_path: true,
          mount_path:              "doc/api",
          hide_format:             true
      )
    end
  end
end