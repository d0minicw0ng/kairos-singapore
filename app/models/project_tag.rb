class ProjectTag < ActiveRecord::Base
  belongs_to :project, inverse_of: :project_tags
  belongs_to :tag
  validates_presence_of :project_id, :tag_id
  validates_uniqueness_of :tag_id, scope: :project_id

  def self.create_from_multiple_tag_ids(project_id, tag_ids)
    tag_ids.each do |tag_id|
      where(project_id: project_id, tag_id: tag_id).first_or_create
    end
  end

  def self.destroy_multiple_tags(project_id, tag_ids)
    where(project_id: project_id, tag_id: tag_ids).destroy_all
  end
end
