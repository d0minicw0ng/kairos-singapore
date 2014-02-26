class Tag < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :project_tags
  has_many :projects, through: :project_tags
  has_many :article_tags
  has_many :articles, through: :article_tags
end
