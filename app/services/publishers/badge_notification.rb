module Publishers
  class BadgeNotification < ApplicationPublisher

    def self.publish exchange, message = {}
      # endpoint: Publishers::BadgeNotification.publish exchange, message
      #  - exchange: "pemilu.badge"
      #  - message:
      #         - { reciver_id: UUID, notif_type: :badge, event_type: :tanya, badge_id: "UUID"a }
      #         - { reciver_id: UUID, notif_type: :badge, event_type: :kuis, badge_id: "UUID" }
      #         - { reciver_id: UUID, notif_type: :badge, event_type: :lapor, badge_id: "UUID" }
      #         - { reciver_id: UUID, notif_type: :badge, event_type: :janji_politi, badge_id: "UUID" }
      #         - { reciver_id: UUID, notif_type: :badge, event_type: :tanya_interaksi, badge_id: "UUID" }
      #         - { reciver_id: UUID, notif_type: :badge, event_type: :profile, badge_id: "UUID" }
      #         - { reciver_id: UUID, notif_type: :badge, event_type: :relawan, badge_id: "UUID" }
      #         - { reciver_id: UUID, notif_type: :badge, event_type: :pantau_bersama, badge_id: "UUID" }

      # grab the fanout exchange
      push exchange, message
    end
  end
end
