class UserProject < ActiveRecord::Base

  validates_presence_of :project_id, :user_id
  validates_uniqueness_of :user_id, scope: :project_id

  belongs_to :user
  belongs_to :project

  def self.create_from_multiple_user_ids(project_id, user_ids)
    user_ids.each do |user_id|
      create(project_id: project_id, user_id: user_id)
    end
  end
end
