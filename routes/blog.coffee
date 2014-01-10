mongoose = require("mongoose")
Blog = require("./../models/BlogModel").Blog
BlogDao = require("./../dao/BlogDao")
log = require("./../libs/log")
msg = require("./../libs/msg")
tools = require("./../libs/tools")

# exports.create = (req, res) ->
# 	BlogDao.create(req.body, function(err, ))

# 新建博客
exports.create = (req, res) ->
	console.log(req.session["user"])
	return res.json err: msg.MAIN.noSession unless req.session["user"]
	req.body.author_id = req.session["user"]._id
	console.log(req.body)
	console.log(req.body.author_id)
	newArticle = new Blog(req.body)

	console.log(newArticle)
	
	newArticle.save (err, curArticle) ->
		return res.json err: err if err
		res.json curArticle