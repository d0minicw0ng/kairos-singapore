class UsersController < ApplicationController

  before_filter :authenticate_user!


  def show
    @user = User.includes([{articles: :comments}, :projects]).friendly.find(params[:id])
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = t(:'users.profile_updated')
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def dashboard
    @events = Event.registerable.order('starts_at DESC')
    @users = User.all
    @projects = Project.all.order('created_at DESC')
    @articles = Article.all.order('created_at DESC')
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :remember_me, :member_type, :company, :job_title, :biography, :avatar)
  end
end
