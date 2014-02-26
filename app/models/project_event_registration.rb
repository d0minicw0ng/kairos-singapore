class ProjectEventRegistration < ActiveRecord::Base
  attr_accessible :event_id, :project_id

  validates_presence_of :event_id, :project_id
  validates_uniqueness_of :project_id, scope: :event_id
  validates :state, inclusion: %w(pending accepted rejected)

  belongs_to :project
  belongs_to :event

  has_many :votes

  def self.of_user_and_event(user_id, event_id)
    user = User.find(user_id)
    registrations = user.projects.map(&:project_event_registrations).flatten
    return registrations.select do |registration|
      registration.event_id == event_id
    end.first
  end

  def self.accepted_projects_of_event(event_id)
    accepted_registrations = accepted_registrations_of_event(event_id)
    projects = accepted_registrations.map do |registration|
      Project.find(registration.project_id)
    end
    projects
  end

  private

  def self.accepted_registrations_of_event(event_id)
    result = get_result(event_id)
    result[0...Event::MAX_PROJECT_PARTICIPANTS].each do |registration_id_count_pair|
      registration = find(registration_id_count_pair[0])
      registration.update_attributes(state: 'accepted')
    end

    result[Event::MAX_PROJECT_PARTICIPANTS..result.length-1].each do |registration_id_count_pair|
      registration = find(registration_id_count_pair[0])
      registration.update_attributes(state: 'rejected')
    end

    result[0...Event::MAX_PROJECT_PARTICIPANTS]
  end

  def self.get_result(event_id)
    result = {}
    registration_ids = where(event_id: event_id).pluck(:id)
    registration_ids.each do |registration_id|
      votes_count = Vote.where(project_event_registration_id: registration_id).count
      result[registration_id] = votes_count
    end
    result.sort_by {|_, count| -count}
  end
end
