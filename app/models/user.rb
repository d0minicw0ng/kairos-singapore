class User < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :skills
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  validates_uniqueness_of :username

  include FlagShihTzu
  # The keys must not be changed once in use, or you will get incorrect results.
  # maximum flag is 16
  has_flags 1 => :clean_tech, 2 => :health_care, 3 => :big_data, 4 => :information_technology_and_services, 5 => :venture_capital_and_private_equity, 6 => :management_consulting, 7 => :government_administration, 8 => :biomedical_sciences, 9 => :medical_devices, 10 => :education, 11 => :professional_training_and_coaching, 12 => :media_production, 13 => :non_profit_organization, 14 => :artificial_intelligence, 15 => :logistics_and_supply_chain, 16 => :others, column: 'industries'

  INDUSTRIES = {
    'clean_tech'                          => 'Clean Tech',
    'health_care'                         => 'Health Care',
    'big_data'                            => 'Big Data',
    'information_technology_and_services' => 'Information Technology and Services',
    'venture_capital_and_private_equity'  => 'Venture Capital and Private Equity',
    'management_consulting'               => 'Management Consulting',
    'government_administration'           => 'Government Administration',
    'biomedical_sciences'                 => 'Biomedical Sciences',
    'medical_devices'                     => 'Medical Devices',
    'education'                           => 'Education',
    'professional_training_and_coaching'  => 'Professional Training and Coaching',
    'media_production'                    => 'Media Production',
    'non_profit_organization'             => 'Non Profit Organization',
    'artificial_intelligence'             => 'Artificial Intelligence',
    'logistics_and_supply_chain'          => 'Logistics and Supply Chain',
    'others'                              => 'Others'
  }

  def industries
    industries = []
    INDUSTRIES.each do |key, industry|
      industries << industry if self.send(key)
    end
    industries
  end

  validates :member_type, inclusion: %w(mentor innovator committee)
  validates_presence_of :company, :job_title, :biography, :username, :first_name, :last_name

  scope :approved, -> {where('approved = ?', true)}
  scope :unapproved, -> {where('approved = ?', false)}

  has_attached_file :avatar,
    styles: {
      medium: '300x300>',
      thumb: '100x100>'
    },
    default_url: 'images/missing_user.png'

  validates_attachment :avatar,
    presence: true,
    content_type: {
      content_type: ['image/png', 'image/jpg', 'image/jpeg'],
      message: 'must be of .png, .jpg, or .jpeg format.'
    },
    size: { in: 0..2.megabytes, message: 'must be smaller than 2 megabytes.' }

  def thumb_url
    avatar.url(:thumb)
  end

  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :comments
  has_many :articles

  has_many :user_event_registrations
  has_many :registered_events, through: :user_event_registrations, source: :event

  has_many :user_projects
  has_many :projects, through: :user_projects

  has_many :votes

  has_many :events

  belongs_to :country

  belongs_to :referrer, class_name: 'User', foreign_key: 'referred_by_id'
  has_many :referred_members, class_name: 'User', foreign_key: 'referred_by_id'

  def registered_for_event?(event)
    user_event_registrations.map(&:event_id).include?(event.id)
  end

  def has_voted_for?(project, event)
    registration = ProjectEventRegistration.find_by_project_id_and_event_id(project.id, event.id)
    Vote.where(project_event_registration_id: registration.id, user_id: id).count != 0
  end

  def name
    "#{first_name} #{last_name}"
  end
end
