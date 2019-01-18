module ApiExtension
  module InternalApi
    module AuthMethods
      attr_accessor :pantau_auth_key

      def internal_endpoint=(internal)
        @internal_endpoint = internal
      end
  
      def internal_endpoint?
        @internal_endpoint || false
      end
  
      def pantau_auth_key
        @_pantau_auth_key
      end
  
      def pantau_auth_key=(key)
        @_pantau_auth_key = key
      end
      
    end
  end
end