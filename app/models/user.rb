class User < ApplicationRecord
  # from gems
  rolify strict: true
  acts_as_paranoid
  mount_uploader :avatar, AvatarUploader

  # from module
  include Moderation

  # validation
  validates_uniqueness_of :username, allow_nil: true
  validates_format_of :username, with: /\A[a-zA-Z0-9_]+\z/i, message: "can only contain letters, underscore, and numbers.", allow_nil: true

  # association
  has_one :verification

  # callback
  after_create :build_verification_model

  def build_verification_model
    Verification.find_or_create_by(user: self)
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def generate_access_token scopes = ""
    app = Doorkeeper::Application.first
    access_token = Doorkeeper::AccessToken.create!({
      :application_id     => app.id,
      :resource_owner_id  => self.id,
      :scopes             => scopes,
      :expires_in         => Doorkeeper.configuration.access_token_expires_in,
      :use_refresh_token  => Doorkeeper.configuration.refresh_token_enabled?
    })
    response = Doorkeeper::OAuth::TokenResponse.new(access_token)
    response.token
  end
end
