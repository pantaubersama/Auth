module API
  class InitOauth < Grape::API

    mount API::V1::Oauth

    GrapeSwaggerRails.options.app_url            = "/doc"
    GrapeSwaggerRails.options.url                = "/oauth"
    GrapeSwaggerRails.options.hide_url_input     = false
    GrapeSwaggerRails.options.hide_api_key_input = true
  end
end