module API
  class InitDashboard < Grape::API
    # Create log in console
    if ENV['API_DEBUGGING'].eql?("true")
      insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger, {
          logger:  Logger.new(STDERR),
          filter:  Class.new {
            def filter(opts)
              opts.reject { |k, _| k.to_s == 'password' }
            end }.new,
          headers: %w(version cache-control)
      }
    end
    # Build params using object
    include Grape::Extensions::Hashie::Mash::ParamBuilder

    # use middleware
    use ::ApiExtension::InternalApi::Middleware

    mount API::V1::MainDashboard

    GrapeSwaggerRails.options.app_url            = "/dashboard/v1/doc"
    GrapeSwaggerRails.options.url                = "/api"
    GrapeSwaggerRails.options.hide_url_input     = false
    GrapeSwaggerRails.options.hide_api_key_input = true
  end
end