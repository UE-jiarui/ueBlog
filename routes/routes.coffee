require 'coffee-script'
path = require 'path'
user = require './user'
blog = require './blog'

module.exports = (app) ->
  app.post '/user/regist', user.create
  app.post '/user/login', user.login
  app.get '/user/logout', user.logout
  app.get '/user/getLoginUser', user.getLoginUser
  app.post '/article/save', blog.create
  app.post '/article/getAllArticle', blog.getAll
  app.get '/article/:id', blog.getOneById
  # 为了使浏览器的上一步、下一步可用，并隐藏丑陋的地址栏上的 “#”
  # 共设置两处：
  # 	1.服务端路由中，添加下面路由代码；
  # 	2.在Angular 路由配置中添加 $locationProvider.html5Mode(true);以启用html5模式
  # 	
  # 注：存在浏览器兼容性问题
  # 	
  app.all '/*', (req, res) ->
  	res.sendfile('index.html', { root: __dirname+'/../app' })
