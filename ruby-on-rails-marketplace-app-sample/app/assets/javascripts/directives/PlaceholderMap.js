angular.module('market')
	.directive("placeholderMap", function() {
		return {
			template: "<ui-gmap-google-map center='center' zoom='12' options='options'></>",
			scope: {
				latitude: '=?',
				longitude: '=?'
			},
			link: function(scope, element, attributes, ngModel) {
				scope.center = {};
				scope.options = {
					disableDefaultUI: true
				};

				scope.$watch("latitude", function(newValue) {
					scope.center.latitude = newValue;
				});

				scope.$watch("longitude", function(newValue) {
					scope.center.longitude = newValue;
				});
			}
		};
	});
