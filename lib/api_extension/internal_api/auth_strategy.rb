module ApiExtension
  module InternalApi
    class AuthStrategy
      attr_accessor :api_context

      def internal_endpoint?
        api_context.options[:route_options][:internal]
      end

    end
  end
end