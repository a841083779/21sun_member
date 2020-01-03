<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/webadmin/manage/config.jsp"%>
<%
//=====页面属性====
String pagename="stock_opt.jsp";
String mypy="stock_pool";
String titlename="股票信息";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));
String urlpath="/webadmin/stock/stock/stock_opt.jsp";
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
	if($("#zd_code").val()==""){
			alert("请输入股票代码！");
			$("#zd_code").focus();
			return false;
	}else if($("#zd_name").val()==""){
			alert("请输入股票名称！");
			$("#zd_name").focus();
			return false;
	}else if($("#zd_pinyin").val()==""){
			alert("请输入股票拼音！");
			$("#zd_pinyin").focus();
			return false;
	}else if($("#zd_shortname").val()==""){
			alert("请输入股票简称！");
			$("#zd_shortname").focus();
			return false;
	}else{
		var field = document.getElementsByName("zd_field");
		var c = 0;
		for(var i=0;i<field.length;i++){
			if(field[i].checked){
				c ++;
			}
		}
		if(c == 0){
			alert("请选择所属行业！");
			return false;
		}

		var market = document.getElementsByName("zd_market");
		c = 0;
		for(var i=0;i<market.length;i++){
			if(market[i].checked){
				c ++;
			}
		}
		if(c == 0){
			alert("请选择所属市场！");
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
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>股票代码：</strong></td>
      <td class="list_cell_bg"><input name="zd_code" type="text" id="zd_code" style="width:100px" maxlength="8" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>股票名称：</strong></td>
      <td class="list_cell_bg"><input name="zd_name" type="text" id="zd_name" style="width:100px" maxlength="6" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>股票拼音：</strong></td>
      <td class="list_cell_bg"><input name="zd_pinyin" type="text" id="zd_pinyin" style="width:100px" maxlength="6" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>股票简称：</strong></td>
      <td class="list_cell_bg"><input name="zd_shortname" type="text" id="zd_shortname" style="width:100px" maxlength="8" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>所属行业：</strong></td>
      <td class="list_cell_bg">
	  		<input type="radio" name="zd_field" value="0">工程机械行业
			<input type="radio" name="zd_field" value="1">钢铁上游
			<input type="radio" name="zd_field" value="2">发动机上游
			<input type="radio" name="zd_field" value="-1">建筑下游
			<input type="radio" name="zd_field" value="-2">矿山下游	  </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>所属市场：</strong></td>
      <td class="list_cell_bg">
	  	<input type="radio" name="zd_market" value="0">沪市
		<input type="radio" name="zd_market" value="1">深市
		<input type="radio" name="zd_market" value="-1">不限	  </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>是否有港股：</strong></td>
      <td class="list_cell_bg">
	  	<input type="radio" name="zd_is_hk" value="1">是
		<input type="radio" name="zd_is_hk" value="0" checked>否	  </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>港股代码：</strong></td>
      <td class="list_cell_bg">
	  	<input type="text" name="zd_hk_code" id="zd_hk_code" style="width:100px" maxlength="6" class="required">
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>是否有B股：</strong></td>
      <td class="list_cell_bg">
	  	<input type="radio" name="zd_is_b" value="1">是
		<input type="radio" name="zd_is_b" value="0" checked>否	  </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>B股代码：</strong></td>
      <td class="list_cell_bg">
	  	<input type="text" name="zd_b_code" id="zd_b_code" style="width:100px" maxlength="6" class="required">
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>重点企业：</strong></td>
      <td class="list_cell_bg">
	  	<input type="radio" name="zd_is_importance" value="1">是
		<input type="radio" name="zd_is_importance" value="0" checked>否	  </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>热点企业：</strong></td>
      <td class="list_cell_bg">
	  	<input type="radio" name="zd_is_hot" value="1">是
		<input type="radio" name="zd_is_hot" value="0" checked>否	  </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><strong>公司图片：</strong></td>
      <td height="22" class="list_cell_bg">
      <input name="zd_company_icon" type="text" id="zd_company_icon" size="60" maxlength="100">
      <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=28&dir=stock&fieldname=zd_company_icon','upload',480,150)"></td>
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
