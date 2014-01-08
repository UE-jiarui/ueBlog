'user strict'

/**
 * 登录
 * @date 2013.12.25
 * @author xuhua
 */
BlogContrllers.controller('LoginCtrl', ['$scope', '$http', '$location', function($scope, $http, $location){

	$scope.loginUser = {
		username: '',
		password: ''
	}

	$scope.login = function(){
		$http.post('/user/login',$scope.loginUser).success(function(data){
			if(data.err){
				return $scope.err = data.err;
			}
			$location.path("/");
		});
	}
}]);