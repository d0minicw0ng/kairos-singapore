class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @project = Project.new
    @tags = Tag.all
  end

  def create
    tag_ids = ProjectTag.get_tag_ids(params)
    @project = Project.new(params[:project])

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
  end

  def update
  end

  def index
  end

  def show
    @project = Project.includes(:tags).find(params[:id])
    @comment = Comment.new
  end

  def destroy
  end
end
