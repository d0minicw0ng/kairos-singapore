class ProjectsController < ApplicationController

  before_filter :authenticate_user!
  before_action :get_nested_tag_and_user_ids, only: [:create, :update]

  def new
    @project = Project.new
    get_all_tags_and_users
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      #FIXME: There must be a rails way of doing this nested join table thing
      create_project_tags_and_user_projects(@project, @tag_ids, @user_ids)
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
    get_all_tags_and_users
  end

  def update
    @project = Project.friendly.find(params[:id])
    if @project.update_attributes(project_params)
      destroy_unwanted_tags_and_users(@project, @tag_ids, @user_ids)
      create_project_tags_and_user_projects(@project, @tag_ids, @user_ids)
      flash[:notice] = t(:'projects.project_updated')
      redirect_to project_url(@project)
    else
      render :edit
    end
  end

  def show
    @project = Project.includes(:tags).friendly.find(params[:id])
    @comment = Comment.new
  end

  private


  def project_params
    params.require(:project).permit(:title, :description, :youtube_video_id, images_attributes: [:avatar])
  end

  def destroy_unwanted_tags_and_users(project, tag_ids, user_ids)
    unwanted_tag_ids = @project.tags.map(&:id) - tag_ids.map(&:to_i)
    unwanted_user_ids = @project.users.map(&:id) - user_ids.map(&:to_i)
    ProjectTag.destroy_multiple_tags(project.id, unwanted_tag_ids)
    UserProject.destroy_multiple_users(project.id, unwanted_user_ids)
  end

  def get_all_tags_and_users
    @tags = Tag.all
    @users = User.all
  end

  def get_nested_tag_and_user_ids
    @tag_ids = get_nested_ids(:project_tags, :tag_ids)
    @user_ids = get_nested_ids(:user_projects, :user_ids)
    @user_ids << current_user.id unless @user_ids.include?(current_user.id)
  end

  def create_project_tags_and_user_projects(project, tag_ids, user_ids)
    ProjectTag.create_from_multiple_tag_ids(project.id, tag_ids)
    UserProject.create_from_multiple_user_ids(project.id, user_ids)
  end

  def get_nested_ids(nested_params, nested_params_ids)
    params[:project].delete(nested_params)[nested_params_ids].split(', ')[0].reject(&:blank?)
  end
end
