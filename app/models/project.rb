class Project < ActiveRecord::Base
  has_many :comments, as: :commentable
  has_many :project_tags
  has_many :tags, through: :project_tags
end
