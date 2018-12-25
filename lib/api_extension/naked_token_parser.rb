module ApiExtension
  module NakedTokenParser
    def self.call(request)
      auth = request.authorization
      auth
    end
  end
end