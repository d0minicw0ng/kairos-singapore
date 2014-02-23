class ProjectEventRegistration < ActiveRecord::Base
  attr_accessible :event_id, :project_id

  validates_presence_of :event_id, :project_id
  validates_uniqueness_of :project_id, scope: :event_id
  validates :state, inclusion: %w(pending accepted rejected)

  has_many :votes

  def votes_count
    votes.count
  end
end
