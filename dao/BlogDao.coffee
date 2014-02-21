BlogModel = require("./../models/BlogModel").Blog
fs = require("fs")
msg = require("./../libs/msg")
marked = require("marked")
config = require("./../config")
tools = require("./../libs/tools")
nodemailer = require("nodemailer")

BlogDao =
	model: BlogModel

	# 保存博客，新建和编辑
	saveBlog: (user, blog, callback) ->
		blog.author_id = user._id
		smtpTransport = nodemailer.createTransport "SMTP",
		    service: "Gmail",
		    auth: config.admin_email

		# 此处写Markdown文件，放在以用户id为名的文件夹中
		# For Windows
		myFolderUrl = config.site.MARKDOWN_DICT + '\\' + blog.author_id;
		myFileUrl = myFolderUrl + "\\" + blog.title + ".md"

		# For Mac
		# myFolderUrl = config.site.MARKDOWN_DICT + '\/' + blog.author_id;
		# myFileUrl = myFolderUrl + "\/" + blog.title + ".md"
		# 创建存放所有博客的根目录，部署后可去除
		tools.mkdirArticleSync()

		# 如果该用户是第一次写博客，为他创建文件夹
		if not fs.existsSync(myFolderUrl)
			fs.mkdirSync myFolderUrl

		# 将博客内容写入文件
		fs.writeFile myFileUrl, blog.articleContent, (err) ->
			return callback msg.ARTICLE.writeFileError,null if err
			blog.url = myFileUrl
			newArticle = new BlogModel(blog)

			# 更新
			if blog._id
				query = _id: newArticle._id
				updateArticle = 
					title: newArticle.title
					tags: newArticle.tags
					update_at: new Date()
				Blog.update query, updateArticle, (err, numAffected) ->
					return callback msg.MAIN.error,null if err
					callback null, numAffected
			# 新建
			else
				newArticle.save (err, curArticle) ->
					return callback err,null if err
					mailOptions = 
					    from: "UEBlog"
					    to: "414581694@qq.com"
					    subject: "新博客通知"
					    # text:  + ""
					    html: "<p>Dear UEDer</p><p style='text-indent:20px;'>#{user.username}在前端开发组博客发表新文章啦！请进入<a href='http://192.168.19.65:5000/blog/#{curArticle._id}'>前端开发组博客</a>查看。</p>"

					smtpTransport.sendMail mailOptions, (error, response) ->
					    if error
					        console.log("error" + error)
					    else
					        console.log("Message sent: " + response.message)

					smtpTransport.close();
					callback null, curArticle

	# 分页获取所有博客列表
	# 参数：页码，回调函数
	getAll: (page, callback) ->
		start = tools.calcStart(page)
		# 查询语句步骤分别是：查询所有博客，跳过前页的条目，限制一页数，查询博客作者
		@model.find().skip(start).limit(config.site.PAGE_COUNT).sort('-update_at').populate('author_id').exec (err, arts)->
			return callback err, null if err
			i = 0
			# 此处将Bson转换成Json一是避免中文乱码，二是对Json对象的操作可以顺利传到客户端
			# 然后读取文件中的文章内容
			artsObj = JSON.parse(JSON.stringify(arts))
			for art in artsObj
				artsObj[i].articleContent = marked(fs.readFileSync art.url,{encoding:'utf-8'})
				callback null, artsObj if ++i == arts.length
	
	# 获取一条博客记录
	getOneById: (id, decode, callback) ->
		BlogModel.findById(id).populate('author_id').exec (err, article) ->
			artObj = JSON.parse(JSON.stringify(article))
			fs.readFile artObj.url,{encoding:'utf-8'}, (err, data) ->
					artObj.articleContent = if decode then data else marked(data)
					callback null, artObj

	# 删除一条博客记录
	deleteOneById: (id, callback) ->
		BlogModel.findById id, (err, blog) ->
			return callback msg.ARTICLE.notExist if err
			blog.remove (err)->
				return callback msg.MAIN.error if err
				fs.unlink blog.url, (err) ->
					callback true
	# 标星
	starOne: (id, content, callback) ->
		BlogModel.findById id, (err, blog) ->
			return callback msg.ARTICLE.notExist if err
			

module.exports = BlogDao;