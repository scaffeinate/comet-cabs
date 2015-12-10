class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def update
    @user.update(user_params)
    @user.profile_complete = true
    if @user.save
      sign_in @user, bypass: true
      redirect_to root_path
    else
      render 'complete_profile'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
