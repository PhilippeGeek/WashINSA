class Building < ActiveRecord::Base

  belongs_to :lauderette
  has_many :machines, through: :lauderette
  has_many :users
  has_many :bookings, through: :users

end
