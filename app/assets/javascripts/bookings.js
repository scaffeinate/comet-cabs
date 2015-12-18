// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var travel_mode, directions_service,
  directions_display, geocoder, source_element, destination_element;

$(document).ready(function(){
  var map_element = document.getElementById('map');
  var map_current_element = document.getElementById('map-current');
  source_element = document.getElementById('source');
  destination_element = document.getElementById('destination');

  travel_mode = google.maps.TravelMode.DRIVING
  directions_service = new google.maps.DirectionsService;
  directions_display = new google.maps.DirectionsRenderer;
  geocoder = new google.maps.Geocoder;

  if(map_element != null) {
    initMap(map_element);
  }

  if(source_element != null && destination_element != null) {
    initAutocomplete(source_element, destination_element);
  }

  // var source_current_element = document.getElementById('source_current');
  // var destination_current_element = document.getElementById('destination_current');
  //
  // if(source_current_element != null && destination_current_element != null) {
  //   initAutocomplete(source_current_element, destination_current_element);
  // }

});
