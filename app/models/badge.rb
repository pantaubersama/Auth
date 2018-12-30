class Badge < ApplicationRecord
  mount_uploader :image, BadgeUploader
  acts_as_paranoid

  validates_presence_of :name

  scope :visible, -> { where(hidden: false) }
  has_many :achieved_badges
  has_many :users, through: :achieved_badges
end
