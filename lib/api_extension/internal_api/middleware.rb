require 'rack/auth/abstract/request'

module ApiExtension
  module InternalApi
    class Middleware < Grape::Middleware::Base
      attr_reader :auth_strategy

      def context
        env['api.endpoint']
      end

      def internal_endpoint?
        auth_strategy.internal_endpoint?
      end

      def the_request=(env)
        @_the_request = ActionDispatch::Request.new(env)
      end
  
      def request
        @_the_request
      end

      def given_key
        request.headers["PantauAuthKey"] rescue nil
      end


      def check_api_key!
        raise InvalidApiKey unless given_key == ENV["PANTAU_AUTH_KEY"]
      end
      
  
      def before
        set_auth_strategy
        auth_strategy.api_context = context
        
        context.extend(ApiExtension::InternalApi::AuthMethods)

        context.internal_endpoint = internal_endpoint?
        return unless context.internal_endpoint?
        
        context.pantau_auth_key = given_key
        self.the_request = env
        
        check_api_key!
      end

      def set_auth_strategy
        @auth_strategy = ApiExtension::InternalApi::AuthStrategy.new
      end
      
    end
  end
end