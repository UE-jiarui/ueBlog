BlogDirectives.directive("paginate", ['$timeout', function($timet){
	return {
		restrict: "A",
		replace: true,
		scope: {
			totlePage: "@",
			currentPage: "="
		},
		template: '<div class="container pagination"></div>'
	}
}]);