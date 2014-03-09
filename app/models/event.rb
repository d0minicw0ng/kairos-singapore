class Event < ActiveRecord::Base
  MAX_PROJECT_PARTICIPANTS = 5
  MAX_PARTICIPANTS = 40

  validates_presence_of :name, :description, :starts_at, :ends_at, :venue_name, :street_one, :city, :country, :user_id
  validate :starts_at_must_be_before_ends_at

  has_many :user_event_registrations
  has_many :project_event_registrations
  has_many :projects, through: :project_event_registrations

  has_many :comments, as: :commentable, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :registerable, -> {where('starts_at > ?', Date.today)}

  def starts_at_must_be_before_ends_at
    errors.add(:starts_at, 'must be before ends at') unless starts_at < ends_at
  end

  geocoded_by :address
  after_validation :geocode

  def address
    [street_one, street_two, city, state, country, zip_code].compact.join(', ')
  end

  ADDRESS_COMPONENTS = [:street_one, :street_two, :city, :state, :country, :zip_code]
end
