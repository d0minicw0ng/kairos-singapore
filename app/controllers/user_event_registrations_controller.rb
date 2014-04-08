class UserEventRegistrationsController < ApplicationController

  before_filter :authenticate_approved_current_user

  def create
    @registration = UserEventRegistration.create(user_event_registration_params)
    render json: @registration
  end

  def destroy
    @registration = UserEventRegistration.find(params[:id])
    @registration.destroy
    render json: {}
  end

  private

  def user_event_registration_params
    params.require(:user_event_registration).permit(:event_id, :user_id)
  end
end
