module FareEstimate
  extend ActiveSupport::Concern

  def calculate_distance(_source, _destination)
    puts Geocoder.search(_source, lookup: :google_places_details).inspect
  end

  def calculate_fare_estimate(_distance, _cab_type)
  end
end
