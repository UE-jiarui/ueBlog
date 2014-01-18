'user strict'

/**
 * 首页
 * @date 2013.12.27
 * @author xuhua
 */
BlogContrllers.controller('IndexCtrl',['$scope', '$http',function($scope, $http){
	$scope.$parent.checkLogin();
	$scope.articles = {};
	$http.post('/article/getAllArticle', {pageNum:1}).success(function(data){
		$scope.articles = data.articles;
	});
}]);