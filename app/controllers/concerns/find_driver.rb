module FindDriver
  extend ActiveSupport::Concern
  def find_driver(_source, _cab_type)
    lat = _source.split(',')[0].to_f
    lng = _source.split(',')[1].to_f

    records = Driver.find_by_sql ["SELECT id, (3959 * acos (
      cos(radians(?))
      * cos(radians(latitude))
      * cos(radians(longitude) - radians(?))
      + sin(radians(?))
      * sin(radians(latitude))
      )
    ) AS distance FROM Drivers ORDER BY (3959 * acos (
      cos(radians(?))
      * cos(radians(latitude))
      * cos(radians(longitude) - radians(?))
      + sin(radians(?))
      * sin(radians(latitude))
      )
    ) LIMIT 10", lat, lng, lat, lat, lng, lat]

    records.each do |_r|
      driver = Driver.find(_r)
      return driver if driver.available?
    end
  end
end
