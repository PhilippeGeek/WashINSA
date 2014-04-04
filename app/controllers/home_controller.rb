class HomeController < ApplicationController
  def index
    if current_user.nil?
      redirect_to user_omniauth_authorize_path(:cas)
    else
      redirect_to :booking_index
    end
  end
end
