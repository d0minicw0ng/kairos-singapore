class EventsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to event_url(@event)
    else
      render :new
    end
  end

  def show
    @event = Event.includes(:projects).friendly.find(params[:id])
    @comment = Comment.new

    @user_registration_id = UserEventRegistration.find_by_user_id_and_event_id(current_user.id, params[:id]).try(:id) || 0
    @project_registration_id = ProjectEventRegistration.of_user_and_event(current_user.id, params[:id]).try(:id) || 0

    @event_attendees = UserEventRegistration.includes(:user).where(event_id: params[:id]).map(&:user)
  end

  def edit
    @event = Event.friendly.find(params[:id])
  end

  def update
    @event = Event.friendly.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = t(:'events.event_updated')
      redirect_to event_url(@event)
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :description,
      :starts_at,
      :ends_at,
      :venue_name,
      :street_one,
      :street_two,
      :city,
      :state,
      :country,
      :zip_code
    )
  end
end
