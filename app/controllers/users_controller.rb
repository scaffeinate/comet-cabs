class UsersController < ApplicationController
  before_action :set_user

  def save_password
    if @user.update(password: params[:password], password_confirmation: params[:password_confirmation], phone: params[:phone])
      @user.is_password_set = true
      @user.save
      redirect_to set_card_info_user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.first
      redirect_to set_password_user_path(@user)
    end
  end

  def save_card_info
    @payment = Payment.new(holder_name: params[:holder_name], card_number: params[:card_number],
                           card_cvv: params[:card_cvv], card_expiry: params[:card_expiry], user: @user)

    if @payment.save
      @user.is_card_info_set = true
      if @user.save
        sign_in(@user)
        redirect_to root_path
      end
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
