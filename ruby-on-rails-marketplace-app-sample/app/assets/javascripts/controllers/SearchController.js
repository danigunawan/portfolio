angular.module('market')

  .controller('market.SearchController', function ($scope, $window, $location, $sce, $timeout, $http, SessionService, ScrollTo) {
		$scope.search = {};

    $scope.trustAsHtml = function(snippet) {
      return $sce.trustAsHtml(snippet);
    };

		$scope.navigateToSavedSearch = function () {
			document.location = $scope.savedSearch.state_path;
		}

		$scope.dirtySearchQuery = function () {
			$scope.searchQuery.userInteraction = true;
		}

		$scope.isSearchSaved = function (searchId) {
			return _.findIndex(SessionService.savedSearches, function(savedSearch) { return savedSearch.search.id == searchId }) >= 0
		}

		$scope.searchQuery = {
			_params: jQuery.query,
			get params() {
				// return $scope.searchQuery._params.set('page',$scope.searchQuery.page);
				return $scope.searchQuery._params;
			},

			// Sets the updated params to the url location without reload.
			set params(newValue) {
				newValue.keys = _.omit(newValue.keys, function(value, key, object) {
					return _.isBoolean(value);
				});
				$scope.searchQuery._params = newValue;
				// Set new url location.
				if ($scope.searchQuery.userInteraction)
					history.replaceState(null, null, '/search' + newValue);

        return '/search' + newValue;
			},

			// =======================================================================
			// Search Query Execution
			// =======================================================================

			// Runs the current searchQuery params and renders the new results.
			_markers: {},
			_matrix_markers: {},
			_response: {},
			get response() {
				if ($scope.searchQuery.lastQueriedParams == $scope.searchQuery.params)
					return $scope.searchQuery._response;

				$scope.searchQuery.lastQueriedParams = $scope.searchQuery.params;

				$http.get('/search.json' + $scope.searchQuery.lastQueriedParams.set('page',(parseInt(jQuery.query.get("page")) || 1)) + '&matrix=true').then(function(response){
					$scope.searchQuery._response = response.data;
					$scope.searchQuery.pages = parseInt($scope.searchQuery._response.pages);

					if ($scope.searchQuery._response.latitude && $scope.searchQuery._response.longitude && $scope.searchQuery._reloadLocationCoords) {
						$scope.searchQuery.map.setCenter(new google.maps.LatLng($scope.searchQuery._response.latitude, $scope.searchQuery._response.longitude));
						$scope.searchQuery._reloadLocationCoords = false;
					}

					// Remove all old markers that arent in the new results.
					angular.forEach($scope.searchQuery._markers, function (marker, id) {
						if (!_.filter($scope.searchQuery._response.results,function(item){return item.id == id}).length)
							$scope.searchQuery._markers[id].setMap(null);
					});

          // Remove all old markers that arent in the new results.
					angular.forEach($scope.searchQuery._matrix_markers, function (marker, id) {
						if (!_.filter($scope.searchQuery._response.matrix,function(item){return item.id == id}).length)
							$scope.searchQuery._matrix_markers[id].setMap(null);
					});

          if ($scope.searchQuery._response.matrix && $scope.searchQuery._response.matrix.length)
            for (var i = 0; i < $scope.searchQuery._response.matrix.length; i++) {
  						var listing = $scope.searchQuery._response.matrix[i];

  						// Create the marker for this listing result if it doesn't already exist.
  						if (!$scope.searchQuery._matrix_markers[listing.id]) {
  							$scope.searchQuery._matrix_markers[listing.id] = new RichMarker({
  								marker_id: listing.id,
  								map: $scope.searchQuery.map,
  								position: new google.maps.LatLng(listing.latitude, listing.longitude),
  								flat: true,
  								content: '<a class="mini-marker" href="' + listing.url + '" target="_blank"></a>'
  							});

  							google.maps.event.addListener($scope.searchQuery._matrix_markers[listing.id], 'click', function() {
  								console.log('Clicked: '+ $scope.searchQuery._response.matrix[this.marker_id].id + ', ' + $scope.searchQuery._response.matrix[this.marker_id].title)
  							});
  						} else if (!$scope.searchQuery._matrix_markers[listing.id].map) {
  							// Reconnect all dormat markers back to the current map display.
  							$scope.searchQuery._matrix_markers[listing.id].setMap($scope.searchQuery.map);
  						}
  					}

          for (var i = 0; i < $scope.searchQuery._response.results.length; i++) {
						var listing = $scope.searchQuery._response.results[i];

						// Create the marker for this listing result if it doesn't already exist.
						if (!$scope.searchQuery._markers[listing.id]) {
							$scope.searchQuery._markers[listing.id] = new RichMarker({
								marker_id: listing.id,
								map: $scope.searchQuery.map,
								position: new google.maps.LatLng(listing.latitude, listing.longitude),
								flat: true,
								content: '<a class="marker ' + (listing.photos && listing.photos.length ? '' : 'no-photo') + '" href="' + listing.url + '" target="_blank"><div class="img-container">' + (listing.photos && listing.photos.length ? ('<img src="' + listing.photos[0].url + '">') : ('')) + '</div><div class="price"><span class="text-blue">' + (listing.price || listing.name) + '</span> ' + (listing.price_unit ? listing.price_unit : '') + '</div></a>'
							});

							google.maps.event.addListener($scope.searchQuery._markers[listing.id], 'click', function() {
								console.log('Clicked: '+ $scope.searchQuery._response.results[this.marker_id].id + ', ' + $scope.searchQuery._response.results[this.marker_id].title)
							});
						} else if (!$scope.searchQuery._markers[listing.id].map) {
							// Reconnect all dormat markers back to the current map display.
							$scope.searchQuery._markers[listing.id].setMap($scope.searchQuery.map);
						}
					}

					$scope.searchQuery.loadingNewResults = false;
					// if ($scope.searchQuery.userInteraction) $scope.searchQuery.fitBoundsToMarkers();
				},function(error) {
					console.log(error);
				});
			},

			// ==================================================================================
			// Query params
			// ==================================================================================

			_keywords: jQuery.query.get("keywords") && _.isString(jQuery.query.get("keywords")) ? jQuery.query.get("keywords") : '',
			get keywords () {
				return $scope.searchQuery._keywords;
			},
			set keywords (newValue) {
				$scope.searchQuery._keywords = newValue;
				$scope.searchQuery.params = $scope.searchQuery.params.set("keywords", newValue);
				$scope.searchQuery.page = 1;
			},

			_location: jQuery.query.get("location") && _.isString(jQuery.query.get("location")) ? jQuery.query.get("location") : '',
			get location() {
				return $scope.searchQuery._location;
			},
			set location(newValue) {
				$scope.searchQuery._location = newValue;
				$scope.searchQuery.page = 1;
			},
			_reloadLocationCoords: jQuery.query.get("latitude") && jQuery.query.get("longitude") ? false : (jQuery.query.get("location") ? true : false),
			reloadLocationCoords: function () {
				$scope.searchQuery.params = $scope.searchQuery.params.set("location", $scope.searchQuery.location);
				$scope.searchQuery._reloadLocationCoords = true;
			},

			_category: jQuery.query.get("category_id") ?  {id:jQuery.query.get("category_id")} : null,
			get category() {
				return $scope.searchQuery._category;
			},
			set category(newValue) {
				$scope.searchQuery._category = newValue;
				$scope.searchQuery.params = $scope.searchQuery.params.set("category_id", newValue ? newValue.id : null);
				$scope.searchQuery.page = 1;
			},

			_page: jQuery.query.get("page") ?  jQuery.query.get("page") : 1,
			get page() {
				return parseInt(jQuery.query.get("page")) || 1;
			},
			set page(newValue) {
				if ($scope.searchQuery._page == newValue) return;
				// $scope.searchQuery.loadingNewResults = true;
				$scope.searchQuery._page = newValue;
				$scope.searchQuery.params = $scope.searchQuery.params.set("page", newValue);
			},

      get previousPageUrl() {
        var newParams = $scope.searchQuery.params;
        return '/search' + newParams.set("page", ($scope.searchQuery.page > 1 ? ($scope.searchQuery.page - 1) : null));
      },

      get nextPageUrl() {
        var newParams = $scope.searchQuery.params;
        return '/search' + newParams.set("page", (($scope.searchQuery.page < $scope.searchQuery.pages) ? ($scope.searchQuery.page + 1) : '1'));
      },

			pages: 1,
			get pagesArray() {
				return new Array($scope.searchQuery.pages);
			},

			// ==================================================================================
			// Map params
			// ==================================================================================

			// NOTE: We only use the bounds for listings query fetching and not map instantiation.
			_bounds: jQuery.query.get("bounds") ?  jQuery.query.get("bounds") : null,
			get bounds() {
				return $scope.searchQuery._bounds;
			},
			set bounds(newValue) {
        // if (!$('#map') || $('#map').outerWidth() < 300) newValue = "";
				$scope.searchQuery._bounds = newValue;
				$scope.searchQuery.params = $scope.searchQuery.params.set("bounds", newValue);
        $scope.searchQuery.page = 1;
			},

			// zoom getter/setters updates the map zoom on change.
			_zoom: jQuery.query.get("zoom") ?  jQuery.query.get("zoom") : 4,
			get zoom() {
				return $scope.searchQuery._zoom;
			},
			set zoom(newValue) {
				$scope.searchQuery._zoom = newValue;
				$scope.searchQuery.params = $scope.searchQuery.params.set("zoom", newValue);
        $scope.searchQuery.page = 1;
			},

			// latitude getter/setters updates the map location on change.
			_latitude: jQuery.query.get("latitude") ?  jQuery.query.get("latitude") : null,
			get latitude() {
				return $scope.searchQuery._latitude;
			},
			set latitude(newValue) {
				$scope.searchQuery._latitude = newValue;
				$scope.searchQuery.params = $scope.searchQuery.params.set("latitude", newValue);
			},

			// longitude getter/setters updates the map location change.
			_longitude: jQuery.query.get("longitude") ?  jQuery.query.get("longitude") : null,
			get longitude() {
				return $scope.searchQuery._longitude;
			},
			set longitude(newValue) {
				$scope.searchQuery._longitude = newValue;
				$scope.searchQuery.params = $scope.searchQuery.params.set("longitude", newValue);
			},

			// ==================================================================================
			// Map Instantiation
			// ==================================================================================

			// Inits and sets the map for the current query.
			get map() {
				if ($scope.searchQuery._map) return $scope.searchQuery._map;

				// Tie map to div with id #map
				var container = document.getElementById('map');

				$scope.searchQuery._map = new google.maps.Map(container, {
					zoom: $scope.searchQuery.zoom,
          scrollwheel: true,
          mapTypeControl: true,
          mapTypeControlOptions: {
              style: google.maps.MapTypeControlStyle.VERTICAL_BAR,
              position: google.maps.ControlPosition.TOP_LEFT
          },
          zoomControl: true,
          zoomControlOptions: {
              position: google.maps.ControlPosition.TOP_RIGHT
          },
          scaleControl: true,
          streetViewControl: false,
          fullscreenControl: false,
          center: {
						lat: $scope.searchQuery.latitude,
						lng: $scope.searchQuery.longitude
					}
				});

				// We rely on the map bounds to determine the zoom level
				$scope.searchQuery._map.addListener("zoom_changed", function() {
					$scope.searchQuery._map.mapStateDidChange = true;
				});

				// We rely on the map bounds to determine the position/pan
				$scope.searchQuery._map.addListener("mouseup", function() {
					$scope.searchQuery._map.mapStateDidChange = true;
					$scope.dirtySearchQuery()
				});

				// We rely on the map bounds to determine the position/pan
				$scope.searchQuery._map.addListener("mousedown", function() {
					$scope.searchQuery._map.mapStateDidChange = true;
					$scope.dirtySearchQuery();
				});

				$scope.searchQuery._map.addListener('bounds_changed', function() {
          // Causes a false assignment of empty bounds on mobile.
					// $scope.searchQuery._map.mapStateDidChange = true;
				});

				$scope.searchQuery._map.addListener('idle', function() {
					if ($scope.searchQuery._map.mapStateDidChange) {
						$scope.searchQuery.bounds = $scope.searchQuery._map.getBounds().toUrlValue();
						$scope.searchQuery._latitude = $scope.searchQuery._map.center.lat();
						$scope.searchQuery._longitude = $scope.searchQuery._map.center.lng();
						$scope.searchQuery._zoom = $scope.searchQuery._map.getZoom();
						$scope.searchQuery.params = $scope.searchQuery.params
							.set("longitude", $scope.searchQuery._map.center.lng())
							.set("latitude", $scope.searchQuery._map.center.lat())
							.set("zoom", $scope.searchQuery._map.getZoom());

						// Reload response.
						$scope.searchQuery.response;

						$scope.searchQuery._map.mapStateDidChange = false
					}
				});

				return $scope.searchQuery._map;
			},

			fitBoundsToMarkers: function () {
				var bounds = new google.maps.LatLngBounds();

				angular.forEach($scope.searchQuery._markers, function (marker, id) {
					// bounds.extend($scope.searchQuery._markers[id].getPosition());
					console.log(bounds, $scope.searchQuery._markers[id].getPosition())
				});

				$scope.searchQuery.map.fitBounds(bounds);
			}
		}
		$scope.searchQuery.params = jQuery.query;

		$(".blur-on-enter").bind('keyup',function(e) {
			if (e.keyCode === 13)
				$(this).blur();
		});

    $scope.setMapDimensions = function () {
      // $(".search-container").css({'height': $(window).outerHeight() - $(".top-bar-fixed").outerHeight()})
      if ($(window).outerWidth() > 800) {
        $(".listings-map").css({
          'max-width': $(window).outerWidth() - $('.search-results-container').outerWidth(),
          // 'height': $(window).outerHeight() - $(".top-bar-fixed").outerHeight()
        });
      }
    }

    $scope.setMapDimensions();
    $timeout($scope.setMapDimensions,1000);
		$(window).resize(function() {
      $scope.setMapDimensions();
		});


		$('.body-content').bind("ready scroll", function () {
      if($('.body-content').scrollTop() >= 57){
				$(".search-container .filters").addClass("scrolled")
			} else {
        $scope.setMapDimensions();
				$(".search-container .filters").removeClass("scrolled")
			}

			if($('.body-content').scrollTop() >= ($('.filters').outerHeight() + ($(".headliner").length ? $(".headliner").outerHeight() : 0)) && $('.search-results').outerHeight() > $('.listings-map').outerHeight()) {
				$(".search-container .listings-map").addClass("scrolled");
				$(".listings-map").css({"margin-top":$(".top-bar-fixed").outerHeight()})
			} else {
				$(".search-container .listings-map").removeClass("scrolled")
				$(".listings-map").css({"margin-top":0})
			}
		});
	});
