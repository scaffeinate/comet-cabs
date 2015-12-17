// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  initMap();
  initAutocomplete();
});

function initMap() {
  var mapId = document.getElementById('map');
  if(mapId != null) {
    var map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -33.8688, lng: 151.2195},
      zoom: 13
    });
  }
}

function initAutocomplete() {
  sourceAutocomplete = new google.maps.places.Autocomplete(
    (document.getElementById('source')), {
      types: ['geocode']
  });
  destinationAutocomplete = new google.maps.places.Autocomplete(
    (document.getElementById('destination')), {
      types: ['geocode']
  });

  sourceAutocomplete.addListener('place_changed', fillInAddress);
  destinationAutocomplete.addListener('place_changed', fillInAddress);
}

function fillInAddress() {
  if(this == sourceAutocomplete) {
    $('#source_place_id').val(this.getPlace().place_id);
  } else if (this == destinationAutocomplete) {
    $('#destination_place_id').val(this.getPlace().place_id);
  }
}
