'user strict'

/**
 * 框架控制
 * @date 2013.12.21
 * @author xuhua
 */
BlogContrllers.controller('LayoutCtrl',['$scope', '$rootScope', '$http','$location', function($scope, $rootScope, $http, $location){
	$scope.loginName = false;
	// 获取登录session信息
	$scope.checkLogin = function(){
		$http.get('/user/getLoginUser').success(function(data){
			$scope.loginName = data.username;
		});
	}
	$scope.checkLogin();

	$scope.loginUser = {
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
		console.log($event);
		if($event.keyCode === 13){
			$http.post('/user/login',$scope.loginUser).success(function(data){
				if(data.err){
					return $scope.err = data.err;
				}
				$scope.checkLogin();
				$scope.switchLoginShow();
			});
		}
	}

	// 注销
	$scope.logout = function(){
		$http.get('/user/logout').success(function(data){
			$scope.checkLogin();
			$location.path("/");
		});
	}
}]);