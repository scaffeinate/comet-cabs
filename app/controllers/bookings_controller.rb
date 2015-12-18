class BookingsController < ApplicationController
  include FareEstimate
  include FindDriver

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

    @error = 'Source Location is invalid' if source.blank?
    @error = 'Destination is invalid' if destination.blank?
    @error = 'Not a valid cab type selection' if cab_type.blank?

    if @error.nil?
      distance = calculate_distance(source.split(','), source.split(',')).round(2)
      fare = calculate_fare_estimate(distance, cab_type).round(2)
      tax = calculate_tax(fare).round(2)
      total = (fare + tax)

      @driver = find_driver(source, cab_type)
      if @driver.empty?
        @error = 'Sorry. No cabs around.'
      else
        @booking = Booking.new(source: source, destination: destination, distance: distance, price: total, user: current_user, driver: @driver, status: 1, cab_type: cab_type)
        if @booking.save
          @driver.update(available: false)
          # session[:current_booking] = @booking.id
        else
          @error = @driver.errors.full_messages.fist
        end
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def confirm_booking
    @booking = Booking.find(session[:current_booking])
    @booking.update(status: 2)
    redirect_to current_bookings_path
  end

  def current
  end

  private

  def check_active_bookings
    redirect_to current_bookings_path if session[:current_booking]
  end
end
