/**
 * 全局配置文件
 * @date 2013.12.21
 * @author xuhua
 */
module.exports = {
	// 网站配置信息
	site : {
		SITE_IP: "192.168.4.125",
		SITE_NAME: "",
		SITE_URL: "",
		PAGE_COUNT: 5,
		MARKDOWN_DICT: "./../BlogArticle"
	},
	db : {
		COOKIE_SECRET: "ueblog",
		CONNECT_STRING: "mongodb://localhost/ueBlog"
	},
	words: {
		XUHUA: ""
	},
	contributors : "xuhua, lycheng, ",
	admin_email: {
		user: "iflytek.ueteam@gmail.com",
		pass: "iflytekUE_Team"
	},
	receivers: ["yunshi","jingdai","huihan2","zfli2","wbye","xypan2","yongwang","beiwan","xuhua","lycheng","ruijia","wqli","kpyu","huanzhang"]
}