class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def edit
  end

  def update
    @user.building_id = params[:building][:id]
    @user.laundrette_id = params[:laundrette][:id]
    @user.save!
    redirect_to ((params['go_book'].nil?()) ? edit_user_path(@user) : booking_index_path)
  end

  def show
    @user = User.find(params[:id])
  end

end
