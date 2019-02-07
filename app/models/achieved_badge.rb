class AchievedBadge < ApplicationRecord
  mount_uploader :image_result, BadgeShareUploader

  belongs_to :badge
  belongs_to :user
  belongs_to :resource, polymorphic: true, optional: true

  validates :badge, uniqueness: { scope: :user }

  after_create :send_notification
  after_create :create_image

  def send_notification
    Publishers::BadgeNotification.publish BADGE_NOTIFICATION, {
      receiver_id: user.id, notif_type: :badge, event_type: badge.event_type, badge_name: badge.name
    }
  end

  def create_image
    AchievedBadgeShareJob.perform_later(self.id)
  end
  
end
