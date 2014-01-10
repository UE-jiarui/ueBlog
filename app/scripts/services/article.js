BlogServices.factory('articleResource', ['$resource', function($resource){
	return $resource('/article/:id', {id: '@id'});
}]);