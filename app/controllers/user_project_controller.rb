class UserProjectController < ApplicationController

  before_filter :authenticate_user!

  def create
    @user_project = UserProject.create(user_project_params)
    render json: @user_project
  end

  def destroy
    @user_project = UserProject.find(params[:id])
    @user_project.destroy
    render json: {}
  end

  private
  def user_project_params
    params.require(:user_project).permit(:project_id, :user_id)
  end
end
