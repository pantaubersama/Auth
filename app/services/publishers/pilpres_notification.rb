module Publishers
  class PilpresNotification < ApplicationPublisher

    def self.publish exchange, message = {}
      # endpoint: Publishers::PilpresNotification.publish exchange, message
      #  - exchange: "pemilu.pilpres"
      #  - message:
      #         - {count: 100, notif_type: :feed, event_type: :report }
      push exchange, message, :notification
    end
  end
end