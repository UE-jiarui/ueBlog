/**
 * 发表博客
 * @date 2013.12.21
 * @author xuhua
 */
BlogContrllers.controller('PostCtrl',['$scope', '$http', function($scope, $http){

}])
.controller("DropdownCtrl", ['$scope', 'locale',
	function($scope, locale) {
		$scope.items = locale.editorMsg.font_styles;
	}
])