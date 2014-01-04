class Vote < ActiveRecord::Base
	validates_presence_of :user_id, :project_id
	validates_uniqueness_of :user_id, scope: :project_id
	belongs_to :project
	belongs_to :user
end
