class Country < ActiveRecord::Base
  has_many :users
  validates_uniqueness_of :name
end
