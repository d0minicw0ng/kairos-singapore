class ProjectEventRegistrationsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @registration = ProjectEventRegistration.create(params[:project_event_registration])
    render json: @registration
  end
end
