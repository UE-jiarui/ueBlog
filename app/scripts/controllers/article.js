'use strict'

BlogContrllers.controller('ArticleCtrl',['$scope','$rootScope', '$http','$routeParams' , 'articleForCommon','$location', function($scope, $rootScope, $http, $routeParams, articleForCommon, $location){
	 $scope.articleId = $routeParams.articleId;
	 $scope.articles = articleForCommon.get({id: $scope.articleId});

	 $scope.starArticle = function(){
	 	
	 }

	 // 删除博客
	 $scope.deleteArticle = function(){
	 		if(confirm("Are you sure?")){
	 			articleForCommon.delete({id: $scope.articleId}, function(data){
		 			if(data.flag === true){
		 					$location.path("/");
		 			} else {
		 				alert(data.flag);
		 			}
		 			
		 		});
	 		}
	 }
}]);