class Authentication < ActiveRecord::Base
  belongs_to :user
  def self.from_omniauth(auth, user)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |authentication|
      authentication.provider = auth.provider
      authentication.uid = auth.uid
      authentication.oauth_token = auth.credentials.token
      authentication.user = user
    end
  end
end
