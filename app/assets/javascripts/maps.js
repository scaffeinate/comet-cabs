var map = null;

var initMap = function() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 40.6984, lng: -73.9514},
    zoom: 15
  });

  if(navigator.geolocation) {
    browserSupportFlag = true;
    navigator.geolocation.getCurrentPosition(function(position) {
      initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
      map.setCenter(initialLocation);
      geocodeLatLng(map, initialLocation);
    }, function() {
      handleNoGeolocation(browserSupportFlag);
    });
  }

  directions_display.setMap(map);
};
