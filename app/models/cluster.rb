class Cluster < ApplicationRecord
  resourcify
  mount_uploader :image, ClusterUploader

  belongs_to :category, optional: true
  belongs_to :requester, optional: true, class_name: "User"
  belongs_to :creator, optional: true, class_name: "User"
  scope :visible, -> { where(status: :approved) }
  enum status: { requested: 0, approved: 1, rejected: 2 }
  validates_presence_of :name

  def approve!
    self.update_attributes(is_displayed: true, status: 1)
    self.requester.remove_role MODERATOR
    self.requester.remove_role MEMBER
    self.requester.add_role MODERATOR, self
  end

  def reject!
    self.update_attributes(is_displayed: false, status: 3)
  end

  def members_count
    Role.where(resource: self).map { |x| x.users.count }.reduce(:+) || 0
  end

end
