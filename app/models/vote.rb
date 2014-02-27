class Vote < ActiveRecord::Base
  validates_presence_of :user_id, :project_event_registration_id
  validates_uniqueness_of :user_id, scope: :project_event_registration_id
  belongs_to :project_event_registration
  belongs_to :user

  validate :user_can_only_vote_once_per_event

  def user_can_only_vote_once_per_event
    voted_registration = ProjectEventRegistration.find(project_event_registration_id)
    all_registrations = ProjectEventRegistration.
      where(event_id: voted_registration.event_id).
      where.not(project_id: voted_registration.project_id)

    all_registrations.each do |registration|
      if registration.votes.any? {|vote| vote.user_id == user_id}
        errors.add(:user, 'can only vote once per event!')
        return
      end
    end
  end
end
