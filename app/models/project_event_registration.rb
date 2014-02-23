class ProjectEventRegistration < ActiveRecord::Base
  attr_accessible :event_id, :project_id

  validates_presence_of :event_id, :project_id
  validates_uniqueness_of :project_id, scope: :event_id
  validates :state, inclusion: %w(pending accepted rejected)

  has_many :votes

  def self.registration_ids_for_event(event_id)
     where(event_id: event_id).pluck(:id)
  end

  def self.accepted_projects(event_id)
    accepted_registrations = process_result(event_id)
    projects = []
    accepted_registrations.each do |registration|
      project = Project.find(registration.project_id)
      accepted_projects << project
    end
    projects
  end

  private

  def self.process_result(event_id)
    result = get_results(event_id)
    accepted_registrations = []

    result.first(5).each do |registration_id, _|
      process_registration(registration_id, 'accepted')
      result.delete(registration_id)
      accepted_registrations << find(registration_id)
    end

    result.each do |registration_id, _|
      process_registration(registration_id, 'rejected')
    end

    accepted_registrations
  end

  def self.get_result(event_id)
    result = {}

    registration_ids_for_event.each do |registration_id|
      votes_count = Vote.where(project_event_registration_id: registration_id).count
      result[registration_id] = votes_count
    end
    result.sort_by {|_, count| -count}
  end

  def self.process_registration(registration_id, state)
    registration = find(registration_id)
    registration.update_attributes(state: state)
  end
end
