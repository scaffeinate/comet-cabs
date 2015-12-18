class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    set_card_info_user_path(_resource)
  end
end
