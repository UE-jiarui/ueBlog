'use strict'
/**
 * 发表博客
 * @date 2013.12.21
 * @author xuhua
 */
BlogContrllers.controller('PostCtrl',['$scope', '$http', '$location','$routeParams','articleForCommon' , function($scope, $http, $location, $routeParams, articleForCommon){
	// 判断是新建还是编辑
	var articleId = $routeParams.articleId === "create" ? false : $routeParams.articleId;
	if(articleId){
			articleForCommon.get({id: articleId, decode: true}, function(data){
				$scope.article = data.article;
			})
	} else {
		$scope.article = {
			title: "",
			articleContent: "",
			tags: ""
		}
	}
	$scope.postArgs = {
		isEdit: true
	}
	// 发表新博客
	$scope.post = function(){
		// tags分隔成数组
		$scope.article.tags = typeof($scope.article.tags) ==="string" ? $scope.article.tags.split("/[,，;]/") : $scope.article.tags;
		// 保存
		articleForCommon.save($scope.article, function(data){
			if(data.err){
				alert(data.err);
			}
			$location.path("/");
		});
	}
}])