class Comment < ActiveRecord::Base
  attr_accessible :user_id, :content, :commentable_id, :commentable_type
  belongs_to :commentable, polymorphic: true

  validates_presence_of :user_id, :content, :commentable_id, :commentable_type
end
