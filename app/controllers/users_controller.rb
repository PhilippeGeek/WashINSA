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
    @user.room_id = get_room.id
    @user.save!
    redirect_to ((params['go_book'].nil?()) ? edit_user_path(@user) : booking_index_path)
  end

  def get_room
    Room.where(:number => params[:room], :building_id => @user.building_id).find_or_create_by!({number: params[:room], building_id: @user.building_id})
  end

  def show
    @user = User.find(params[:id])
  end

end
