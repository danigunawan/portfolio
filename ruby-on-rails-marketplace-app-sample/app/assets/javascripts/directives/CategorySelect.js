// categorySelect: E
//
// Encapsulates all logic relevant for selecting categories and sub categories
// Follows a black box functionality from the outsie: ie. Given a respective
// category via the ngModel attribute, the appropriate select fields of parrents
// and children are correctly rendered.
//
// Follows a recurcisve model. A categorySelect can have a categorySelect...
// Thus, the currently selected category is propogated down the list.
//
angular.module('market')
  .directive('categorySelect', function(Restangular, SessionService) {
    return {
      restrict: 'E',
      templateUrl: 'directives/_CategorySelect.html',
			scope: {
				category: '=', // Macro selected category
				selectedCategory: '=?',
				parentCategory: '=?',
				valid: '=?'
			},
			link: function(scope, element, attributes) {
				scope.SessionService = SessionService;

				// Check if no parent is set by a selectedCategory is set.
				if (!scope.parentCategory && scope.selectedCategory && scope.SessionService.categoryById(scope.selectedCategory.id)) scope.parentCategory = scope.SessionService.categoryById(scope.selectedCategory.id).category

				// Loads the subcategories for a given cateory. If null then
				// all top level categories are returned.
				scope.subcategories = function () {

					// Check if no parent is set by a selectedCategory is set.
					// if (!scope.parentCategory && scope.selectedCategory && scope.SessionService.categoryById(scope.selectedCategory.id)) scope.parentCategory = scope.SessionService.categoryById(scope.selectedCategory.id).category
					return scope.SessionService.subcategories(scope.parentCategory);
				};

				// Watch selectedCategory to update main category model.
				scope.updateCategory = function () {
					if (scope.selectedCategory)
						scope.category = scope.selectedCategory;
					else
						scope.category = scope.parentCategory;
				}
      }
    };
  })
