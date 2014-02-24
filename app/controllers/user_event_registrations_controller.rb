class UserEventRegistrationsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @registration = UserEventRegistrations.create(params[:user_event_registration])
    render json: @registration
  end
end
