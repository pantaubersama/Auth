class Account < ApplicationRecord
  belongs_to :user
  after_save :reload_user

  enum account_type: [:twitter, :facebook]

  def self.connect! user_id, tipe, token, secret = ""
    a = self.where(account_type: tipe.to_sym, user_id: user_id).first_or_initialize
    case tipe.to_s
    when "twitter"
      a.connect_twitter token, secret
    when "facebook"
      a.connect_facebook token
    else
      nil
    end
    a 
  end

  def connect_twitter token, secret
    api = TwitterApi::Main.new token, secret
    self.update_attributes!({
      access_token: token, access_token_secret: secret,
      uid: api.credentials.id,
      email: api.credentials.email,
    }) if api.valid?
    self.user
  end

  def connect_facebook token
    api = FacebookApi::Main.new token
    self.update_attributes!({
      access_token: token,
      uid: api.credentials["id"],
      email: api.credentials["email"]
    }) if api.valid?
  end

  def disconnect! tipe
    case tipe.to_s
    when "twitter"
      disconnect_twitter
    when "facebook"
      disconnect_facebook
    else
      nil
    end
  end

  def disconnect_twitter
    api = TwitterApi::Main.new self.access_token, self.access_token_secret
    api.invalidate self.access_token
    u = self.user
    self.destroy!
    u
  end

  def disconnect_facebook
    api = FacebookApi::Main.new self.access_token
    api.invalidate self.access_token, self.uid
    u = self.user
    self.destroy!
    u
  end

  private
  def reload_user
    user.publish_changes
  end
end
