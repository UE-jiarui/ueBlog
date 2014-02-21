// Resiyrce for single blog.
BlogServices.factory('articleForCommon', ['$resource', function($resource){
	return $resource('/article/:id/:action', {id: '@id'},
		{
			'star' : { method: 'POST', params: {action: 'search', id: '@id'} },
			'comment':{ method: 'POST', params: {action: 'comment', id: '@id'} }
		});
}]);