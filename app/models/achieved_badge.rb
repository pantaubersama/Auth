class AchievedBadge < ApplicationRecord
  belongs_to :badge
  belongs_to :user, touch: true
  belongs_to :resource, polymorphic: true, optional: true

  validates :badge, uniqueness: { scope: :user }

  after_create :send_notification

  def send_notification
    Publishers::ProfileNotification.publish "pemilu.profile", { 
      receiver_id: user.id, notif_type: :profile, event_type: badge.namespace, badge_title: badge.name 
    }
  end
end
