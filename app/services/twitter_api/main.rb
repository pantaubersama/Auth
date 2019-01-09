module TwitterApi
  class Main
    attr_accessor :client

    TW_CONSUMER_KEY = ENV["TW_CONSUMER_KEY"]
    TW_CONSUMER_SECRET = ENV["TW_CONSUMER_SECRET"]

    def initialize token, secret
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = TW_CONSUMER_KEY
        config.consumer_secret     = TW_CONSUMER_SECRET
        config.access_token        = token
        config.access_token_secret = secret
      end
    end

    def valid?
      credentials.present?
    end

    def credentials
      @client.verify_credentials({include_email: true})
    end

    def tweet status
      @client.update status
    end
    
    def invalidate token
      r = Twitter::REST::Request.new @client, "post", "/1.1/oauth/invalidate_token.json"
      r.perform
    end
    

  end
end