class FareEstimateController < ApplicationController
  include FareEstimate

  # def index
  #   @cab_types = CabType.all
  #   @source = Geocoder.search(params[:source], lookup: :google_places_details)[0].formatted_address
  #   @destination = Geocoder.search(params[:destination], lookup: :google_places_details)[0].formatted_address
  #   @cab_type = params[:cab_type].to_s
  # end

  def calculate_fare
    distance = calculate_distance(params[:source].split(','), params[:destination].split(','))
    fare = calculate_fare_estimate(distance, params[:cab_type]).round(2)
    tax = calculate_tax(fare).round(2)
    total = (fare + tax)
    render json: { fare: fare, tax: tax, total: total }.to_json
  end
end
