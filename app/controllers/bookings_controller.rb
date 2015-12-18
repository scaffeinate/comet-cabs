
class BookingsController < ApplicationController
  include FareEstimate
  include FindDriver
  include ErrorMessage

  before_action :authenticate_user!
  before_action :check_active_bookings, only: :new

  def new
    @cab_types = CabType.all
    @driver = Driver.new
  end

  def create
    source = params[:source_location]
    destination = params[:destination_location]
    cab_type = CabType.find(params[:cab_type])

    valid_location?(source, destination, params[:cab_type])

    if @error.nil?
      distance = calculate_distance(source.split(','), destination.split(',')).round(2)
      fare = calculate_fare_estimate(distance, cab_type).round(2)
      tax = calculate_tax(fare).round(2)
      total = (fare + tax)

      @driver = find_driver(source, cab_type)

      if @driver.nil?
        @error = 'Sorry. No cabs around.'
      else
        @booking = Booking.new(source: source, destination: destination,
                               source_name: params[:source], destination_name: params[:destination],
                               source_place_id: params[:source_place_id], destination_place_id: params[:destination_place_id],
                               distance: distance, price: total, user: current_user,
                               driver: @driver, status: 1, cab_type: cab_type)
        if @booking.save
          @driver.update(available: false)
          session[:current_booking] = @booking.id
        else
          @error = @driver.errors.full_messages.fist
        end
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    @booking = Booking.find(session[:current_booking])
    if @booking.update!(booking_params)
      distance = calculate_distance(params[:booking][:source].split(','), params[:booking][:destination].split(',')).round(2)
      fare = calculate_fare_estimate(distance, @booking.cab_type).round(2)
      tax = calculate_tax(fare).round(2)
      total = (fare + tax)
      puts total
      @booking.update(distance: distance, price: total)
    else
      @error = @booking.errors.full_messages.first
    end

    respond_to do |format|
      format.js
    end
  end

  def confirm
    @booking = Booking.find(session[:current_booking])
    @booking.update(status: 2)
    redirect_to current_bookings_path
  end

  def current
    @booking = Booking.find(session[:current_booking])
    @driver = @booking.driver
    @cab_type = @booking.cab_type
  end

  def cancel
    session[:current_booking] = nil
    flash[:messsage] = 'Trip successfully ended'
    redirect_to root_path
  end

  private

  def check_active_bookings
    redirect_to current_bookings_path if session[:current_booking]
  end

  def booking_params
    params.require(:booking).permit!
  end
end
