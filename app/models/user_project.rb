class UserProject < ActiveRecord::Base
  attr_accessible :project_id, :user_id

  validates_presence_of :project_id, :user_id
  validates_uniqueness_of :user_id, scope: :project_id

  belongs_to :user
  belongs_to :project
end
