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
var blogApp = angular.module('ueBlogApp', ['ngRoute', 'ui.bootstrap','ngSanitize','ngAnimate' , 'ueBlogApp.controllers', 'ueBlogApp.services', 'ueBlogApp.directives' , 'ueBlogApp.filters', 'ngResource', 'ngCookies']);
blogApp.config(['$routeProvider', '$locationProvider',function ($routeProvider, $locationProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'views/home.html',
      controller: 'IndexCtrl'
    })
    .when('/register', {
      templateUrl: 'views/register.html',
      controller: 'RegisterCtrl'
    })
    .when('/post/:articleId', {
      templateUrl: 'views/post.html',
      controller: 'PostCtrl'
    })
    .when('/blog/:articleId', {
      templateUrl: 'views/article.html',
      controller: 'ArticleCtrl'
    })
    .when('/blog/page/:page', {
      templateUrl: 'views/home.html',
      controller: 'IndexCtrl'
    })
    .otherwise({
      redirectTo: '/'
    });
  $locationProvider.html5Mode(true);
  // highlight代码缩进配置
  hljs.tabReplace = '    '; 
}]);