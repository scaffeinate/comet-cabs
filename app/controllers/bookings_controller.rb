class BookingsController < ApplicationController
  include FareEstimate

  def new
    @cab_types = CabType.all
  end

  def create
    source = params[:source_location]
    destination = params[:destination_location]
    cab_type = CabType.find(params[:cab_type])

    distance = calculate_distance(params[:source].split(','), params[:destination].split(',')).round(2)
    total = calculate_fare_estimate(distance, cab_type).round(2) + calculate_tax(fare).round(2)

    @driver = find_driver(source, cab_type)
    @booking = Booking.create(source: source, destination: destination, distance: distance, fare: total, user: current_user, driver: @driver, status: 1)
    session[:current_booking] = @booking.id
  end

  def confirm_booking
    @booking = Booking.find(session[:current_booking])
    @booking.update(status: 2)
  end
end
