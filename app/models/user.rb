class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable, :recoverable, :database_authenticatable,
         :omniauthable, :omniauth_providers => [:cas]


  belongs_to :building
  belongs_to :laundrette
  has_many :machines, :through => :laundrette
  has_many :bookings

  def can_book?
    (bookings.where('start > ?',Time.now).count) < User.max_bookings
  end

  def self.max_bookings
    5
  end

  def self.find_for_cas_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.extra.email
      user.name = auth.extra[:displayName]   # assuming the user model has a name
    end
  end
end
