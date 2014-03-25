class Article < ActiveRecord::Base
  validates_presence_of :title, :body, :user_id
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged
end
