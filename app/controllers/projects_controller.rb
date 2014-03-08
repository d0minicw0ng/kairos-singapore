class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @project = Project.new
    @tags = Tag.all
    @users = User.all
  end

  def create
    tag_ids = get_nested_ids(:project_tags, :tag_ids)
    user_ids = get_nested_ids(:user_projects, :user_ids)
    @project = Project.new(project_params)

    if @project.save
      #FIXME: There gotta be a rails way of doing this nested join table thing
      ProjectTag.create_from_multiple_tag_ids(@project.id, tag_ids)
      UserProject.create_from_multiple_user_ids(@project.id, user_ids)
      flash[:notice] = t(:'projects.project_saved')
      redirect_to project_url(@project)
    else
      @tags = Tag.all
      flash[:error] = t(:'common.error')
      render :new
    end
  end

  def edit
    @project = Project.friendly.find(params[:id])
    @tags = Tag.all
  end

  def update
    @project = Project.friendly.find(params[:id])
    if @project.update_attributes(project_params)
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
    params.require(:project).permit(:title, :description, :video_url, :images_attributes)
  end

  def get_nested_ids(nested_params, nested_params_ids)
    params[:project].delete(nested_params)[nested_params_ids].split(', ')[0].reject(&:blank?)
  end
end
