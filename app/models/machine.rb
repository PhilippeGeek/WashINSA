class Machine < ActiveRecord::Base

  belongs_to :laundrette
  has_many :users, through: :laundrette
  has_many :buildings, through: :laundrette
  has_many :bookings

end
