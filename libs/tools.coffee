###
服务端通用工具方法
@date  2013.12.21
@author xuhua
###

# 判断邮箱格式
checkEmail = (str) ->
	emailReg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
	emailReg.test str

module.exports = 
	checkEmail: checkEmail