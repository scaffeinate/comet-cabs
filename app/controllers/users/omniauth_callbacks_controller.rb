class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    authenticate_user(:facebook)
  end

  def google_oauth2
    authenticate_user(:google)
  end

  private

  def authenticate_user(_provider)
    auth = request.env['omniauth.auth']
    user = User.find_for_oauth(auth)
    authentication = Authentication.from_omniauth(auth, user)
    sign_in(user)
    if user.is_password_set?
      redirect_to set_card_info_user_path(user)
    else
      redirect_to set_password_user_path(user)
    end
  end
end
