class UserEventRegistration < ActiveRecord::Base
  attr_accessible :event_id, :user_id

  validates_presence_of :event_id, :user_id
  validates_uniqueness_of :user_id, scope: :event_id
  validates :state, inclusion: %w(pending accepted rejected)

  belongs_to :user
  belongs_to :event

  def self.accepted_attendees_of_event(event_id)
    accepted_registrations = accepted_registrations_of_event(event_id)
    attendees = accepted_registrations.map do |registration|
      User.find(registration.user_id)
    end
    attendees
  end

  def self.replace_dropouts_with_waitlisted_attendees(dropout_ids, event_id)
    return [] if dropout_ids.empty?
    num_of_droputs = dropout_ids.length
    newly_accepted_attendees = []

    registrations = where(user_id: dropout_ids, event_id: event_id)
    registrations.each {|registration| registration.update_attributes(state: 'rejected')}

    all_registrations = where(event_id: event_id)
    if all_registrations.length > Event::MAX_PARTICIPANTS
      all_registrations = all_registrations.sort_by {|registration| registration.created_at}

      start_idx = Event::MAX_PARTICIPANTS
      total_registrations = all_registrations.length
      num_of_droputs.times do
        if total_registrations > start_idx
          registration = all_registrations[start_idx]
          registration.update_attributes(state: 'accepted')
          newly_accepted_attendees << User.find(registration.user_id)
          start_idx += 1
        end
      end
    end

    newly_accepted_attendees
  end

  private

  def self.accepted_registrations_of_event(event_id)
    sorted_registrations = where(event_id: event_id).
      sort_by {|registration| registration.created_at}

    registrations[0...Event::MAX_PARTICIPANTS].each do |registration|
      registration.update_attributes(state: 'accepted')
    end
    registrations[Event::MAX_PARTICIPANTS..registrations.length-1].each do |registration|
      registration.update_attributes(state: 'rejected')
    end

    registrations[0...Event::MAX_PARTICIPANTS]
  end
end
