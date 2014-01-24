'user strict'

/**
 * 首页
 * @date 2013.12.27
 * @author xuhua
 */
BlogContrllers.controller('IndexCtrl',['$scope', '$http', '$routeParams', '$location',function($scope, $http, $routeParams, $location){
	var pageNum = $routeParams.page || 1;

	$scope.$parent.checkLogin();
	$scope.articles = {};
	// 分页获取文章列表
	$http.post('/article/getAllArticle', { pageNum: pageNum }).success(function(data){
		$scope.articles = data.articles;
		$scope.paginate = {
			totalPages: data.pageCount,
			currentPage: pageNum,
			itemsPerPage: 5
		}
	});

}]);