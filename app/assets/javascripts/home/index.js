var autocompleteStartingPoint, autocompleteDestination;

document.addEventListener("DOMContentLoaded", function(event) { 
  document.getElementById('startingPoint').addEventListener('focus', function(){
    autocomplete = autocompleteStartingPoint;
  });

  document.getElementById('destination').addEventListener('focus', function(){
    autocomplete = autocompleteDestination;
  });
});

function initAutocomplete() {

  autocompleteStartingPoint = new google.maps.places.Autocomplete(
    (document.getElementById('startingPoint'))
  );

  autocompleteDestination = new google.maps.places.Autocomplete(
    (document.getElementById('destination'))
  );

  autocompleteStartingPoint.addListener('place_changed', detailsForStart);
  autocompleteDestination.addListener('place_changed', detailsForEnd);
}

function detailsForStart() {
  var place = autocompleteStartingPoint.getPlace();
  console.log(
    "Latitude, Longitude pair - (", place.geometry.location.lat(),
    ", ", place.geometry.location.lng(), ")")
}

function detailsForEnd() {
  var place = autocompleteDestination.getPlace();
  console.log(
    "Latitude, Longitude pair - (", place.geometry.location.lat(),
    ", ", place.geometry.location.lng(), ")")
}

function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}