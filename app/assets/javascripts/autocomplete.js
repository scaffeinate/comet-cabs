var source_place_id = null;
var destination_place_id = null;
var source_location = null, destination_location = null;

var route = function(source_place_id, destination_place_id, flag) {
  if (source_place_id != null && destination_place_id != null) {
    if(current_marker) {
      current_marker.setMap(null);
    }
    directions_service.route({
      origin: {'placeId': source_place_id},
      destination: {'placeId': destination_place_id},
      travelMode: travel_mode
    }, function(response, status) {
      if (status === google.maps.DirectionsStatus.OK) {
        directions_display.setDirections(response);
      } else {
        console.log('Directions request failed due to ' + status);
      }
    });
  }

  if(flag) {
    document.getElementById('source_location').value = source_location;
    document.getElementById('destination_location').value = destination_location;
    document.getElementById('source_place_id').value = source_place_id;
    document.getElementById('destination_place_id').value = destination_place_id;
  }

};

var expandViewportToFitPlace = function(map, place) {
  if (place.geometry.viewport) {
    map.fitBounds(place.geometry.viewport);
  } else {
    map.setCenter(place.geometry.location);
    map.setZoom(17);
  }
};

var initAutocomplete = function(source_element, destination_element) {
  source_autocomplete = new google.maps.places.Autocomplete((source_element), {
    types: ['geocode']
  });

  destination_autocomplete = new google.maps.places.Autocomplete((destination_element), {
    types: ['geocode']
  });

  source_autocomplete.addListener('place_changed', function(){
    var place = this.getPlace();
    if (!place.geometry) {
      console.log('Source place has no geometry');
      return;
    }
    expandViewportToFitPlace(map, place);

    source_place_id = place.place_id;
    source_location = place.geometry.location.lat() + ',' + place.geometry.location.lng();
    route(source_place_id, destination_place_id, true);
  });

  destination_autocomplete.addListener('place_changed', function(){
    var place = this.getPlace();
    if(!place.geometry) {
      console.log('Destination place has no geometry');
      return;
    }

    destination_place_id = place.place_id;
    destination_location = place.geometry.location.lat() + ',' + place.geometry.location.lng();
    route(source_place_id, destination_place_id, true);
  });
};
