<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�й����̻�е��ó��</title>
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
				<b><%=request.getParameter("fullname")%>�����ã�</b></td>
			</tr>
			<tr>
				<td style="font-size: 14px; line-height: 24px;font-family:Microsoft YaHei"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				��ϲ����Ϊ�й����̻�е��ó����<a target="_blank" href="http://www.21-sun.com">www.21-sun.com</a>���Ļ�Ա
				��<br>
				<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ����<b>�ʺţ�<%=request.getParameter("uid")%></b>��<b>���룺<%=request.getParameter("password")%></b>�������Ʊ��������ʺ����롣 <br>
				<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ����ʹ���������κ����⣬������ʱ�µ磺0535-6727765�� 
				���߷��ʼ���<a href="mailto:market@21-sun.com">market@21-sun.com</a> �� ���ǽ���24Сʱ�ڴ����������ʡ�</td>
			</tr>
			<tr>
				<td align="right" style="font-family: Arial;font-size:9pt;line-height:22px;color: #464646;"><b>�й����̻�е��ó��<br>
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
