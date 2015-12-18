module ErrorMessage
  def valid_location?(_source, _destination, _cab_type)
    @error = 'Source Location is invalid' if _source.blank?
    @error = 'Destination is invalid' if _destination.blank?
    @error = 'Not a valid cab type selection' if _cab_type.blank?
    @error
  end
end
