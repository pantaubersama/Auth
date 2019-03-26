class Wordstadium::Challenge < ApplicationRecord
  attr_accessor :type, :invitation_id

  before_create :check_type

  def check_type
    self.twitter_uid = self.invitation_id if self.type == "twitter"
    self.user_id = self.invitation_id if self.type == "user"
  end

  def type
    twitter_uid.present? ? "twitter" : "user"
  end

  def invitation_id
    twitter_uid.present? ? twitter_uid : user_id
  end

  def check! cu
    if self.type == "twitter"
      self.twitter_uid.to_s == cu.accounts.twitter.last.uid.to_s
    else
      self.user_id.to_s == cu.id.to_s
    end
  end

  def accept!
    # hit endpoint accept wordstadium

    update_attributes!(accepted_at: Time.now.utc)
  end

  def accepted?
    accepted_at
  end

end
