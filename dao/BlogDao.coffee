BlogModel = require("./../models/BlogModel").Blog
fs = require("fs")
marked = require("marked")
config = require("./../config")
tools = require("./../libs/tools")

BlogDao =
	model: BlogModel
	# 分页获取所有博客列表
	# 参数：页码，回调函数
	getAll: (page, callback) ->
		start = tools.calcStart(page)
		bufferHelper = new tools.BufferHelper()
		@model.find().skip(start).limit(config.site.PAGE_COUNT).exec (err, arts)->
			return callback err, null if err
			i = 0
			# 此处将Bson转换成Json一是避免中文乱码，二是对Json对象的操作可以顺利传到客户端
			artsObj = JSON.parse(JSON.stringify(arts))
			for art in artsObj
				fs.readFile art.url,{encoding:'utf-8'}, (err, data) ->
					artsObj[i].articleContent = marked(data)
					callback null, artsObj if ++i == arts.length

module.exports = BlogDao;