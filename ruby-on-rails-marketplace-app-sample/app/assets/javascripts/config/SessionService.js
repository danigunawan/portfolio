angular.module('market')
	.run(function ($rootScope, SessionService) {
		$rootScope.SessionService = SessionService;
	});
