require "grape-swagger"
module API
  module V1
    class Main < Grape::API
      use Grape::Middleware::Logger, {
          logger: Logger.new(STDERR)
      }
      mount API::V1::HelloWorlds::Routes

      # swagger settings
      options = {version: "v1"}
      GrapeSwaggerRails.options.app_url            = "/#{options[:version]}/documentation"
      GrapeSwaggerRails.options.url                = "/doc"
      GrapeSwaggerRails.options.hide_api_key_input = true
      add_swagger_documentation(
          api_version:             options[:version],
          doc_version:             options[:version],
          hide_documentation_path: true,
          mount_path:              "documentation/doc",
          hide_format:             true
      )
    end
  end
end