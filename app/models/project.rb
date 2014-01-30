class Project < ActiveRecord::Base
  attr_accessible :title, :description, :video_url, :images_attributes, :project_tags_attributes

  validates_presence_of :title, :description, :video_url

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :project_tags, dependent: :destroy, inverse_of: :project
  has_many :tags, through: :project_tags

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def project_tags_attributes=(project_tags_attributes)
    project_tags_attributes[:tag_id].each do |id|
      if id.to_i > 0
        project_tags.new(tag_id: id)
      end
    end
  end
end
