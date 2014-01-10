'user strict'

/**
 * 注册
 * @date 2013.12.21
 * @author xuhua
 */
BlogContrllers.controller('RegisterCtrl', ['$scope', '$http', '$location', function($scope, $http, $location){
	$scope.user = {
    username:'',
    password:'',
    repassword:'',
    email:''
  };

	$scope.regist = function(){
		$http.post('/user/regist',$scope.user).success(function(data){
			if(data.err){
				return $scope.err = data.err;
			}
			$location.path("/");
		})
	}
}]);