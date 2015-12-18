module FareEstimate
  extend ActiveSupport::Concern

  def calculate_distance(_source, _destination)
    Geocoder::Calculations.distance_between(_source, _destination)
  end

  def calculate_fare_estimate(_distance, _cab_type)
    cab_type = CabType.find(_cab_type)
    base_fare = cab_type.base_fare
    per_mile_fare = cab_type.per_mile_fare

    base_fare + (_distance * per_mile_fare)
  end

  def calculate_tax(_total_fare)
    federal_tax = 0.11
    service_tax = 0.01
    state_tax = 0.03

    total_tax = (_total_fare * federal_tax) + (_total_fare * service_tax) + (_total_fare * state_tax)
  end
end
