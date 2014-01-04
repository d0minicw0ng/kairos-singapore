class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  attr_accessible :email, :password, :password_confirmation, :remember_me

  include FlagShihTze
  # The keys must not be changed once in use, or you will get incorrect results.
  has_flags 1 => :clean_tech, 2 => :health_care, 3 => :big_data, column: 'industries'
end
