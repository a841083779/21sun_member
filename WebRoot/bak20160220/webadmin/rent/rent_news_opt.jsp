<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%
//=====页面属性====
String pagename="rent_news_opt.jsp";
String mypy="rent_news";
String titlename="租赁新闻";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));


String urlpath="../rent/rent_news_opt.jsp";
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
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

function submityn(){
	if($("#zd_title").val()==""){
			alert("请输入标题！");
			$("#zd_title").focus();
			return false;
	}else if($("#zd_category").val()==""){
			alert("请选择类别！");
			$("#zd_category").focus();
			return false;
	 }
	 theform.submit();
}
</script>
<style type="text/css">
<!--
.p922 {color: black; font-size: 12px; line-height: 18px }
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
      <td align="right" nowrap class="list_left_title"><strong>标　　题：</strong></td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
	    <tr>
      <td align="right" nowrap class="list_left_title"><span class="STYLE1">会员编号：</span></td>
      <td class="list_cell_bg"><input name="zd_mem_no" type="text" id="zd_mem_no" value="<%if(adminInfo != null&&adminInfo.get("usern")!=null)out.print(adminInfo.get("usern"));%>"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">摘　　自：</td>
      <td height="22" class="list_cell_bg"><input name="zd_source" type="text" id="zd_source" size="50" maxlength="40"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">所　　属：</td>
      <td height="22" class="list_cell_bg"><span class="p922">
        <select name="zd_url" size="1" id="zd_url">
          <option value="系统公告">系统公告</option>
           <option value="北京">北京站</option>
          <option value="上海">上海站</option>
          <option value="天津">天津站</option>
          <option value="重庆">重庆站</option>
          <option value="河北">河北站</option>
          <option value="山西">山西站</option>
          <option value="辽宁">辽宁站</option>
          <option value="吉林">吉林站</option>
          <option value="黑龙江">黑龙江站</option>
          <option value="江苏">江苏站</option>
          <option value="浙江">浙江站</option>
          <option value="安徽">安徽站</option>
          <option value="福建">福建站</option>
          <option value="江西">江西站</option>
          <option value="山东">山东站</option>
          <option value="河南">河南站</option>
          <option value="湖北">湖北站</option>
          <option value="湖南">湖南站</option>
          <option value="广东">广东站</option>
          <option value="海南">海南站</option>
          <option value="四川">四川站</option>
          <option value="贵州">贵州站</option>
          <option value="云南">云南站</option>
          <option value="陕西">陕西站</option>
          <option value="甘肃">甘肃站</option>
          <option value="青海">青海</option>
          <option value="内蒙古">内蒙古站</option>
          <option value="广西">广西站</option>
          <option value="西藏">西藏站</option>
          <option value="宁夏">宁夏站</option>
          <option value="新疆">新疆站</option>
          <option value="台湾">台湾站</option>
          <option value="香港">香港站</option>
          <option value="澳门">澳门站</option>
        </select>
      </span></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><span class="p922">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 别</span>：</td>
      <td height="22" class="list_cell_bg"><select name="zd_category" id="zd_category">
          <option value="">--请选择类别--</option>
		  <option value="1001">租赁行情</option>
		  <option value="1002">系统公告</option>
          <!--<option value="2001">租赁实务</option>
         <option value="2002">租赁行情</option>
          <option value="2003">租赁法规</option>
          <option value="2004">名企名家</option>-->
        </select></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布日期：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_pubdate" name="zd_pubdate" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" size="20" maxlength="20"  readonly="true" /></td>
      </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">是否显示：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="2">
        否 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">内　　容：</td>
      <td height="22" class="list_cell_bg">
	  <FCK:editor instanceName="zd_content" toolbarSet="simple" width="93%" height="380">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor>
	  <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">关&nbsp; 键&nbsp; 词：</td>
      <td height="22" class="list_cell_bg"><input name="zd_keywords" type="text" id="zd_keywords" size="50" maxlength="40"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图　　片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_image" type="text" id="zd_image" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=19&dir=sell_buy_market&fieldname=zd_image','upload',480,150)"></td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
		  <input name="zd_catalog_no" type="hidden" id="zd_catalog_no" value="700702">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">  
          <input name="zd_html_filename" type="hidden" id="zd_html_filename" value="<%=Common.getFormatDate("yyyyMMddHHmmssSSS", new java.sql.Date(new java.util.Date().getTime()))+".htm"%>">
          <select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="visibility:hidden;">
          <option value="">选择省份</option>
          <option value="北京">北京</option>
          <option value="上海">上海</option>
          <option value="天津">天津</option>
          <option value="重庆">重庆</option>
          <option value="河北">河北</option>
          <option value="山西">山西</option>
          <option value="辽宁">辽宁</option>
          <option value="吉林">吉林</option>
          <option value="黑龙江">黑龙江</option>
          <option value="江苏">江苏</option>
          <option value="浙江">浙江</option>
          <option value="安徽">安徽</option>
          <option value="福建">福建</option>
          <option value="江西">江西</option>
          <option value="山东">山东</option>
          <option value="河南">河南</option>
          <option value="湖北">湖北</option>
          <option value="湖南">湖南</option>
          <option value="广东">广东</option>
          <option value="海南">海南</option>
          <option value="四川">四川</option>
          <option value="贵州">贵州</option>
          <option value="云南">云南</option>
          <option value="陕西">陕西</option>
          <option value="甘肃">甘肃</option>
          <option value="青海">青海</option>
          <option value="内蒙古">内蒙古</option>
          <option value="广西">广西</option>
          <option value="西藏">西藏</option>
          <option value="宁夏">宁夏</option>
          <option value="新疆">新疆</option>
          <option value="台湾">台湾</option>
          <option value="香港">香港</option>
          <option value="澳门">澳门</option>
        </select>
        <select  name="zd_city" id="zd_city"  style="visibility:hidden;">
          <option>选择城市</option>
        </select>
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
