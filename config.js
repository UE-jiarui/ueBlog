/**
 * 全局配置文件
 * @date 2013.12.21
 * @author xuhua
 */
module.exports = {
	// 网站配置信息
	site : {
		SITE_NAME: "",
		SITE_URL: "",
		PAGE_COUNT: 10,
		MARKDOWN_DICT: "./../BlogArticle"
	},
	db : {
		COOKIE_SECRET: "ueblog",
		CONNECT_STRING: "mongodb://localhost/ueBlog"
	},
	words: {
		XUHUA: ""
	},
	contributors : "xuhua, lycheng"
}