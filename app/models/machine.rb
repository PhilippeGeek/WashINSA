class Machine < ActiveRecord::Base

  belongs_to :lauderette
  has_many :buildings, through: :lauderette
  has_many :bookings
  has_many :users, through: :lauderette

end
