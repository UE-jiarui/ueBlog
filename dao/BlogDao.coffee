CommonDao = require("./CommonDao")
BlogModel = require("./../models/BlogModel").Blog

BlogDao = new CommonDao(BlogModel);

module.exports = BlogDao;