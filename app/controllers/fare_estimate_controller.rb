class FareEstimateController < ApplicationController
  include FareEstimate

  def index
    @cab_types = CabType.all
    @source = Geocoder.search(params[:source], lookup: :google_places_details)[0].formatted_address
    @destination = Geocoder.search(params[:destination], lookup: :google_places_details)[0].formatted_address
    @cab_type = params[:cab_type].to_s
  end
end
