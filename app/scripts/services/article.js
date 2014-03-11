// Resource for single blog.
BlogServices.factory('articleForCommon', ['$resource', function($resource){
	return $resource('/article/:id/:action', {id: '@id'},
		{
			visit: {method: 'POST', params: {action: 'visit', id: '@id'} },
			star: { method: 'POST', params: {action: 'star', id: '@id'} },
			comment:{ method: 'POST', params: {action: 'comment', id: '@id'} }
		});
}])
// 判断当前用户是否已执行某操作
// 如是否已为文章点星
.factory('isOperated', [function(){
	return function(arr, item){
		for (var i = arr.length - 1; i >= 0; i--) {
			if(arr[i]._id === item._id){
				return true;
			}
		};
		return false;
	}
}])
.factory('starArticle', ["articleForCommon", "$rootScope", function(articleForCommon, $rootScope){
	return function(article){
		if(!$rootScope.loginUser){
			return;
		}
		if(article.isStared){
			alert("你已经表达过对这篇文章的喜爱。");
			return;
		}
		articleForCommon.star({ id: article._id },function(){
			article.isStared = true;
			article.stared.push($rootScope.loginUser);
		});
	}
}]);