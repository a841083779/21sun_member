<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/manage/config.jsp"%>
<%//=====页面属性====
String pagename="rent_message_opt.jsp";
String mypy="rent_message";
String titlename="租赁留言管理";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));


String urlpath="../rent/rent_message_opt.jsp";
if(!myvalue.equals("0"))
urlpath=urlpath+"?myvalue="+myvalue;

try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=titlename%></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

function submityn(){
	if($("#zd_title").val()==""){
			alert("请输入标题！");
			$("#zd_title").focus();
			return false;
	}theform.submit();
}
</script>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="15"><span class="p982"><span class="pblue1">红色</span><font color="#FF0000">*</font><span class="pblue1">为必填项</span></span></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform" >
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>标　　题：</strong></td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">留言方：</td>
      <td class="list_cell_bg"><input name="zd_fullname" type="text" id="zd_fullname" size="30" maxlength="30">
      <input name="zd_proid" type="hidden" id="zd_proid"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">接收会员：</td>
      <td class="list_cell_bg"><input name="zd_receiver" type="text" id="zd_receiver" size="30" maxlength="30"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">电话：</td>
      <td class="list_cell_bg"><input name="zd_telephone" type="text" id="zd_telephone" size="30" maxlength="30"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">EMAIL：</td>
      <td class="list_cell_bg"><input name="zd_email" type="text" id="zd_email" size="30" maxlength="30"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">留言时间：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_pubdate" name="zd_pubdate" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" size="20" maxlength="20"  readonly="true" /></td>
      </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布状态：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="0">
        否 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">具体租赁：</td>
      <td height="22" class="list_cell_bg"><input name="zd_aboutinfo" type="text" id="zd_aboutinfo" size="30" maxlength="30">
      <input name="zd_isread" type="hidden" id="zd_isread">
      <input name="zd_reply" type="hidden" id="zd_reply"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">内　　容：</td>
      <td height="22" class="list_cell_bg"> <FCK:editor instanceName="zd_content" toolbarSet="simple" width="93%" height="380">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor>
        <font color="#FF0000">*</font></td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_user" type="hidden" id="zd_add_user" value="">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
          <input name="zd_catalog_no" type="hidden" id="zd_catalog_no" value="700703">
      </div></td>
    </tr>
  </form>
</table>
<table width="98%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="10"></td>
  </tr>
</table>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
	}
}
<%
if(!myvalue.equals("0")){
	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>
