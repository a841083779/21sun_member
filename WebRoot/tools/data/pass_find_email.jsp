<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%>
<%
	PoolManager pool = (PoolManager)application.getAttribute("poolApp");
	if(pool == null){
		pool = new PoolManager();
		application.setAttribute("poolApp",pool);
	}
	Connection conn = null;
	String uuid = Common.getFormatStr(request.getParameter("code"));
	String email = Common.getFormatStr(request.getParameter("email"));
	String mem_no = Common.getFormatStr(request.getParameter("no"));
	String memNo = "";
	String memPass = "";
	try{
		conn = pool.getConnection();
		if(email!=null && !email.equals("")){
			//查询出membr_info_ago表中是否存在该帐号
			String sql = " SELECT mem_no,passw from member_info WHERE per_email='"+email+"' and mem_no='"+mem_no+"' and state='1' ";
			ResultSet rs = DataManager.executeQuery(conn, sql);
			if(rs != null && rs.next()){
				memNo = rs.getString("mem_no");
				memPass = rs.getString("passw");
			}
		}
	}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<link rel="stylesheet" type="text/css" href="http://member.21-sun.com/tools/data/style/style.css" />
<title>邮件</title>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">

<div align="left">
	<table border="0" cellpadding="0" cellspacing="0" width="593"  style="font-size:14px; line-height:22px;">
		<tr>
			<td><img border="0" src="http://member.21-sun.com/tools/data/images/top.jpg" width="593" height="93"></td>
		</tr>
		<tr>
			<td style="border-left:1px solid #EBEBEB; border-right:1px solid #EBEBEB; padding-left:20px; padding-right:20px; padding-top:10px; padding-bottom:10px" bgcolor="#F4F4F4">
			<b>尊敬的用户，您好：</b><br />欢迎您使用<b>中国工程机械商贸网</b>（<a href='http://www.21-sun.com' target='_blank'>www.21-sun.com</a>）的找回密码功能！<br /><br />请点击下方的链接重设您的密码：<br />
            <a target="_blank" href="http://member.21-sun.com/reset/?email=<%=email%>&key=<%=mem_no%>&code=<%=uuid%>">http://member.21-sun.com/reset/?email=<%=email%>&key=<%=mem_no%>&code=<%=uuid%></a><br />
            为了确保您的帐号安全，该链接仅 3天内 访问有效。<br />
            如果该链接已经失效，请您点击 <a href="http://member.21-sun.com/member_pass_find.jsp" target="_blank">这里</a> 重新获取修复密码邮件。<br />
			<a href=""></a> <br />
			</td>
		</tr>
		<tr>
			<td valign="top"><img border="0" src="http://member.21-sun.com/tools/data/images/down.jpg" width="593" height="13"></td>
		</tr>
		<tr>
			<td style="padding-top: 15px" style="font-size:12px; line-height:18px; text-align:right;">
            中国工程机械商贸网 联系电话：0535-6792736</td>
		</tr>
	</table>
</div>
</body>
</html>
