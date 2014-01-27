class Article < ActiveRecord::Base
  attr_accessible :title, :body, :user_id
  validates_presence_of :title, :body, :user_id
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :article_tags
  has_many :tags, through: :article_tags

  extend FriendlyId
  friendly_id :title, use: :slugged
end
