/**
 * 发表博客
 * @date 2013.12.21
 * @author xuhua
 */
BlogContrllers.controller('PostCtrl',['$scope', '$http', '$location', function($scope, $http, $location){
	$scope.article = {
		title: "",
		content: ""
		// tags: []
	}
	// 发表新博客
	$scope.post = function(){
		$http.post('/article/save',$scope.article).success(function(data){
			console.log($scope.article)
			if(data.err){
				alert(data.err);
			}
			$location.path("/");
		});
	}
}])