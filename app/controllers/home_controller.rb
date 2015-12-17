class HomeController < ApplicationController
  def index
    @cab_types = CabType.all
  end

  def request_booking
    source_place_id = params[:source_place_id]
    destination_place_id = params[:destination_place_id]
    vehicle_type = params[:cab_type]

    if params[:commit] == 'Request Cab'
      redirect_to controller: :bookings, action: :new, source: source_place_id, destination: destination_place_id, vehicle_type: vehicle_type
    elsif params[:commit] == 'Get Fare Estimate'
      redirect_to controller: :bookings, action: :fare_estimate, source: source_place_id, destination: destination_place_id, vehicle_type: vehicle_type
    end
  end
end
