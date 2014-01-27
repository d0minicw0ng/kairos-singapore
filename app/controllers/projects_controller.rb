class ProjectsController < ApplicationController

  # before_filter :authenticate_user!
  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:notice] = t(:'projects.project_saved')
      redirect_to project_url(@project)
    else 
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
    @project = Project.find(params[:id])
  end

  def destroy
  end
end
