mongoose = require("mongoose")
Blog = require("./../models/BlogModel").Blog
BlogDao = require("./../dao/BlogDao")
log = require("./../libs/log")
msg = require("./../libs/msg")
tools = require("./../libs/tools")
fs = require('fs')
path = require('path')
marked = require('marked')

# 新建博客
exports.create = (req, res) ->
	return res.json err: msg.MAIN.noSession unless req.session["user"]
	req.body.author_id = req.session["user"]._id
	# 此处写Markdown文件，放在以用户id为名的文件夹中

	myFolderUrl = msg.ARTICLE.articleDict + '\\' + req.body.author_id;
	myFileUrl = myFolderUrl + "\\" + req.body.title + ".md"
	# 创建存放所有博客的根目录，部署后可去除
	tools.mkdirArticleSync()

	# 如果该用户是第一次写博客，为他创建文件夹
	if not fs.existsSync(myFolderUrl)
		fs.mkdirSync myFolderUrl

	# 将博客内容写入文件
	fs.writeFile myFileUrl, req.body.content, (err) ->
		return res.json err: msg.ARTICLE.writeFileError if err
		req.body.url = myFileUrl
		newArticle = new Blog(req.body)
		# 存数据库
		newArticle.save (err, curArticle) ->
			return res.json err: err if err
			res.json article: curArticle

# 获取所有Blogs
exports.getAll =  (req, res) ->
	pageNum = req.body.pageNum
	BlogDao.getAll pageNum, (err, blogs) ->
		res.json articles: blogs
