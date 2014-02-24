class Project < ActiveRecord::Base
  attr_accessible :title, :description, :video_url, :images_attributes

  validates_presence_of :title, :description, :video_url

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :project_tags, dependent: :destroy, inverse_of: :project
  has_many :tags, through: :project_tags

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :project_event_registrations
  has_many :registered_events, through: :project_event_registrations, source: :event

  extend FriendlyId
  friendly_id :title, use: :slugged
end
