<%@page	contentType="text/html;charset=utf-8" %><!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.STYLE1 {font-size: 12px}
-->
</style></head>

<body>
<%
out.println("User-Agent : " + request.getHeader("User-Agent") + "<br>");
out.println("HTTP_ACCEPT : " + request.getHeader("HTTP_ACCEPT") + "<br>");



%>
<%  
String type = request.getHeader("User-Agent");  
String ip = request.getHeader("X-Forward-For");  
String pcIP = Common.getRemoteAddr(request,1);  
String number1 = request.getHeader("X-Up-Calling-Line-Id");  
String number2 = request.getHeader("x-up-calling-line-id");  

out.println("\n");  
out.println("型号：" + type);  
out.println("---------------------");  
out.println("IP：" + ip);  
out.println("---------------------");  
out.println("PC IP：" + pcIP);  
out.println("---------------------");  
out.println("号1：" + number1);  
out.println("---------------------");  
out.println("号2：" + number2);  
out.println("---------------------");          
     %> 
<table width="100%" height="480" border="0" cellpadding="0" cellspacing="0" bgcolor="#FF0000">
  <tr>
    <td>山西嘉盛招标代理有限公司（代理机构）受阳泉煤业（集团）有限责任公司五矿（招标人）委托，对五矿2#主斜井井口房起重机设备采购，组织国内公开招标。现将有关事项公告如下： <br />    <br />	</td>
  </tr>
</table>
</body>
</html>
