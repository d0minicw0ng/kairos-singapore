class Project < ActiveRecord::Base

  validates_presence_of :title, :description

  has_many :comments, as: :commentable, dependent: :destroy

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :project_event_registrations, dependent: :destroy
  has_many :registered_events, through: :project_event_registrations, source: :event

  has_many :user_projects, dependent: :destroy
  #FIXME: Members of a project, need a better name, but later
  has_many :users, through: :user_projects

  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_taggable
end
