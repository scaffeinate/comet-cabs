class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :authentications
  has_many :bookings
  has_many :payments

  mount_uploader :avatar, AvatarUploader

  def self.find_for_oauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      user.update_attribute(:remote_avatar_url, auth.info.image.gsub('http://', 'https://'))
    else
      user = User.create(name: auth.info.name, email: auth.info.email,
                         password: Devise.friendly_token[0, 20], remote_avatar_url: auth.info.image.gsub('http://', 'https://'))
    end
    user
  end
end
