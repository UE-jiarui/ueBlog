'use strict'

BlogContrllers.controller('ArticleCtrl', ['$scope', '$rootScope', '$http', '$routeParams', 'articleForCommon', '$location', 'isOperated','starArticle',
	function($scope, $rootScope, $http, $routeParams, articleForCommon, $location, isOperated, starArticle) {
		$scope.articleId = $routeParams.articleId;
		$scope.articles = articleForCommon.get({ id: $scope.articleId }, function(){
			$scope.articles.article.isStared = isOperated($scope.articles.article.stared, $rootScope.loginUser);
		});

		// Star the blog.
		$scope.starArticle = starArticle;
		// 更新文章访问记录
		articleForCommon.visit({
			id: $scope.articleId
		});

		// 删除博客
		$scope.deleteArticle = function() {
			if (confirm("Are you sure?")) {
				articleForCommon.remove({
					id: $scope.articleId
				}, function(data) {
					if (data.flag === true) {
						$location.path("/");
					} else {
						alert(data.flag);
					}
				});
			}
		}
	}
]);