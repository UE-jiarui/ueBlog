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

	$scope.logout = function(){
		$http.get('/user/logout').success(function(data){
			$scope.checkLogin();
			$location.path("/");
		});
	}
}]);