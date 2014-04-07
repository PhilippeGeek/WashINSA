class Laundrette < ActiveRecord::Base

  has_many :buildings
  has_many :machines
  has_many :users, through: :buildings
  has_many :bookings, through: :machines

end
