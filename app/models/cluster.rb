class Cluster < ApplicationRecord
  resourcify
  mount_uploader :image, ClusterUploader

  belongs_to :category, optional: true
  belongs_to :requester, optional: true, class_name: "User"
  scope :visible, -> { where(is_displayed: true) }

  validates_presence_of :name

  def approve!
    self.update_attribute(:is_displayed, true)
    self.requester.remove_role MODERATOR
    self.requester.remove_role MEMBER
    self.requester.add_role MODERATOR, self
  end
  
end
