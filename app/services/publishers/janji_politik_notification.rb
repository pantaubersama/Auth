module Publishers
  class JanjiPolitikNotification < ApplicationPublisher

    def self.publish exchange, message = {}
      # endpoint: Publishers::JanjiPolitikNotification.publish exchange, message
      #  - exchange: "pemilu.janji_politik"
      #  - message:
      #         - {count: 100, notif_type: :janji_politik, event_type: :report }

      push exchange, message, :notification
    end
  end
end