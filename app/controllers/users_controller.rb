class UsersController < ApplicationController

  before_filter :authenticate_approved_current_user
  before_filter :authenticate_admin, only: [:unapproved_users]

  def show
    @user = User.includes([{articles: :comments}, :projects]).friendly.find(params[:id])
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    #FIXME: This piece of code is written at 12am after Manchester United lost 3-0 to Liverpool, home game. Bare with me.
    industries = params[:user].delete(:industries).reject {|i| i.blank?}.map {|i| i.downcase.parameterize.underscore}
    @user = User.friendly.find(params[:id])
    @user.industries.each {|industry| @user.send("#{industry.downcase.parameterize.underscore}=", false)}
    industries.each {|industry| @user.send("#{industry}=", true)}

    if @user.update_attributes(user_params)
      flash[:notice] = t(:'users.profile_updated')
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  #NOTE: unapproved_users and approve should be in admin controller, but I really have no time to do this now.
  def unapproved_users
    @users = User.unapproved
  end

  def approve
    user = User.find(params[:id])
    user.update_attributes(approved: true)
    EmailWorker.perform_async('ContactUsMailer', :user_approved, {email: user.email, name: user.first_name})
    render json: {}, status: :ok
  end

  def dashboard
    @events = Event.registerable.order('starts_at DESC')
    @users = User.approved
    @projects = Project.all.order('created_at DESC')
    @articles = Article.all.order('created_at DESC')
  end

  def search
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :password,
      :password_confirmation,
      :remember_me,
      :member_type,
      :company,
      :job_title,
      :linkedin_url,
      :biography,
      :country_id,
      :referred_by_id,
      :avatar,
      skill_list: []
    )
  end
end
