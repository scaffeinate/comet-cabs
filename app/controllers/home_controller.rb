class HomeController < ApplicationController
  def index
    @cab_types = CabType.all
  end
end
