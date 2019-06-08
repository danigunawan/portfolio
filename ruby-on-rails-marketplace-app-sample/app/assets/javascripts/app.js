angular
  .module('market', [
		'uiGmapgoogle-maps',
		'google.places',
		'ngMaterial',
		'ui.bootstrap-slider',
		'templates',
		'restangular',
		'youtube-embed',
		'sticky',
		'ngFileUpload',
		'angular-inview',
		'thatisuday.ng-image-gallery',
		'fiestah.money',
		'ngTagsInput',
		'angular-bind-html-compile'
  ])

  .config(function (RestangularProvider) {
    // Restangular configuration:
    RestangularProvider.setBaseUrl('/');

    RestangularProvider.setRestangularFields({
      selfLink: "self.ref"
    });
  })

	.run(function(SessionService, $rootScope) {
		$rootScope.SessionService = SessionService;
		url = new URL(document.location);
		if (url.searchParams.get("modal")) SessionService.openModal(url.searchParams.get("modal") + '.html');
	})

  .service('globalDispatchService', function() {
    var variableSet = {};

    var getVariable = function(key) {
      return variableSet[key]
    }

    var setVariable = function(key, value) {
      return variableSet[key] = value;
    }

    return {
      variableSet: variableSet,
      getVariable: getVariable,
      setVariable: setVariable
    }
  });
