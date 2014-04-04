class HomeController < ApplicationController
  def index
    if current_user.nil?
      redirect_to :new_user_session
    else
      redirect_to :booking_index
    end
  end
end
