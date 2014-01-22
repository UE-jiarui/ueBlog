'use strict'

BlogContrllers.controller('ArticleCtrl',['$scope', '$http','$routeParams' , 'articleForCommon', function($scope, $http, $routeParams, articleForCommon){
	 $scope.articleId = $routeParams.articleId;
	 $scope.articles = articleForCommon.get({id: $scope.articleId});
	 // console.log(article);
}]);