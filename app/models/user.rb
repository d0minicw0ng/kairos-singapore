class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  attr_accessible :email, :password, :password_confirmation, :remember_me

  include FlagShihTzu
  # The keys must not be changed once in use, or you will get incorrect results.
  # maximum flag is 16
  has_flags 1 => :clean_tech, 2 => :health_care, 3 => :big_data, column: 'industries'

  validates :type, inclusion: %w(mentor innovator committee)

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
end
