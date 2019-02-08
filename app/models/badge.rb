class Badge < ApplicationRecord
  mount_uploader :image, BadgeUploader
  mount_uploader :image_gray, BadgeGrayUploader
  acts_as_paranoid

  validates_presence_of :name
  validates :code, uniqueness: { scope: :namespace }

  scope :visible, -> { where(hidden: false) }
  has_many :achieved_badges
  has_many :users, through: :achieved_badges

  def event_type
    #  Badge.all.map{|b| b.update_attribute(:namespace, b.namespace.split("_").delete_if {|x| x == "badge" }.join("_"))  if b.namespace.present?}
    namespace
  end
end
