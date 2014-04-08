class ProjectsController < ApplicationController

  before_filter :authenticate_approved_current_user 
  before_action :get_user_ids, only: [:create, :update]
  before_action :get_all_tags_and_users, only: [:new, :edit]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      #FIXME: There must be a rails way of doing this nested join table thing
      create_user_projects(@project, @user_ids)
      flash[:notice] = t(:'projects.project_saved')
      redirect_to project_url(@project)
    else
      get_all_tags_and_users
      flash[:error] = t(:'common.error')
      render :new
    end
  end

  def edit
    @project = Project.friendly.find(params[:id])
  end

  def update
    @project = Project.friendly.find(params[:id])
    if @project.update_attributes(project_params)
      destroy_unwanted_users(@project, @user_ids)
      create_user_projects(@project, @user_ids)
      flash[:notice] = t(:'projects.project_updated')
      redirect_to project_url(@project)
    else
      get_all_tags_and_users
      render :edit
    end
  end

  def show
    @project = Project.includes(:tags).friendly.find(params[:id])
    @comment = Comment.new
  end

  private

  def project_params
    params.require(:project).permit(
      :title,
      :description,
      :youtube_video_id,
      images_attributes: [:avatar],
      tag_list: []
    )
  end

  def destroy_unwanted_users(project, user_ids)
    unwanted_user_ids = @project.users.map(&:id) - user_ids.map(&:to_i)
    UserProject.destroy_multiple_users(project.id, unwanted_user_ids)
  end

  def get_all_tags_and_users
    @tags = ActsAsTaggableOn::Tag.all
    @users = User.all
  end

  def get_user_ids
    @user_ids = get_nested_ids(:user_projects, :user_ids)
    @user_ids << current_user.id unless @user_ids.include?(current_user.id)
  end

  def create_user_projects(project, user_ids)
    UserProject.create_from_multiple_user_ids(project.id, user_ids)
  end

  def get_nested_ids(nested_params, nested_params_ids)
    params[:project].delete(nested_params)[nested_params_ids].split(', ')[0].reject(&:blank?)
  end
end
