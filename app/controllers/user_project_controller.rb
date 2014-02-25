class UserProjectController < ApplicationController

  before_filter :authenticate_user!

  def create
    @user_project = UserProject.create(params[:user_project])
    render json: @user_project
  end

  def destroy
    @user_project = UserProject.find(params[:id])
    @user_project.destroy
    render json: {}
  end
end
