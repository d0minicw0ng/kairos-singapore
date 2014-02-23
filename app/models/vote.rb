class Vote < ActiveRecord::Base
  validates_presence_of :user_id, :project_event_registration_id
  validates_uniqueness_of :user_id, scope: :project_event_registration_id
  belongs_to :project_event_registration
  belongs_to :user
end
