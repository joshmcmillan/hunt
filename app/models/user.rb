class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:facebook]

  has_many :hunts, through: :hunt_users
  has_many :locations, as: :locatable

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, provider_uid: auth.uid).first_or_initialize.tap do |user|
      user.provider     = auth.provider
      user.provider_uid = auth.uid
      user.email        = auth.info.email
      user.password     = Devise.friendly_token[0,20]
      user.first_name   = auth.info.first_name
      user.last_name    = auth.info.last_name
      user.save!
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def avatar
    return nil if provider != 'facebook'

    "//graph.facebook.com/#{provider_uid}/picture"
  end 
end
