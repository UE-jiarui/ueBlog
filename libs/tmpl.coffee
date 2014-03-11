###
服务端用到的HTML模板
@date  2014.3.11
@author xuhua
###
moment = require 'moment'

mail = (article, user) ->
	moment.lang 'zh-cn'
	now = moment().format('YYYY 年 M 月 D 日， A h:m zz')
	return '<div class="mailwrapper" style="font-size: 14px; color: #333; font-smooth: always; -webkit-font-smoothing: antialiased; ">
	<table class="mainTable" align="center" style="font-size: inherit; line-height: inherit; text-align: center; border-spacing: 0; border-collapse: collapse; -premailer-cellpadding: 0; -premailer-cellspacing: 0; padding: 0; border: 0;" cellpadding="0" cellspacing="0">
		<tbody><tr><td class="topPadding" style="font-family: \"Lucida Grande\", Helvetica, Arial, sans-serif; height: 16px; -premailer-height: 16;" height="16"></td></tr>
		<tr>
			<td class="centerColumn" style="width: 685px; -premailer-width: 685;" width="685">
				<table class="iPhone_font" style="font-family: \"Lucida Grande\", Helvetica, Arial, sans-serif; font-size: inherit; line-height: 18px; padding: 0px; border: 0px;">
					<tbody>
					<tr>
						<td class="content_margin" style="width: 40px;"></td>
						<td class="content_margin" style="width: 40px;"></td>
					</tr>
          <tr>
          	<td class="content_margin" style="width: 40px;"></td>
          	<td class="iPhone_font" style="font-family: \"Lucida Grande\", Helvetica, Arial, sans-serif; line-height: 18px; padding-top: 44px;font-size: 14px; color: #333; font-smooth: always; -webkit-font-smoothing: antialiased;">您好：<br/></td>
          	<td class="content_margin" style="width: 40px;"></td>
          </tr>
          <tr>
          	<td class="content_margin" style="width: 40px;"></td>
          	<td class="iPhone_font" style="font-family: \"Lucida Grande\", Helvetica, Arial, sans-serif; line-height: 18px;text-align: left;font-size: 14px; color: #333; padding: 17px 0 0 0; font-smooth: always; -webkit-font-smoothing: antialiased;">
          		<br/>前端开发组有同事贡献新的博客，您可以<a href="http://192.168.19.65:5000/blog/' + article._id + '" style="color: #08c; text-decoration: none;" target="_blank"><nobr>点击查看</nobr></a>。
          	</td>
          	<td class="content_margin" style="width: 40px;"></td>
          </tr>
          <tr>
            <td class="content_margin" style="width: 40px;"></td>
            <td class="iPhone_font" style="font-family: \"Lucida Grande\", Helvetica, Arial, sans-serif; line-height: 26px;text-align: left;font-size: 14px; color: #333; padding: 18px 0 0 0; font-smooth: always; -webkit-font-smoothing: antialiased;"><div><span>
						<br />文章标题：</span><span><a href="http://192.168.19.65:5000/blog/' + article._id + '" style="color: #08c; text-decoration: none;" target="_blank"><nobr> ' + article.title + '</nobr></a></span><br /><span>
						作&nbsp;&nbsp;者：
	            </span><span>' + user.username + '</span><br /><span>
	                发表时间：
	                </span><span>' + now + '
	            </span></div>
	            <div>
	            
	            </div>
	          </td>
            <td class="content_margin" style="width: 40px;"></td>
           	</tr>
	          <tr>
	            <td class="content_margin" style="width: 40px;"></td>
	            <td class="iPhone_font" style="font-family: \"Lucida Grande\", Helvetica, Arial, sans-serif; line-height: 18px; font-smooth: always; -webkit-font-smoothing: antialiased;                                  text-align: left;
	               font-size: 14px; color: #333; padding: 18px 0 0 0;">
	               <br/>
	                如果您不想收到新博客邮件通知，您可以联系<a href="mailto:iflytek.ueteam@gmail.com" style="color: #08c; text-decoration: none;" target="_blank"><nobr>UED&nbsp;团队</nobr></a>取消通知。
	                </td>
	            <td class="content_margin" style="width: 40px;"></td>
	          </tr>
                <tr>
                  <td class="content_margin" style="width: 40px;"></td>
                  <td class="iPhone_font" style="text-align: left;font-family: \"Lucida Grande\", Helvetica, Arial, sans-serif; line-height: 18px; font-smooth: always; -webkit-font-smoothing: antialiased; color: #333; padding: 3px 0 19px 0; font-size: 14px;">
                    <br/>
                    此致
                      </td>
                  <td class="content_margin" style="width: 40px;"></td>
                  </tr>
                <tr>
                <td class="content_margin" style="width: 40px;"></td>
                  <td class="iPhone_font" style="text-align: left;font-family: \"Lucida Grande\", Helvetica, Arial, sans-serif; line-height: 18px; font-size: 14px; font-smooth: always; -webkit-font-smoothing: antialiased; color: #333; padding: 17px 0 13px 0;">
                      <br/>
                      UED 团队
                      </td>
                  <td class="content_margin" style="width: 40px;"></td>
                  </tr>
                  </tbody></table>
                </td>
              </tr>
              <tr class="footerBottomPadding iPhone_font" style="height: 50px; -premailer-height: 50;" height="50"><td style="font-family: \"Geneva\", Helvetica, Arial, sans-serif;">
		      </td>
		    </tr>
		  </tbody></table>
		</div>'
			          # <tr>
						# <td class="heading_logo" style="text-align: right;width: 600px;"><img width="22" height="26" src="http://imageshack.com/a/img691/6131/t0ps.png" style="width: 22px; height: 26px;"></td>
	          # 	<td class="content_margin" style="width: 40px;"></td>
	          # 	<td class="letter_content iPhone_font" style="font-family: \"Lucida Grande\", Helvetica, Arial, sans-serif; line-height: 18px; font-smooth: always; -webkit-font-smoothing: antialiased;text-align: left;font-size: 14px; color: #333; padding: 18px 0 15px 0;">
	          # 		<br />As learning new programming languages makes us better developers so does learning new frameworks. Learning a new framework helps us learn, and reinforce our knowledge of design patterns.</td>
           #    <td class="content_margin" style="width: 40px;"></td>
           #    </tr>

module.exports =
	mail: mail