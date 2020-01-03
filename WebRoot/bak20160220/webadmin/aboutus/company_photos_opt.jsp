<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="company_photos_opt.jsp";
String mypy="aboutus_pic";
String titlename="公司图片";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));


String urlpath="../aboutus/company_photos_opt.jsp";
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
	}else if($("#zd_sub_catalog_no").val()==""){
			alert("请选择类别！");
			$("#zd_sub_catalog_no").focus();
			return false;
		}			
		theform.submit();
}
function setName(obj){
	document.getElementById("zd_catalog_name").value=obj.options[obj.selectedIndex].innerText.replace(new RegExp(" ","g"),"");
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
      <td align="right" nowrap class="list_left_title">类型：</td>
      <td class="list_cell_bg"><select name="zd_sub_catalog_no" id="zd_sub_catalog_no" onChange="setName(this)">
                  <option value="">--请选择类别--</option>
			<option value="1" >公司图片－办公区</option>
			<option value="2">公司图片－会议室</option>
			<option value="3" >公司图片－活动室</option>
			<option value="4" >公司图片－外景</option>
			<option value="5" >活动剪影－旅游</option>
			<option value="6" >活动剪影－运动会</option>
			<option value="7" >活动剪影－聚餐</option>
			<option value="8" >活动剪影－训练</option>
			<option value="9" >活动剪影－公益活动</option>
			<option value="10" >活动剪影－公司活动</option>
			<option value="11" >活动剪影－行业活动</option>
              </select>
		</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">小　　图：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img" type="text" id="zd_img" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=19&dir=sell_buy_market&fieldname=zd_img','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">大　　图：</td>
      <td height="22" class="list_cell_bg"><input name="zd_bimg" type="text" id="zd_bimg" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=19&dir=sell_buy_market&fieldname=zd_bimg','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布日期：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_pub_date" name="zd_pub_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" size="20"      /></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">是否显示：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="2">
        否 </td>
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
		  <input name="zd_catalog_no" type="hidden" id="zd_catalog_no" value="701101">
		  <input name="zd_catalog_name" type="hidden" id="zd_catalog_name" >
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
	$('#getxinxi').attr("src","/webadmin/manage/set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
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
