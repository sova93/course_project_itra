class User < ApplicationRecord

  has_many :instructions, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook, :vkontakte, :twitter, :google_oauth2]

  enum role: [:member, :admin]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :member
  end

  def self.is_signed_in?
    is_signed_in?
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.oauth_data"] && session["devise.oauth_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def is_email_used_different_provider
    return User.where(email: self.email).where.not(provider: self.provider).size
end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.skip_confirmation!
    end
  end
  end
