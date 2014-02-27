class VotesController < ApplicationController

  before_filter :authenticate_user!

  def create
    params[:vote][:project_event_registration_id] = get_registration_id_from_project_and_event_id
    @vote = Vote.create(vote_params)
    render json: @vote
  end

  def destroy
    registration_id = get_registration_id_from_project_and_event_id
    @vote = Vote.find_by_project_event_registration_id_and_user_id(registration_id, current_user.id)
    @vote.destroy
    render json: {}
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :project_event_registration_id)
  end

  def get_registration_id_from_project_and_event_id
    project_id = params[:vote].delete(:project_id)
    event_id = params[:vote].delete(:event_id)

    ProjectEventRegistration.find_by_project_id_and_event_id(project_id, event_id).id
  end
end
