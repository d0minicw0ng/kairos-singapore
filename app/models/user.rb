class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :member_type, :company, :job_title, :biography

  validates_uniqueness_of :username

  include FlagShihTzu
  # The keys must not be changed once in use, or you will get incorrect results.
  # maximum flag is 16
  has_flags 1 => :clean_tech, 2 => :health_care, 3 => :big_data, column: 'industries'
  INDUSTRIES = {
    'clean_tech' => 'Clean Tech',
    'health_care' => 'Healthcare',
    'big_data' => 'Big Data'
  }

  def industries
    industries = []
    INDUSTRIES.each do |key, industry|
      industries << industry if self.send(key)
    end
    industries
  end

  validates :member_type, inclusion: %w(mentor innovator committee)
  validates_presence_of :company, :job_title, :biography

  attr_accessible :avatar

  has_attached_file :avatar,
    styles: {
      medium: '300x300>',
      thumb: '100x100>'
    },
    default_url: 'images/missing_user.png'

  validates_attachment :avatar,
    presence: true,
    content_type: {
      content_type: ['image/png', 'image/jpg', 'image/jpeg'] 
    },
    size: { :in => 0..2.megabytes }

  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :comments
  has_many :articles

  has_many :user_event_registrations
  has_many :registered_events, through: :user_event_registrations, source: :event

end
