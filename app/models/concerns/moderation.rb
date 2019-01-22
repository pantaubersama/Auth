module Moderation
  extend ActiveSupport::Concern

  included do
    after_create :assign_default_role
  end


  def assign_default_role
    self.add_role(CIVIL) if self.roles.blank?
  end

  # is_moderator? taken by rolify dynamic shortcut
  def is_moderator
    self.roles.where(name: MODERATOR, users_roles: {user_id: self.id}).first.present? ? true : false
  end

  def is_in_cluster?
    cluster.present? ? true : false
  end

  def cluster
    self.roles.where(name: [MODERATOR, MEMBER], users_roles: {user_id: self.id}).first.try(:resource)
  end

  def make_me_admin!
    self.remove_role MODERATOR
    self.remove_role MEMBER
    self.add_role ADMIN
  end

  def remove_admin!
    self.remove_role ADMIN
  end
  

  def make_me_moderator! cluster
    self.remove_role MODERATOR
    self.remove_role MEMBER
    self.add_role MODERATOR, cluster
    cluster.reindex
  end
    
  def add_me_to_cluster! cluster
    self.remove_role MODERATOR
    self.remove_role MEMBER
    self.add_role MEMBER, cluster
    cluster.reindex
  end

  def quit_cluster!
    c = self.cluster
    self.remove_role MODERATOR, self.cluster
    self.remove_role MEMBER, self.cluster
    c.reindex
    return true
  end
  

  class_methods do
    
  end
end