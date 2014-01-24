'use strict'
/**
 * 发表博客
 * @date 2013.12.21
 * @author xuhua
 */
BlogContrllers.controller('PostCtrl',['$scope', '$http', '$location','articleForCommon' , function($scope, $http, $location, articleForCommon){
	$scope.article = {
		title: "",
		content: "",
		tags: ""
	}
	$scope.postArgs = {
		isEdit: true
	}
	// 发表新博客
	$scope.post = function(){
		// tags分隔成数组
		$scope.article.tags = $scope.article.tags.split("/[,，;]/");
		// 保存
		articleForCommon.save($scope.article, function(data){
			if(data.err){
				alert(data.err);
			}
			$location.path("/");
		});
	}
}])