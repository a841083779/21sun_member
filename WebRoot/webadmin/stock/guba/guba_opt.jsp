<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/webadmin/manage/config.jsp"%>
<%
String catalog = Common.getFormatStr(request.getParameter("catalog"));
//=====页面属性====
String pagename="guba_opt.jsp";
String mypy="stock_guba";
String titlename="股评";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));
String urlpath="/webadmin/stock/blog/blog_opt.jsp";
if(!myvalue.equals("0"))
urlpath=urlpath+"?myvalue="+myvalue;

try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=titlename%></title>
<link href="/webadmin/style/style.css" rel="stylesheet" type="text/css" />
<script src="/webadmin/scripts/jquery-1.4.1.min.js"></script>
<script src="/webadmin/scripts/upload/swfupload.js"  type="text/javascript"></script>
<script src="/webadmin/scripts/upload/handlers.js"  type="text/javascript"></script>
<script src="/webadmin/scripts/upload/fileprogress.js"  type="text/javascript"></script>
<script src="/webadmin/scripts/common.js"  type="text/javascript"></script>
<script src="/webadmin/scripts/My97DatePicker/WdatePicker.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

function submityn(){
/*
	var catalog = document.getElementsByName("zd_catalog");
	var cc = 0;
	for(var i=0;i<catalog.length;i++){
		if(catalog[i].checked){
			cc ++;
		}
	}
	if(cc == 0){
		alert("请选择类别！");
		return false;
	}
*/
	if($("#zd_title").val()==""){
			alert("请输入标题！");
			$("#zd_title").focus();
			return false;
	}else if($("#zd_author").val()==""){
			alert("请输入作者！");
			$("#zd_author").focus();
			return false;
	}else if($("#zd_pub_date").val()==""){
			alert("请输入发布日期！");
			$("#zd_pub_date").focus();
			return false;
	}else{
		var content =FCKeditorAPI.GetInstance("zd_content").GetXHTML(); 
		if(content==null||content==""){
			alert("内容不能为空");
			return false;
		} 
	}
	document.theform.submit();
}

</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="15"><span class="p982"><span class="pblue1">红色</span><font color="#FF0000">*</font><span class="pblue1">为必填项</span></span></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform" >
  	<!-- 
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>类别：</strong></td>
      <td class="list_cell_bg">
      <input type="radio" name="zd_catalog" value="1">专家看台
      <input type="radio" name="zd_catalog" value="2">大盘解读
      <input type="radio" name="zd_catalog" value="3">个股评论
        <font color="#FF0000">*</font></td>
    </tr>
     -->
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>标题：</strong></td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" style="width:300px" maxlength="50" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>作者：</strong></td>
      <td class="list_cell_bg"><input name="zd_add_ip" type="text" id="zd_add_ip" style="width:120px" maxlength="10" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>发布日期：</strong></td>
      <td class="list_cell_bg"><input name="zd_pub_date" type="text" id="zd_pub_date" style="width:120px" readonly class="required" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>相关股票：</strong></td>
      <td class="list_cell_bg"><input name="zd_stock_code" type="text" id="zd_stock_code" style="width:300px" maxlength="100" class="required" >
        </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>内容：</strong></td>
      <td class="list_cell_bg">
      	<FCK:editor instanceName="zd_content" toolbarSet="simple" width="93%" height="380">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor>
        <font color="#FF0000">*</font></td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" value="保存" onClick="submityn();">
          
		  
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
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
