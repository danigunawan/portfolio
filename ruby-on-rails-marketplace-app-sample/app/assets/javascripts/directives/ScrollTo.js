// Scroll To Animations.
angular.module('market')
	.service('ScrollTo', function () {
		ScrollTo = {
			id: function (attributeId, offset) {
				$('html, body').stop().animate({scrollTop:$(attributeId).first().offset().top - offset - $('.top-bar-fixed').outerHeight() - $('.notifications').outerHeight()}, 1000, 'swing')
			}
		}

		return ScrollTo;
	})

	.directive('scrollTo', function(ScrollTo) {
		return {
			link: function(scope, element, attrs) {
				var value = attrs.scrollTo;
				element.click(function() {
					scope.$apply(function() {
						ScrollTo.id(value,0)
					});
				});
	    }
	  };
	});
