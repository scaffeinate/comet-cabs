// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var map, travel_mode, directions_service, directions_display;
var map_element, source_element, destination_element;
var source_place_id = null;
var destination_place_id = null;
var source_location, destination_location;

var route = function(source_place_id, destination_place_id) {
  if (source_place_id != null && destination_place_id != null) {
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

  document.getElementById('source_location').value = source_location;
  document.getElementById('destination_location').value = destination_location;

};

var initMap = function() {
  travel_mode = google.maps.TravelMode.DRIVING
  directions_service = new google.maps.DirectionsService;
  directions_display = new google.maps.DirectionsRenderer;

  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -33.8688, lng: 151.2195},
    zoom: 13
  });
  directions_display.setMap(map);
};

var expandViewportToFitPlace = function(map, place) {
  if (place.geometry.viewport) {
    map.fitBounds(place.geometry.viewport);
  } else {
    map.setCenter(place.geometry.location);
    map.setZoom(17);
  }
};

var initAutocomplete = function() {
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
    route(source_place_id, destination_place_id, source_location);
  });

  destination_autocomplete.addListener('place_changed', function(){
    var place = this.getPlace();
    if(!place.geometry) {
      console.log('Destination place has no geometry');
      return;
    }

    destination_place_id = place.place_id;
    destination_location = place.geometry.location.lat() + ',' + place.geometry.location.lng();
    route(source_place_id, destination_place_id, destination_location);
  });

};

$(document).ready(function(){
  map_element = document.getElementById('map');
  source_element = document.getElementById('source');
  destination_element = document.getElementById('destination');

  if(map_element != null) {
    initMap();
  }

  if(source_element != null && destination_element != null) {
    initAutocomplete();
  }
});
