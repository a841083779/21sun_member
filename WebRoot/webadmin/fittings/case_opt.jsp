<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%
	pool = new PoolManager(9);

	//=====页面属性====
	String pagename="case_opt.jsp";
	String mypy="fittings_member_info_case";
	String titlename="";
	//====得到参数====
	String isReload=Common.getFormatInt(request.getParameter("isReload"));
	String myvalue=Common.getFormatStr(request.getParameter("myvalue"));
	String urlpath="../fittings/case_list.jsp";
	try{//====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>配套合作</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

//为多选框赋值
function submityn(){
	    //if(pubCount>=30){
		//  alert("您今天已发布了"+pubCount+"条配套合作信息，已经达到最大发布数！");   
		//  return false; 
		//}	
			
		if(theform.zd_title.value==""){
			alert("请输入标题！");
			theform.zd_title.focus();
			return false;
		}else if(theform.zd_img.value==""){
			alert("请上传图片！");
			theform.zd_img.focus();
			return false;
		}else if(theform.zd_mem_no.value==""){
			alert("请输入会员帐号！");
			theform.zd_mem_no.focus();
			return false;
		}
			
		theform.submit();
}
</script>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15"><span class="p982"><span class="pblue1"></span><font color="#FF0000">*</font><span class="pblue1">号为必填项</span></span></td>
    </tr>
</table>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
    <tr>
      <td align="right" nowrap class="list_left_title"><font color="#FF0000">*</font>标　　题：</td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">案例图片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img" type="text" id="zd_img" size="50" maxlength="200">
<input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=19&dir=fittings&fieldname=zd_img','upload',480,150)"></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">发布人帐号：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_mem_no" name="zd_mem_no" size="20" maxlength="20"/></td>
    </tr>
	
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
        <input type="button" name="Submit" value="保存" onClick="submityn()">
        <input name="zd_id" type="hidden" id="zd_id" value="0" />
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
        <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
        <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" />
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
        <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>" />
        <input name="randflag" type="hidden" id="randflag" value="1" />
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
if(!myvalue.equals("")){
	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>
