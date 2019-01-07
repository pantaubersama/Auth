class Cluster < ApplicationRecord
  resourcify
  mount_uploader :image, ClusterUploader

  belongs_to :category, optional: true
  belongs_to :requester, optional: true, class_name: "User"
  belongs_to :creator, optional: true, class_name: "User"
  
  scope :visible, -> { where(status: :approved) }
  
  enum status: { requested: 0, approved: 1, rejected: 2 }
  
  validates_presence_of :name

  after_create :create_magic_link

  def create_magic_link
    begin
      code = SecureRandom.hex(6)
    end while Cluster.find_by(magic_link: code).present?
    self.magic_link = code
    self.save(validate: false)
  end
  

  def approve!
    self.update_attributes(is_displayed: true, status: 1)
    if self.requester
      self.requester.remove_role MODERATOR
      self.requester.remove_role MEMBER
      self.requester.add_role MODERATOR, self
    end
  end

  def reject!
    self.update_attributes(is_displayed: false, status: 3)
  end

  def members_count
    Role.where(resource: self).map { |x| x.users.count }.reduce(:+) || 0
  end

  def increase_referal
    self.with_lock do
      self.referal_count += 1
      self.save(validate: false)
    end
  end

  def decrease_referal
    self.with_lock do
      self.referal_count += - 1
      self.save(validate: false)
    end if self.referal_count > 0
  end
  

end
