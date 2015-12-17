// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var sourceAutocomplete, destinationAutocomplete;

$(document).ready(function(){
  initAutocomplete();
});

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
