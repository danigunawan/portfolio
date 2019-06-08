// require turbolinks
//= require jquery
//= require jqueryui
//= require jquery_ujs
//= require angular-custom-patch/angular
//= require angular-aria
//= require angular-animate
//= require angular-material
//= require angular-ui-router
//= require angular-rails-templates
//= require angular-youtube-mb
//= require angular-bootstrap
//= require angular-inview
//= require seiyria-bootstrap-slider/dist/bootstrap-slider.js
//= require angular-bootstrap-slider
//= require ng-image-gallery/dist/ng-image-gallery.min
//= require lodash/dist/lodash
//= require gridster/dist/jquery.gridster.min.js
//= require angular-simple-logger/dist/angular-simple-logger.min
//= require angular-google-places-autocomplete/src/autocomplete
//= require angular-google-maps/dist/angular-google-maps.min
//= require ng-file-upload-shim
//= require ng-file-upload
//= require ngSticky
//= require restangular
//= require materialize/dist/js/materialize.min
//= require ng-tags-input/ng-tags-input.min
//= require angular-money-directive/dist/angular-money-directive.min
//= require_tree ./lib
//= require_tree ./
//= require ./app

// function initMap(lat, lng, locations, obj) {
// 	var map = new google.maps.Map(obj, {
// 		zoom: 12,
// 		center: {
// 			lat: lat,
// 			lng: lng
// 		}
// 	});
//
// 	for (var i = 0; i < locations.length; i++) {
// 			var location = locations[i];
// 			var marker = new RichMarker({
// 					marker_id: i,
// 					map: map,
// 					position: new google.maps.LatLng(location[0], location[1]),
// 					flat: true,
// 					content: '<div class="marker"><img src="/assets/product/'+location[4]+'"><div class="price"><span class="text-blue">'+location[2]+'</span> '+location[3]+'</div></div>'
// 			});
//
// 			google.maps.event.addListener(marker, 'click', function() {
// 					console.log('Clicked: '+ locations[this.marker_id][0] + ', ' + locations[this.marker_id][1])
// 			});
// 	}
// }
//
// function geocodeAddress(geocoder, resultsMap, address) {
// 	geocoder.geocode({'address': address}, function(results, status) {
// 		if (status === 'OK') {
// 			resultsMap.setCenter(results[0].geometry.location);
// 			var marker = new google.maps.Marker({
// 				map: resultsMap,
// 				position: results[0].geometry.location,
// 				icon: '/assets/marker.png'
// 			});
// 		} else {
// 			alert('Geocode was not successful for the following reason: ' + status);
// 		}
// 	});
// }

$(function() {
	$(document).foundation();

	$(document).bind("ready scroll", function () {
		if($(document).scrollTop() >= 10){
			$(".top-bar-fixed").addClass("scrolled")
		} else {
			$(".top-bar-fixed").removeClass("scrolled")
		}
	})

	window.addEventListener("dragover",function(e){
		e = e || event;
		e.preventDefault();
	},false);

	window.addEventListener("drop",function(e){
		e = e || event;
		e.preventDefault();
	},false);

	$('.product-media').removeClass('hide');
})

console.warn = function() {};
