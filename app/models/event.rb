class Event < ActiveRecord::Base
  attr_accessible :name, :description, :starts_at, :ends_at

  validates_presence_of :name, :description, :starts_at, :ends_at
  validate :starts_at_must_be_before_ends_at

  def starts_at_must_be_before_ends_at
    errors.add(:starts_at, 'must be before ends at') unless starts_at < ends_at
  end
end
