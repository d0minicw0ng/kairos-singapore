class Article < ActiveRecord::Base
  attr_accessible :body, :title, :user_id
  validates_presence_of :title, :body, :user_id
  belongs_to :user
  has_many :comments, as: :commentable
end
