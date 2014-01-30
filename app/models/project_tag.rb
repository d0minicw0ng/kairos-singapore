class ProjectTag < ActiveRecord::Base
  attr_accessible :project_id, :tag_id
  belongs_to :project, inverse_of: :project_tags
  belongs_to :tag
  validates_presence_of :project_id, :tag_id
  validates_uniqueness_of :tag_id, scope: :project_id
end
