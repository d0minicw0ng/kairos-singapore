class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @project = Project.new
    @tags = Tag.all
  end

  def create
    tag_ids = ProjectTag.get_tag_ids(params)
    @project = Project.new(project_params)

    if @project.save
      ProjectTag.create_from_multiple_tag_ids(@project.id, tag_ids)
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
end
