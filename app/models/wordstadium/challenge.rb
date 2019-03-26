class Wordstadium::Challenge < ApplicationRecord
  attr_accessor :type, :invitation_id

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
    wordstadium = nil

    s = update_attributes!(accepted_at: Time.now.utc, invite_code: nil)

    [s, wordstadium]
  end

  def accepted?
    accepted_at
  end

end
