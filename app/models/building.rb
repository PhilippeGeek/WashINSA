class Building < ActiveRecord::Base

  has_many :machines
  has_many :bookings, :through => :machines

end
