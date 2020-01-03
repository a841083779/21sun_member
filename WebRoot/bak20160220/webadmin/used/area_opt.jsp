<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%@ include file ="/usedmarket/include/dictionary.jsp"%>
<%
// 查询出已经推荐的设备
PoolManager pool4   = new PoolManager(4);
String[][] tempInfo = null;
//=====页面属性====
String pagename="area_opt.jsp";
String mypy="member_area";
String titlename="地域管理";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));

String urlpath="../used/area_opt.jsp";

if(!myvalue.equals("0"))
urlpath=urlpath+"?myvalue="+myvalue;

try{//====标题的名称====
  //System.out.println(recomArr.indexOf("A"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=titlename%></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/calendar.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

function submityn(){
  
  if($("#zd_category").val()==""){
			alert("请选择类型！");
			$("#zd_category").focus();
			return false;
	}
	theform.submit();
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
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform" >
    <tr>
    	<td width="20%">
    		地域名称
    	</td>
      <td  width="80%">
     	 <input name="zd_name" type="text" id="zd_name" size="50" />
      </td>
    </tr>
 	 <tr>
    	<td>
    		经度
    	</td>
      <td>
     	 <input name="zd_longitude" type="text" id="zd_longitude" size="50" />
      </td>
    </tr>
    <tr>
    	<td>
    		纬度
    	</td>
      <td>
     	 <input name="zd_latitude" type="text" id="zd_latitude" size="50" />
      </td>
    </tr>
    <tr>
    	<td>
    		放大级别
    	</td>
      <td>
     	 <input name="zd_zoom" type="text" id="zd_zoom" size="50" />
      </td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="center" colspan="2">
      	<div align="center">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
           <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
		  </div>
		</td>
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
titlename = null;
urlpath   = null;
tempInfo  = null;
}
%>
