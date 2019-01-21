module Publishers
  class User < ApplicationPublisher

    def self.publish exchange, message = {}
      # endpoint: Publishers::User.publish exchange, message
      #  - exchange: "user.changed""
      #  - message:
      #         - {id: UUID}
      push exchange, message, :auth
    end
  end
end