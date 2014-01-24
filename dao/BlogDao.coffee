BlogModel = require("./../models/BlogModel").Blog
fs = require("fs")
msg = require("./../libs/msg")
marked = require("marked")
config = require("./../config")
tools = require("./../libs/tools")

BlogDao =
	model: BlogModel
	# 分页获取所有博客列表
	# 参数：页码，回调函数
	getAll: (page, callback) ->
		start = tools.calcStart(page)
		# 查询语句步骤分别是：查询所有博客，跳过前页的条目，限制一页数，查询博客作者
		@model.find().skip(start).limit(config.site.PAGE_COUNT).sort('-create_at').populate('author_id').exec (err, arts)->
			return callback err, null if err
			i = 0
			# 此处将Bson转换成Json一是避免中文乱码，二是对Json对象的操作可以顺利传到客户端
			# 然后读取文件中的文章内容
			artsObj = JSON.parse(JSON.stringify(arts))
			for art in artsObj
				fs.readFile art.url,{encoding:'utf-8'}, (err, data) ->
					artsObj[i].articleContent = marked(data)
					callback null, artsObj if ++i == arts.length
	
	# 获取一条博客记录
	getOneById: (id, callback) ->
		BlogModel.findById(id).populate('author_id').exec (err, article) ->
			artObj = JSON.parse(JSON.stringify(article))
			fs.readFile artObj.url,{encoding:'utf-8'}, (err, data) ->
					artObj.articleContent = marked(data)
					callback null, artObj

	# 删除一条博客记录
	deleteOneById: (id, callback) ->
		BlogModel.findById id, (err, blog) ->
			return callback msg.MAIN.error if err
			blog.remove (err)->
				return callback msg.MAIN.error if err
				fs.unlink blog.url, (err) ->
					callback true

module.exports = BlogDao;