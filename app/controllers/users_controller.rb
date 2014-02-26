class UsersController < ApplicationController

  before_filter :authenticate_user!, only: [:show]

  def show
    @user = User.includes(:articles).find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :remember_me, :member_type, :company, :job_title, :biography, :avatar)
  end
end
