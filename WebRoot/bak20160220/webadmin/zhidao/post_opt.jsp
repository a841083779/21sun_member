<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%//=====页面属性====
String pagename="post_opt.jsp";
String mypy="zhidao_post";
String titlename="问题管理";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));
String zd_site_flag="8";


String urlpath="../zhidao/post_opt.jsp";
if(!myvalue.equals("0"))
urlpath=urlpath+"?myvalue="+myvalue;


try{//====标题的名称====
PoolManager pool3 = new PoolManager(10);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=titlename%></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

function submityn(){
	if($("#title").val()==""){
			alert("请输入标题！");
			$("#title").focus();
			return false;
	}theform.submit();
}
$(document).ready(function(){
	var s = $("#zd_topic").val();
	if(s=="1"){
		$("#topic").attr("checked","checked");
	}
})
</script>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="15"><span class="p982"><span class="pblue1">红色</span><font color="#FF0000">*</font><span class="pblue1">为必填项</span></span></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="post_save.jsp" method="post" name="theform" id="theform" >
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>标　　题：</strong></td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">所属类别：</td>
      <td height="22" class="list_cell_bg">
      <select name="zd_type">
      <%=Common.option_str(pool3,"zhidao_type","nodeid,name", "","", 1)%>
          </select>
      </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">悬赏金额：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_golds" name="zd_golds" size="20" maxlength="20"/></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布时间：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_add_date" name="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" size="20" maxlength="20"  readonly="true" /></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布内容：</td>
      <td height="22" class="list_cell_bg"> <FCK:editor instanceName="zd_context" toolbarSet="simple" width="93%" height="180">
          <jsp:attribute name="value"></jsp:attribute>
        </FCK:editor>
        <font color="#FF0000">*</font></td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="add_ip" type="hidden" id="add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
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
	$('#getxinxi').attr("src","set_formxx.jsp?pool=10&mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
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
