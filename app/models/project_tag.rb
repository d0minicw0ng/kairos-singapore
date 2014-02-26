class ProjectTag < ActiveRecord::Base
  belongs_to :project, inverse_of: :project_tags
  belongs_to :tag
  validates_presence_of :project_id, :tag_id
  validates_uniqueness_of :tag_id, scope: :project_id

  def self.create_from_multiple_tag_ids(project_id, tag_ids)
    tag_ids.each do |tag_id|
      create(project_id: project_id, tag_id: tag_id)
    end
  end

  def self.get_tag_ids(params)
    params[:project].delete(:project_tags)[:tag_ids].split(', ')[0]
  end
end
