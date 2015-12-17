class BookingsController < ApplicationController
  def new
    @cab_types = CabType.all
  end
end
