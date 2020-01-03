<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%>
<%
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");

if(pool==null){
	pool = new PoolManager();
}

String zd_content="",zd_sender_mem_name="",zd_email="",zd_sender_mem_no="",flagvalue="";
String sqlMemMessage ="";

int result=0;
try{
flagvalue = Common.getFormatStr(request.getParameter("flagvalue"));
if(flagvalue.equals("1")){
  	
	zd_content = Common.getFormatStr(request.getParameter("zd_content"));
	zd_sender_mem_name = Common.getFormatStr(request.getParameter("zd_sender_mem_name"));
	zd_sender_mem_no = Common.getFormatStr(request.getParameter("zd_sender_mem_no"));
	zd_email = Common.getFormatStr(request.getParameter("zd_email"));
	
	sqlMemMessage = "insert member_message (sender_mem_name,sender_mem_no,email,content,add_date) values('"+zd_sender_mem_name+"','"+zd_sender_mem_no+"','"+zd_email+"','"+zd_content+"',getdate())";
	
	result = DataManager.dataOperation(pool,sqlMemMessage);
	
	if(result>0){
	   out.print("<script>alert('提交成功,感谢您的宝贵意见!');window.location.href='yjfk.jsp';</script>");
	}else{
	   out.print("<script>window.location.href='yjfk.jsp';</script>"); 
	}
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="/manage/jquery-1.4.2.min.js"></script>
<title>我的商贸网 - 中国工程机械商贸网</title>
</head>
<script type="text/javascript">
  function submityn(){
     
	if($.trim(document.theform.zd_content.value)==""){
	   alert("请提出您宝贵的意见！");
	   document.theform.zd_content.focus();
	   return false;
	}else if(document.theform.zd_sender_mem_name.value==""){
	   alert("请填写您的姓名！");
	   document.theform.zd_sender_mem_name.focus();
	   return false;
	}else if(document.theform.zd_email.value.indexOf("@")==-1){
	   alert("请正确填入您的邮箱！");
	   document.theform.zd_email.focus();
	   return false;
	}else{
		document.theform.flagvalue.value="1";
		document.theform.submit();
	}
  }  
</script>
<body>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<form name="theform" method="post" id="theform">
<table style="width: 100%;" cellspacing="0" cellpadding="0">
	<tr>
	  <td colspan="2" style="font-size:12px;line-height:18px;padding-left:10px;padding-top:6px;">欢迎您对我们提出宝贵建议和意见！</td>
	</tr>
	<tr>
		<td colspan="2"><textarea name="zd_content" cols="20" rows="2" style="overflow-y:scroll;width:200px;margin-left:8px;height:50px;margin-top:8px"></textarea>&nbsp;</td>
	</tr>
	<tr>
		<td style="height: 30px;font-size:12px;text-indent:10px;width:120px">您的姓名：</td>
		<td width="168" style="height: 20px"><input name="zd_sender_mem_name" type="type" id="zd_sender_mem_name" value="<%=Common.getFormatStr(memberInfo.get("mem_name"))%>" /></td>
	</tr>
	<tr>
		<td style="height: 20px;font-size:12px;text-indent:10px">E-mail:</td>
		<td><input name="zd_email" type="text" id="zd_email" value="<%=Common.getFormatStr(memberInfo.get("per_email"))%>" />&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" style="text-align:center;height:40px"><img src="../images/fankui.gif" onclick="submityn();" style="cursor:pointer"/></td>
	</tr>
</table>
<input type="hidden" name="flagvalue" value="1" />
<input type="hidden" name="zd_sender_mem_no" value="<%=Common.getFormatStr(memberInfo.get("mem_no"))%>" />
</form>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	//pool.freeConnection(conn);
}
%>