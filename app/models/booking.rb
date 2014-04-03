class Booking < ActiveRecord::Base

  belongs_to :user
  belongs_to :machine

  scope :on_day, ->(day){where('start>?',day).where('start<?',day+1.day)}

end
