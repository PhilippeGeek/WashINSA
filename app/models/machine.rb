class Machine < ActiveRecord::Base

  belongs_to :building
  has_many :bookings
  has_and_belongs_to_many :users

end
