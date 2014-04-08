class Building < ActiveRecord::Base

  has_many :machines, through: :laundrette
  has_many :bookings, through: :machines
  belongs_to :laundrette
  has_many :users

end
