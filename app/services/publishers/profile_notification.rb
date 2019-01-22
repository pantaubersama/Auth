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
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :badge_tany, badge_title: "badge_1"a }
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :badge_kuis, badge_title: "badge_1" }
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :badge_lapor, badge_title: "badge_1" }
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :janji_politi, badge_title: "badge_1"k }
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :tanya_interaksi, badge_title: "badge_1" }
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :badge_profile, badge_title: "badge_1" }
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :badge_relawan, badge_title: "badge_1" }
      #         - { reciver_id: UUID, notif_type: :profile, event_type: :pantau_bersama, badge_title: "badge_1" }


      # grab the fanout exchange
      push exchange, message, :notification
    end
  end
end