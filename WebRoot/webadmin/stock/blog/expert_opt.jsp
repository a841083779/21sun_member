<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>

<%@ include file ="/webadmin/manage/config.jsp"%>
<%
String catalog = Common.getFormatStr(request.getParameter("catalog"));
//=====页面属性====
String pagename="expert_opt.jsp";
String mypy="stock_expert";
String titlename="专家";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));
String urlpath="/webadmin/stock/blog/expert_opt.jsp";
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
<script src="/webadmin/scripts/common.js"  type="text/javascript"></script>

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
	if($("#zd_name").val()==""){
			alert("请输入姓名！");
			$("#zd_name").focus();
			return false;
	}else if($("#zd_honor").val()==""){
			alert("请输入名号！");
			$("#zd_honor").focus();
			return false;
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
      <td align="right" nowrap class="list_left_title"><strong>姓名：</strong></td>
      <td class="list_cell_bg"><input name="zd_name" type="text" id="zd_name" style="width:120px" maxlength="25" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>名号：</strong></td>
      <td class="list_cell_bg"><input name="zd_honor" type="text" id="zd_honor" style="width:120px" maxlength="10" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>头像：</strong></td>
      <td class="list_cell_bg"><input name="zd_avatar" type="text" id="zd_avatar" style="width:320px" class="required" readonly><font color="#FF0000">*</font>
      <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=28&dir=stock&fieldname=zd_avatar','upload',480,150)"  value="">
        </td>
    </tr>

    <tr>
      <td align="right" nowrap class="list_left_title"><strong>简介：</strong></td>
      <td class="list_cell_bg"><textarea name="zd_description" id="zd_description" style="width:600px;height:200px" maxlength="500" ></textarea>
        </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>发布日期：</strong></td>
      <td class="list_cell_bg"><input name="zd_lattest_pub" type="text" id="zd_lattest_pub" readonly>
        </td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" value="保存" onClick="submityn();">
          
		  
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="zd_add_user" type="hidden" id="zd_add_user" value="<%=usern%>">
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
