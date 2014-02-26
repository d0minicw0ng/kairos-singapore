class UserProject < ActiveRecord::Base

  validates_presence_of :project_id, :user_id
  validates_uniqueness_of :user_id, scope: :project_id

  belongs_to :user
  belongs_to :project
end
