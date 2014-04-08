class ProjectEventRegistrationsController < ApplicationController

  before_filter :authenticate_approved_current_user

  def create
    @registration = ProjectEventRegistration.create(project_event_registration_params)
    render json: @registration
  end

  def destroy
    @registration = ProjectEventRegistration.find(params[:id])
    @registration.destroy
    render json: {}
  end

  private
  def project_event_registration_params
    params.require(:project_event_registration).permit(:event_id, :project_id)
  end
end
