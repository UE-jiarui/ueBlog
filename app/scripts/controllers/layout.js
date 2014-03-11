'user strict'

/**
 * 框架控制
 * @date 2013.12.21
 * @author xuhua
 */
BlogContrllers.controller('LayoutCtrl',['$scope', '$rootScope', '$http','$location', '$window',
 function($scope, $rootScope, $http, $location, $window){
	// $scope.loginName = false;
	// 获取登录session信息
	$scope.checkLogin = function(){
		$http.get('/user/getLoginUser').success(function(data){
			$rootScope.loginUser = data.username ? data : "";
			$rootScope.loginName = data.username;
		});
	}
	$scope.checkLogin();

	$scope.submitUser = {
		username: '',
		password: ''
	}

	// 控制登录框的显示与聚焦
	$scope.loginShow = false;
	$scope.switchLoginShow = function(){
		$scope.loginShow = !$scope.loginShow;
		if($scope.loginShow){
			setTimeout(function(){
				$("input[name='username']").focus();
			},0);
		}
	}

	// 登录
	$scope.login = function($event){
		if($event.keyCode === 13){
			$http.post('/user/login',$scope.submitUser).success(function(data){
				if(data.err){
					return $scope.err = data.err;
				}
				console.log($location);
				$window.location.reload();
				// $scope.checkLogin();
				// $scope.switchLoginShow();
			});
		}
	}

	// 注销
	$scope.logout = function(){
		$http.get('/user/logout').success(function(data){
			$scope.checkLogin();
			$window.location.href = "/";
			// $location.path("/");
		});
	}
}]);