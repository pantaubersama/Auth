module FacebookApi
  class Main
    attr_accessor :client

    def initialize token
      @client = Koala::Facebook::API.new(token)
    end

    def valid?
      credentials.present?
    end

    def credentials
      @client.get_object("me", fields:'email')
    end

    def invalidate token, user_id
      @client.delete_object("/#{user_id}/permissions")
    end

  end
end