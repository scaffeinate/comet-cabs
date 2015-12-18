class BookingsController < ApplicationController
  include FareEstimate
  include FindDriver

  def new
    @cab_types = CabType.all
  end

  def create
    source = params[:source_location]
    destination = params[:destination_location]
    cab_type = CabType.find(params[:cab_type])

    distance = calculate_distance(source.split(','), source.split(',')).round(2)
    fare = calculate_fare_estimate(distance, cab_type).round(2)
    tax = calculate_tax(fare).round(2)
    total = (fare + tax)

    @driver = find_driver(source, cab_type)
    @booking = Booking.new(source: source, destination: destination, distance: distance, price: total, user: current_user, driver: @driver, status: 1, cab_type: cab_type)

    if @booking.save
      @driver.update(available: false)
      session[:current_booking] = @booking.id
    else
      @error = @driver.errors.full_messages.fist
    end

    respond_to do |format|
      format.js
    end
  end

  def confirm_booking
    @booking = Booking.find(session[:current_booking])
    @booking.update(status: 2)
  end

  def current_booking
  end
end
