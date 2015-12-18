// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  $('#get_fare_estimate').click(function(e){
    e.preventDefault();
    if(!source_location) {
      alertify.error('Source is invalid');
    }

    if(!destination_location) {
      alertify.error('Destination is invalid');
    }

    if(!cab_type) {
      alertify.error('Cab Type is invalid');
    }

    var fare_estimates_path = this.href + '.json?source=' + source_location + '&destination=' + destination_location + '&cab_type=' + $("input[type='radio'][name='cab_type']:checked").val();
    $.get(fare_estimates_path, function(data){
      $('#source_read_only').val(source_element.value);
      $('#destination_read_only').val(destination_element.value);
      $('#cab_type').text(data.cab_type + ' Cab for ' + data.distance + ' miles');
      $('#max_persons').text(data.max_persons + ' People');
      $('#total').text(data.total + '$');
      $('#split_up').text(data.fare + '$' + ' + ' + data.tax + '$');
      $('#fare-estimate-modal').modal('show');
    });
  });
});
