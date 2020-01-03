<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%>
<%
	String mem_no = Common.getFormatStr(request.getParameter("no"));
	String passw = Common.getFormatStr(request.getParameter("pa"));
	String email = Common.getFormatStr(request.getParameter("em"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册会员验证--中国工程机械商贸网</title>
</head>
<body>
<style type="text/css">
html{word-wrap:break-word;}
body{ font-size:14px; font-family:arial,verdana,sans-serif; line-height:180%; padding:10px 8px; margin:0; overflow:auto; color:#393939; text-align:center;}
</style>
<base target="_blank" />
<table width="742" border="0" cellspacing="0" cellpadding="0" align="center" style="margin:0px auto;">
  <tr>
    <td width="190" style="line-height:0px; font-size:0px;"><img src="http://member.21-sun.com/images/mail01_img01.gif" width="190" height="88" /></td>
    <td width="552" style="line-height:0px; font-size:0px;"><img src="http://member.21-sun.com/images/mail01_img02.gif" width="552" height="88" /></td>
  </tr>
  <tr>
    <td colspan="2" style="border-left:#d5d5d5 1px solid; border-right:#d5d5d5 1px solid; vertical-align:top; text-align:left; font-size:14px; padding:30px; line-height:180%;"><p style="margin:0px;"><span style="font-weight:bold;">尊敬的商贸网会员：</span><br />
        您好！感谢您加入中国工程机械商贸网！您的登录名为： <%=mem_no %> 密码：<%=passw %><br />
      </p>
      <p style="margin:0px;">您填写的邮箱：<%=email%> ，请点击以下“点击验证”按钮，完成邮箱验证。请确认此邮箱是您本人使用，以保证商机能随时找到您！<br />
        <br />
      </p>
      <div style="text-align:center;"><a href="http://member.21-sun.com/tools/data/active.jsp?id=<%=Common.encryptionByDES(mem_no) %>&code=<%=Common.encryptionByDES(passw) %>" title="点击验证" target="_blank"><img src="http://member.21-sun.com/images/mail01_img03.gif" alt="点击验证" width="195" height="56" border="0" /></a></div>
      <br />
      <p style="margin:0px;">看不到或无法点击以上按钮？<br />
        <span style="font-size:12px;">如果点击链接无效，请您选择并复制下面的链接，打开浏览器窗口并将其粘贴到地址栏中，然后单击&quot;转到&quot;按钮或按键盘上的Enter键。同样能完成验证！点击以下激活链接，以激活您的账号：</span><br />
        <a href="http://member.21-sun.com/tools/data/active.jsp?id=<%=Common.encryptionByDES(mem_no) %>&code=<%=Common.encryptionByDES(passw) %>" style="font-size:12px; text-decoration:underline; color:#0765c5;" target="_blank">http://member.21-sun.com/tools/data/active.jsp?id=<%=Common.encryptionByDES(mem_no) %>&code=<%=Common.encryptionByDES(passw) %></a><br />
        <span style="font-size:12px; color:#999999;">(如果不能点击该链接地址，请复制并粘贴到浏览器的地址输入框)</span><br />
        <br />
      </p>
      <p style="font-size:12px; margin:0px;">如果有任何疑问，欢迎给联系客服，我们将尽快给您回复！<br />
        您在使用过程中，如有任何问题或建议，请随时联系商贸网客户服务人员，我们将热诚为您服务！顺颂商祺！</p></td>
  </tr>
  <tr>
    <td colspan="2" style="line-height:0px; font-size:0px;"><img src="http://member.21-sun.com/images/mail01_img04.gif" width="742" height="9" /></td>
  </tr>
</table>
</body>
</html>
