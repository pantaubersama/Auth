module ApiExtension
  module InternalApi
    module Extension
      
      def internal(*scopes)
        description = if respond_to?(:route_setting) # >= grape-0.10.0
          route_setting(:description) || route_setting(:description, {})
        else
          @last_description ||= {}
        end
        description[:internal] = true
      end
  
      Grape::API.extend self
    end
  end
end