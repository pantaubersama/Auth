class Verification < ApplicationRecord
  enum status: [:requested, :verified, :rejected]

  belongs_to :user, touch: true

  mount_uploader :ktp_selfie, AvatarUploader
  mount_uploader :ktp_photo, AvatarUploader
  mount_uploader :signature, AvatarUploader

  after_save :send_notification

  def is_verified?
    verified?
  end

  def step
    return 4 if ktp_number? && ktp_selfie? && ktp_photo? && signature?
    return 3 if ktp_number? && ktp_selfie? && ktp_photo?
    return 2 if ktp_number? && ktp_selfie?
    return 1 if ktp_number?
  end

  def send_notification
    if status == "rejected"
      Publishers::BadgeNotification.publish PROFILE_NOTIFICATION, {
        receiver_id: user.id, notif_type: :profile, event_type: :gagal_verifikasi
      }
    elsif status == "verified"
      Publishers::BadgeNotification.publish PROFILE_NOTIFICATION, {
        receiver_id: user.id, notif_type: :profile, event_type: :berhasil_verifikasi
      }
    end
  end


end
