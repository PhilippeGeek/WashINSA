class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    #redirect_to session_path if !user_signed_in?
    #redirect_to booking_index_path
  end
end
