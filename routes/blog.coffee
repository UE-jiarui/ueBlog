mongoose = require("mongoose")
Blog = require("./../models/BlogModel").Blog
BlogDao = require("./../dao/BlogDao")
log = require("./../libs/log")
msg = require("./../libs/msg")
tools = require("./../libs/tools")
config = require("./../config")
fs = require('fs')
path = require('path')
marked = require('marked')

# 新建、编辑博客
exports.create = (req, res) ->
	return res.json err: msg.MAIN.noSession unless req.session["user"]
	req.body.author_id = req.session["user"]._id
	# 此处写Markdown文件，放在以用户id为名的文件夹中

	# For Windows
	myFolderUrl = config.site.MARKDOWN_DICT + '\\' + req.body.author_id;
	myFileUrl = myFolderUrl + "\\" + req.body.title + ".md"

	# For Mac
	# myFolderUrl = config.site.MARKDOWN_DICT + '\/' + req.body.author_id;
	# myFileUrl = myFolderUrl + "\/" + req.body.title + ".md"
	# 创建存放所有博客的根目录，部署后可去除
	tools.mkdirArticleSync()

	# 如果该用户是第一次写博客，为他创建文件夹
	if not fs.existsSync(myFolderUrl)
		fs.mkdirSync myFolderUrl

	# 将博客内容写入文件
	fs.writeFile myFileUrl, req.body.articleContent, (err) ->
		return res.json err: msg.ARTICLE.writeFileError if err
		req.body.url = myFileUrl
		newArticle = new Blog(req.body)

		# 更新
		if req.body._id
			query = _id: newArticle._id
			updateArticle = 
				title: newArticle.title
				tags: newArticle.tags
				update_at: new Date()
			Blog.update query, updateArticle, (err, numAffected) ->
				return res.json err: msg.MAIN.error if err
				res.json article: numAffected
		# 新建
		else
			newArticle.save (err, curArticle) ->
				return res.json err: err if err
				res.json article: curArticle

# 获取所有Blogs
exports.getAll =  (req, res) ->
	pageNum = req.body.pageNum
	BlogDao.getAll pageNum, (err, blogs) ->
		Blog.count {},(err, number) ->
			res.json 
				articles: blogs
				pageCount: parseInt(number)

# 获取一条博客记录
exports.getOneById = (req, res) ->
	BlogDao.getOneById req.params.id, req.query.decode or false, (err, blog) ->
		res.json article: blog

# 删除一条博客记录
exports.deleteOneById = (req, res) ->
	blogId = req.params.id
	# 判断操作者是否是博客作者
	Blog.findById(blogId).populate('author_id').exec (err, article) ->
		return res.json error: msg.MAIN.noneRight unless article.author_id._id.toString() == req.session['user']._id.toString()
		BlogDao.deleteOneById blogId, (flag) ->
			res.json flag: flag