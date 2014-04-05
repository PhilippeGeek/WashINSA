class BookingController < ApplicationController
  before_filter :authenticate_user!
  def index
    check_current_user!
    defaults = {building:current_user.building_id,year: Time.now.year, month: Time.now.month, day:Time.now.day}
    params.replace(defaults.merge(params))
    @start=Time.new(params['year'].to_i,params['month'].to_i,params['day'].to_i,0,0,0)
    @building = Building.where(:id=>params[:building]).first
    @bookings = @building.bookings.on_day(@start)
    @machines = @building.machines
  end

  def destroy
    if !booking.nil? and can? :destroy, booking
      booking.destroy!
    else
      flash[:error] = "Bien essayé ! Mais vous ne pouvez pas supprimer une réservation d'un autre."
    end
    redirect_to :booking_index
  end

  def new
    @start = Time.parse(params[:start])
    if can? :book, get_machine and is_not_booking_in_past? @start
        Booking.create! :user=>current_user, :machine=> get_machine, :start=>params[:start], :end=>Time.parse(params[:start])+1.hours
        flash[:notice] = 'Tout est bon'
    elsif !is_not_booking_in_past? @start
      flash[:error] = 'On ne peut pas réserver dans le passé ! (by: Capitain Obvious)'
    elsif !current_user.can_book?
      flash[:error] = 'Vous ne pouvez pas réserver plus de '+User.max_bookings.to_s+' crénaux'
    else
      flash[:error] = 'Vous ne pouvez pas réserver cette machine (problème technique)'
    end
    redirect_to :booking_index
  end

  private

  def is_not_booking_in_past?(time)
    (Time.now - 1.hours) <= time
  end

  def booking
    if params[:id].nil?
      nil
    else
      Booking.where(:id=>params[:id]).first
    end
  end

  def check_current_user!
    if current_user.building.nil?
      current_user.building = Building.all.first
      current_user.save!
    end
    if current_user.building.machines.count == 0
      current_user.building.machines << Machine.all.first
    end
  end

  def get_machine
    if params[:machine].nil?
      nil
    else
      Machine.where(:id=> params[:machine]).first
    end
  end
end
