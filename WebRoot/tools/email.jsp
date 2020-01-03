<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>中国工程机械商贸网</title>
</head>
<style type="text/css">
BODY {font-family: Arial;font-size:9pt;} 
td {font-family: Arial;font-size:9pt;line-height:22px;color: #464646;} 

a            { text-decoration: none }
a:link       { color: #464646}
a:visited    { color: #464646}
a:hover      { color: #E78000; text-decoration: none }

-->
</style>
<body >
<!--background="http://member.21-sun.com/tools/huiyuan.jpg" style="background-repeat:no-repeat;"-->
<table border="0" cellpadding="0" cellspacing="0" width="970"  height="595">
	<tr>
		<td valign="top" style="padding-left: 10px">
		<table border="0" cellpadding="0" cellspacing="0" width="65%" style="margin-top:10px; color: #3D3D3D; font-size: 12px; line-height: 24px ;">
			<tr>
				<td style="font-size: 16px; line-height: 24px;font-family:Microsoft YaHei">
				<b><%=request.getParameter("fullname")%>，您好！</b></td>
			</tr>
			<tr>
				<td style="font-size: 14px; line-height: 24px;font-family:Microsoft YaHei"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				恭喜您成为中国工程机械商贸网（<a target="_blank" href="http://www.21-sun.com">www.21-sun.com</a>）的会员
				。<br>
				<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 您的<b>帐号：<%=request.getParameter("uid")%></b>，<b>密码：<%=request.getParameter("password")%></b>，请妥善保管您的帐号密码。 <br>
				<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 您在使用中遇到任何问题，都可随时致电：0535-6727765， 
				或者发邮件到<a href="mailto:market@21-sun.com">market@21-sun.com</a> ， 我们将在24小时内处理您的疑问。</td>
			</tr>
			<tr>
				<td align="right" style="font-family: Arial;font-size:9pt;line-height:22px;color: #464646;"><b>中国工程机械商贸网<br>
				<a target="_blank" href="http://www.21-sun.com/">
				<span style="text-decoration: none">http://www.21-sun.com</span></a></b><a target="_blank" href="http://www.21-sun.com/"><span style="text-decoration: none">
				</span>
				</a> </td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</body>

</html>
