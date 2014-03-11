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

	BlogDao.saveBlog req.session["user"], req.body, (err, result) ->
		return res.json err: err if err
		res.json article: result

# 获取所有Blogs
exports.getAll =  (req, res) ->
	pageNum = req.query.pageNum
	BlogDao.getAll pageNum, (err, blogs) ->
		Blog.count {},(err, number) ->
			res.json 
				articles: blogs
				pageCount: parseInt(number)

# 获取一条博客记录
exports.getOneById = (req, res) ->
	BlogDao.getOneById req.params.id, req.query.decode or false, (err, blog) ->
		return res.json error: err if err
		res.json article: blog

# 删除一条博客记录
exports.deleteOneById = (req, res) ->
	blogId = req.params.id
	# 判断操作者是否是博客作者
	Blog.findById(blogId).populate('author_id').exec (err, article) ->
		return res.json error: msg.MAIN.noneRight unless article.author_id._id.toString() == req.session['user']._id.toString() || req.session['user'].level <2
		BlogDao.deleteOneById blogId, (flag) ->
			res.json flag: flag

# 博客访问记录
exports.visit = (req, res) ->
	option = $inc:
			visit_count: 1
	option.last_visit = req.session["user"]._id if req.session["user"]
	BlogDao.visit req.params.id, option, (err, result) ->
		return req.json error: err if err
		res.json success: true

# 博客点星
exports.star = (req, res) ->
	Blog.findByIdAndUpdate req.params.id, 
		$push: 
			stared: req.session["user"]._id
	,(err, number) ->
		return res.json error: err if err
		res.json success: true