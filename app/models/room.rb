class Room < ActiveRecord::Base

  belongs_to :building
  has_many :users
  has_many :bookings, through: :users

end
