mongoose = require("mongoose")
Blog = require("./../models/BlogModel").Blog
BlogDao = require("./../dao/BlogDao")
log = require("./../libs/log")
msg = require("./../libs/msg")
tools = require("./../libs/tools")
fs = require('fs')
path = require('path')

# exports.create = (req, res) ->
# 	BlogDao.create(req.body, function(err, ))

# 新建博客
exports.create = (req, res) ->
	console.log(req.session["user"])
	return res.json err: msg.MAIN.noSession unless req.session["user"]
	req.body.author_id = req.session["user"]._id
	console.log(req.body)
	console.log(req.body.author_id)
	# 此处写Markdown文件，放在以用户id为名的文件夹中

	url = msg.ARTICLE.articleDict + '\\' + req.body.author_id;

	if not path.existsSync(url)
		fs.mkdir(url + "\\" + req.body.title + ".md")


	fs.writeFile(url, req.body.content, (err) ->
		return res.json msg.ARTICLE.writeFileError if err
	 )
	req.body.url = url;

	# fs.mkdirSync('./BlogFile/' + req.body.author_id + req.body.title + '.md', function(){

	# 	})

	newArticle = new Blog(req.body)

	newArticle.save (err, curArticle) ->
		return res.json err: err if err
		res.json curArticle