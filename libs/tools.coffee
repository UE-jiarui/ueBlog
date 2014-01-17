###
服务端通用工具方法
@date  2013.12.21
@author xuhua
###
fs = require('fs')
path = require('path')
msg = require('./msg')

# 判断邮箱格式
checkEmail = (str) ->
	emailReg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
	emailReg.test str

# 创建文件夹
mkdirArticleSync = (url, callback) ->
	articleDict = msg.ARTICLE.articleDict
	if not fs.existsSync(articleDict)
		fs.mkdir(articleDict, 777, (err)->
			console.log('出错了') if err
			)

module.exports = 
	checkEmail: checkEmail
	mkdirArticleSync: mkdirArticleSync