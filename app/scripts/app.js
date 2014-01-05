'use strict';

/**
 * 路由跳转
 * @date 2013.12.21
 * @author xuhua
 */

//定义分模块
var BlogContrllers = angular.module('ueBlogApp.controllers', []);
var BlogServices = angular.module('ueBlogApp.services', []);
var BlogDirectives = angular.module('ueBlogApp.directives', []);
var BlogFilters = angular.module('ueBlogApp.filters', []);

//@xuhua:尽量不要直接在Module中引入依赖，在分模块中分别引入子依赖
var blogApp = angular.module('ueBlogApp', ['ueBlogApp.controllers', 'ueBlogApp.services', 'ueBlogApp.directives' , 'ueBlogApp.filters'])
blogApp.config(['$routeProvider', '$locationProvider',function ($routeProvider, $locationProvider) {
  $locationProvider.html5Mode(true);
  $routeProvider
    .when('/', {
      templateUrl: 'views/home.html',
      controller: 'IndexCtrl'
    })
    .when('/login', {
      templateUrl: 'views/login.html',
      controller: 'LoginCtrl'
    })
    .when('/register', {
      templateUrl: 'views/register.html',
      controller: 'RegisterCtrl'
    })
    .when('/post', {
      templateUrl: 'views/post.html',
      controller: 'PostCtrl'
    })
    .otherwise({
      redirectTo: '/'
    });
}]);