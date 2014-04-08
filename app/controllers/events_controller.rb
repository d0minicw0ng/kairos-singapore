class EventsController < ApplicationController

  before_filter :authenticate_approved_current_user
  before_filter :verify_committee, except: [:show]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      EmailWorker.perform_async('EventMailer', :new_event_notification, {event_id: @event.id, host_with_port: request.host_with_port})
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

  # Probably should be in Application Controller or another file.
  def verify_committee
    unless current_user.try(:member_type) == 'committee'
      flash[:alert] = t(:'common.no_right')
      redirect_to root_url
    end
  end
end
