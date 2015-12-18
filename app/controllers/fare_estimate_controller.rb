class FareEstimateController < ApplicationController
  include FareEstimate

  def calculate_fare
    distance = calculate_distance(params[:source].split(','), params[:destination].split(',')).round(2)
    cab_type = CabType.find(params[:cab_type])
    fare = calculate_fare_estimate(distance, cab_type).round(2)
    tax = calculate_tax(fare).round(2)
    total = (fare + tax)
    render json: { distance: distance, fare: fare, tax: tax, total: total, cab_type: cab_type.name }.to_json
  end
end
