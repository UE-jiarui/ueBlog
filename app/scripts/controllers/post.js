/**
 * 发表博客
 * @date 2013.12.21
 * @author xuhua
 */
BlogContrllers.controller('PostCtrl',['$scope', '$http', function($scope, $http){
	$scope.article = {
		title: "",
		content: ""
		// tags: []
	}
	// 发表新博客
	// 未实现
	$scope.post = function(){
		$http.post('/article',$scope.article).success(function(data){
			console.log($scope.article)
			// if(data.err){
			// 	return $scope.err = data.err;
			// }
			$location.path("/");
		});
	}
}])