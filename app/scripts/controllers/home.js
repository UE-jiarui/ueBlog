'user strict'

/**
 * 首页
 * @date 2013.12.27
 * @author xuhua
 */
BlogContrllers.controller('IndexCtrl',['$scope', '$rootScope', '$http', '$routeParams', '$location', 'articleForCommon', 'starArticle', 'isOperated',
	function($scope, $rootScope, $http, $routeParams, $location, articleForCommon, starArticle, isOperated){
	var pageNum = $routeParams.page || 1;

	$scope.$parent.checkLogin();
	$scope.articles = {};

	// Star the blog.
	$scope.starArticle = starArticle;

	articleForCommon.get({ pageNum: pageNum }, function(data){
	 	$scope.articles = data.articles;
	 	for (var i =0, len = $scope.articles.length; i < len; i++) {
	 		$scope.articles[i].isStared = isOperated($scope.articles[i].stared, $rootScope.loginUser);
	 	};
		$scope.paginate = {
			totalPages: data.pageCount,
			currentPage: pageNum,
			itemsPerPage: 5
		}
	});
}]);