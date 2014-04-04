class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :building
  has_many :machines, :through => :building
  has_many :bookings

  def can_book?
    (bookings.where('start > ?',Time.now).count) < User.max_bookings
  end

  def self.max_bookings
    5
  end
end
