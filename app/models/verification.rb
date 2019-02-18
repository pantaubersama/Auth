class Verification < ApplicationRecord
  acts_as_paranoid

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

  def reset! new_step
    requested!
    case new_step
    when 1
      update_attributes({ktp_number: nil})
      remove_ktp_selfie!
      remove_ktp_photo!
      remove_signature!
    when 2
      remove_ktp_selfie!
      remove_ktp_photo!
      remove_signature!
    when 3
      remove_ktp_photo!
      remove_signature!
    when 4
      remove_signature!
    else
    end
    self.save!
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
