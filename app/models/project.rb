class Project < ActiveRecord::Base
  attr_accessible :title, :description, :video_url
  validates_presence_of :title, :description, :video_url
  has_many :comments, as: :commentable
  has_many :project_tags
  has_many :tags, through: :project_tags
end
