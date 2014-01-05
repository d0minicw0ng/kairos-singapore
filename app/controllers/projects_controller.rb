class ProjectsController < ApplicationController
	
	def new
	  @project = Project.new
	end

	def create
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
