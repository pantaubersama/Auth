class Verification < ApplicationRecord
  enum status: [:requested, :verified, :rejected]

  belongs_to :user, touch: true

  mount_uploader :ktp_selfie, AvatarUploader
  mount_uploader :ktp_photo, AvatarUploader
  mount_uploader :signature, AvatarUploader

  def is_verified?
    verified?
  end

  def step
    return 4 if ktp_number? && ktp_selfie? && ktp_photo? && signature?
    return 3 if ktp_number? && ktp_selfie? && ktp_photo?
    return 2 if ktp_number? && ktp_selfie? 
    return 1 if ktp_number?
  end
  
  
end
