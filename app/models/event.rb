class Event < ActiveRecord::Base
  attr_accessible :name, :description, :starts_at, :ends_at
  MAX_PROJECT_PARTICIPANTS = 5
  MAX_PARTICIPANTS = 40

  validates_presence_of :name, :description, :starts_at, :ends_at
  validate :starts_at_must_be_before_ends_at

  has_many :user_event_registrations
  has_many :project_event_registrations

  def starts_at_must_be_before_ends_at
    errors.add(:starts_at, 'must be before ends at') unless starts_at < ends_at
  end
end
