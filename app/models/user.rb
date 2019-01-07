class User < ApplicationRecord
  # from gems
  rolify strict: true
  acts_as_paranoid
  mount_uploader :avatar, AvatarUploader
  searchkick searchable:  [:full_name, :about],
             word_start:  [:full_name, :about],
             word_middle: [:full_name, :about],
             word_end:    [:full_name, :about],
             word:        [:full_name, :about]

  # from module
  include Moderation

  # validation
  validates_uniqueness_of :username, allow_nil: true
  validates_format_of :username, with: /\A[a-zA-Z0-9_]+\z/i, message: "can only contain letters, underscore, and numbers.", allow_nil: true

  # association
  has_one :verification
  has_one :informant
  has_many :achieved_badges
  has_many :badges, through: :achieved_badges
  has_many :firebase_keys
  belongs_to :political_party, optional: true

  # callback
  after_create :build_verification_model
  after_create :build_informant_model

  def search_data
    # Api::V1::Me::Entities::UserSimple
    {
      id:         self.id,
      email:      self.email,
      full_name:  self.full_name,
      username:   self.username,
      avatar:     self.avatar,
      verified:   self.verified,
      about:      self.about,
      created_at: self.created_at
    }
  end

  def invite_to_symbolic(u, invite_code)
    api    = Ruby::Identitas::Main.new nil, ENV["AUTH_KEY"]
    result = api.user_invite({ email: u.email, invite_code: invite_code }).parsed_response
  end

  def verified
    verification.is_verified?
  end

  def build_informant_model
    Informant.find_or_create_by(user: self)
  end

  def build_verification_model
    Verification.find_or_create_by(user: self)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email     = auth.info.email
      user.full_name = [auth.info.first_name, auth.info.last_name]

      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def is_admin
    is_admin?
  end

  def generate_access_token scopes = ""
    app          = Doorkeeper::Application.first
    access_token = Doorkeeper::AccessToken.create!({
                                                     :application_id    => app.id,
                                                     :resource_owner_id => self.id,
                                                     :scopes            => scopes,
                                                     :expires_in        => Doorkeeper.configuration.access_token_expires_in,
                                                     :use_refresh_token => Doorkeeper.configuration.refresh_token_enabled?
                                                   })
    response     = Doorkeeper::OAuth::TokenResponse.new(access_token)
    response.token
  end
end
