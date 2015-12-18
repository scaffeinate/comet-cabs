class BookingsController < ApplicationController
  def new
    @cab_types = CabType.all
  end

  def find_cab
    @source = params[:source_location]
    @destination = params[:destination_location]
    @cab_type = params[:cab_type]

    puts @source
    puts @destination
    puts @cab_type
  end

  def create
  end
end
