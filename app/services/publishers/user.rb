module Publishers
  class User < ApplicationPublisher

    def self.publish routing_key, message = {}
      # endpoint: Publishers::User.publish QUEUE_USER_CHANGED, message
      #  - routing_key: QUEUE_USER_CHANGED
      #  - message:
      #         - {id: UUID}
      push routing_key, message
    end
  end
end