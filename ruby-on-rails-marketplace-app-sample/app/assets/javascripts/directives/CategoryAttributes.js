// categoryAttributes: A
//
// Encapsulates all logic relevant for selecting categories and sub categories
// Follows a black box functionality from the outsie: ie. Given a respective
// category via the ngModel attribute, the appropriate select fields of parrents
// and children are correctly rendered.
//
// Follows a recurcisve model. A categoryAttributes can have a categoryField...
// Thus, the currently selected category is propogated down the list.
//
angular.module('market')
  .directive('categoryAttributes', function(Restangular, SessionService) {
    return {
      restrict: 'E',
      templateUrl: 'directives/_CategoryAttributes.html',
			scope: {
				category: '=', // Selected category
				name: '=',
				listing: '=',
				form: '=?',
				validate: '=?'
			},
			link: function(scope, element, attributes) {
				// name="listing[category_attribute_values][]" category="listing.category"
				scope.SessionService = SessionService;
      }
    };
  })
