BlogServices.factory('userResource', ['$resource', function($resource){
	return $resource('/user/:username', {userId: '@id'});
}]);