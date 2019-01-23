class Badge < ApplicationRecord
  mount_uploader :image, BadgeUploader
  mount_uploader :image_gray, BadgeGrayUploader
  acts_as_paranoid

  validates_presence_of :name
  validates :code, uniqueness: { scope: :namespace }

  scope :visible, -> { where(hidden: false) }
  has_many :achieved_badges
  has_many :users, through: :achieved_badges
end
