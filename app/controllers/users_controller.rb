class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def save_password
  end

  def save_card_info
    @payment = Payment.new(holder_name: params[:holder_name], card_number: params[:card_number],
                           card_cvv: params[:card_cvv], card_expiry: params[:card_expiry], user: @user)

    if @payment.save!
      @user.update(is_card_info_set: true)
      redirect_to root_path
    else
      flash[:error] = @payment.errors.full_messages.first
      redirect_to set_card_info_user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    @user.profile_complete = true
    if @user.save
      sign_in @user, bypass: true
      redirect_to root_path
    else
      render 'set_password'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation,
                                 :avatar, :holder_name, :card_number, :card_cvv, :card_expiry)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
