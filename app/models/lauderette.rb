class Lauderette < ActiveRecord::Base
  has_many :machines
  has_many :buildings
  has_many :users, through: :buildings
  has_many :bookings, through: :machines
end
