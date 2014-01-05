'user strict'

/**
 * 首页
 * @date 2013.12.27
 * @author xuhua
 */
BlogContrllers.controller('IndexCtrl',['$scope', '$http',function($scope, $http){
	$scope.$parent.checkLogin();
}]);