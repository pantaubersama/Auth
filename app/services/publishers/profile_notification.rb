module Publishers
  class ProfileNotification < ApplicationPublisher

    def self.publish exchange, message = {}
      # endpoint: Publishers::ProfileNotification.publish exchange, message
      #  - exchange: "pemilu.profile"
      #  - message:
      #         - {receiver_id: UUID, notif_type: :profile, event_type: :gagal_verifikasi }
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :berhasil_verifikasi }
      #         - { reciver_id: UUID, cluster_id: UUID, notif_type: :profile, event_type: :claster_approved }
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :claster_rejected }
      #         - { reciver_id: UUID, user_action_id: UUID, cluster_id: UUID, notif_type: :profile, event_type: :cluster_invited }

      # grab the fanout exchange
      push exchange, message
    end
  end
end
