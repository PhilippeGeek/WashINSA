class BookingController < ApplicationController
  before_filter :authenticate_user!
  def index
    now = Time.now
    check_current_user!
    defaults = {building:current_user.building_id,date:{year: now.year,month:now.month,day:now.day}}
    params = (params.nil?) ? defaults : defaults.merge(params)
    @start=Time.new(params[:date][:year],params[:date][:month],params[:date][:day])
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
    if can? :book, get_machine and @start>Time.now
      if (current_user.bookings.where("start > ?",Time.now).count) > 1
        flash[:error] = 'Vous ne pouvez pas réserver plus de 2 crénaux'
      else
        Booking.create! :user=>current_user, :machine=> get_machine, :start=>params[:start], :end=>Time.parse(params[:start])+1.hours
        flash[:notice] = "C'est réservé"
      end
    else
      flash[:error] = @start<=Time.now ? 'Réserver dans le passé, c\'est dur' : 'Vous ne pouvez pas réserver ici'
    end
    redirect_to :booking_index
  end

  private

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
      Machine.where(:id=> params[:machine]).first()
    end
  end
end
