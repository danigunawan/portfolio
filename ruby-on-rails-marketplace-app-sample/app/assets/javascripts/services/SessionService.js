angular.module('market')
	.service('SessionService', function (Restangular, $timeout, $mdDialog) {
		SessionService = {
			_categories: false,
			// Loads the categories from the meta api at the server.
			get categories() {
				if (SessionService._categories || SessionService._categories.length) return SessionService._categories;

				SessionService._categories = true;

				Restangular.all('categories.json').getList({ page_size: 100 }).then(function(response){
					SessionService._categories = response;

					// Set top level cats.
					SessionService.TopLevelCategories = _.sortBy(_.select(response, function(i) {return !i.category;}),function (item) {return item.name;});
					SessionService.TreeOfCategories = [];
					angular.forEach(SessionService.TopLevelCategories, function (item) {
						SessionService.TreeOfCategories.push(item);
						SessionService.TreeOfCategories = SessionService.TreeOfCategories.concat(item.categories);
					});
				});

				return SessionService._categories;
			},

			_savedSearches: false,
			// Loads the savedSearches from the meta api at the server.
			get savedSearches() {
				if (SessionService._savedSearches || SessionService._savedSearches.length) return SessionService._savedSearches;

				SessionService._savedSearches = true;

				Restangular.all('account/saved-searches.json').getList({ page_size: 100 }).then(function(response){
					SessionService._savedSearches = response;
				});

				return SessionService._savedSearches;
			}
		}

		// Helper function for retrieving the oppropriate category for the requested
		// category_id. Returns a category object.
		SessionService.categoryById = function(category_id) {
			return _.select(SessionService.categories, function(i) { return category_id == i.id })[0];
		};

		// Loads the subcategories for a given category. If null then
		// all top level categories are returned.
		SessionService.subcategories = function (category) {
			if (category) return category.categories;
			return SessionService.TopLevelCategories;
		};

		SessionService.openModal = function (templateUrl) {
			$mdDialog.show({
				controller: function ($scope, $mdDialog) {
					// Decouple input post.
					$scope.SessionService = SessionService;
				},
				templateUrl: templateUrl,
				parent: angular.element(document.body),
				targetEvent: event,
				clickOutsideToClose: true,
				fullscreen: true
			})
		}

		SessionService.closeModal = function () {
			$mdDialog.hide();
		}

		SessionService.closeModals = function () {
			$mdDialog.hide();
		}

		SessionService.gallery = {
			gallery_config: {
				thumbnails: false,
				thumbSize: 80,
				imgBubbles: true,
				inline: false,
				bg_close: true,
				piracy: true,
				image_animation: 'fadeup'
			}
		};

		SessionService.openImageGallery = function (images) {
			SessionService.gallery.images = images;
			SessionService.gallery.methods.open();
		};

		// Init categories.
		SessionService.categories;

		return SessionService;
	})
