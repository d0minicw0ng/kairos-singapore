class UserEventRegistrationsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @registration = UserEventRegistration.create(params[:user_event_registration])
    render json: @registration
  end

  def destroy
    @registration = UserEventRegistration.find(params[:id])
    @registration.destroy
    render json: {}
  end
end
