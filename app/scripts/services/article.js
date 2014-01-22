BlogServices.factory('articleForCommon', ['$resource', function($resource){
	return $resource('/article/:id', {id: '@id'});
}]);