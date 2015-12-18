class BookingsController < ApplicationController
  def new
    @cab_types = CabType.all
  end

  def find_cabs
    @source = params[:source_location]
  end

  def create
    @source = params[:source_location]
    @destination = params[:destination_location]
    @cab_type = params[:cab_type]
  end
end
