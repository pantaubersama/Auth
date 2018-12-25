module ApiExtension
  module InternalApi
    class InvalidApiKey < StandardError
      def initialize msg = "Invalid Api key"
        super
      end
    end
  end
end