class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable, :recoverable, :database_authenticatable,
         :omniauthable, :omniauth_providers => [:cas]


  belongs_to :building
  belongs_to :laundrette
  belongs_to :room
  has_many :machines, :through => :laundrette
  has_many :bookings

  def can_book?
    (bookings.where('start > ?',Time.now-1.hour).count) < User.max_bookings
  end

  def self.max_bookings
    5
  end

  def self.find_for_cas_oauth(auth)
    user=User.new
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.extra['mail']
    user.building_id = Building.all.first.id
    user.laundrette_id = Laundrette.all.first.id
    user.name = auth.extra[:displayName]   # assuming the user model has a name
    where(auth.slice(:provider, :uid)).first || user
  end
end
