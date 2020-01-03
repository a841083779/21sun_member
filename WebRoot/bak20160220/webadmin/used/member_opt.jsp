<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%@ include file ="/usedmarket/include/dictionary.jsp"%>
<%
	String diqu = GetUrlStrForHttp.GetURLstr("http://www.21-used.com/directory/common.jsp?flag=1");
	String tubiao = GetUrlStrForHttp.GetURLstr("http://www.21-used.com/directory/common.jsp?flag=2");
	String pinpai = GetUrlStrForHttp.GetURLstr("http://www.21-used.com/directory/common.jsp?flag=3");
%>
<%
// 查询出已经推荐的设备
PoolManager pool4   = new PoolManager(4);
String[][] tempInfo = null;
//=====页面属性====
String pagename="member_opt.jsp";
String mypy="member_ext_used";
String titlename="会员管理";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));

String urlpath="../used/member_opt.jsp";

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
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform" >
    <tr>
    	<td width="10%">
    		会员编号
    	</td>
      <td width="40%">
     	 	<input type="text" readonly="readonly" name="zd_mem_no" id="zd_mem_no" value="" />
      </td>
      <td width="10%">会员名称</td>
      <td width="40%">
      		<input type="text" readonly="readonly" name="zd_mem_name" id="zd_mem_name" value="" />
      </td>
    </tr>
    
    <tr>
    	<td width="10%">
    		公司名称
    	</td>
      <td width="90%" colspan="3">
     	 	<input type="text" readonly="readonly" name="zd_company" id="zd_company" value="" style="width: 520px;" />
      </td>
    </tr>
    
    <tr>
      <td width="10%">
    		所属区域
      </td>
      <td width="40%" id="area">
      		<%=diqu%>
      </td>
      <td width="10%">
    		图标
      </td>
      <td width="40%">
      		<%=tubiao%>
      </td>
    </tr>
    
    
    <tr>
      <td width="10%">
    		经度
      </td>
      <td width="40%">
      		<input type="text" name="zd_longitude" id="zd_longitude" />
      </td>
      <td width="10%">
    		纬度
    	</td>
      <td width="40%">
     	 	<input type="text" name="zd_latitude" id="zd_latitude" />
      </td>
    </tr>
    
     <tr>
     <td width="10%">
    		缩放等级
   	 </td>
     <td width="40%">
     		<select name="zd_zoom" id="zd_zoom">
     			<option value="0">0</option>	
     			<option value="1">1</option>
     			<option value="2">2</option>
     			<option value="3">3</option>
     			<option value="4" selected="selected">4</option>
     			<option value="5">5</option>
     			<option value="6">6</option>
     			<option value="7">7</option>
     			<option value="8">8</option>
     		</select>
     </td>
 	 <!-- <td width="10%">
    		有效期
    	</td>
      <td width="40%">
     	 	<input type="text" name="zd_validity_date" id="zd_validity_date" readonly="readonly" onFocus="calendar(event)" />
      </td> -->
      <td width="10%">
    		是否显示
    	</td>
      <td width="40%">
     	 	<input type="radio" id="zd_is_show" name="zd_is_show" value="1"/>是
     	 	<input type="radio" id="zd_is_show" name="zd_is_show" value="0"/>否
      </td>
    </tr>
	
	<tr>
    	<td width="10%">
    		品牌
    	</td>
      <td width="40%">
			<%=pinpai%>
      </td>
	  <td width="10%">&nbsp;
    		
    	</td>
      <td width="40%">&nbsp;
     	 	
      </td>
    </tr>
    
    
    <tr>
    	<td width="10%">
    		链接地址
    	</td>
      <td width="90%" colspan="3">
     	 	<input type="text" name="zd_link_url" id="zd_link_url" value="" style="width: 520px;" />
      </td>
    </tr>
    
     <tr>
    	<td width="10%">
    		业务介绍
    	</td>
      <td width="90%" colspan="3">
      	<FCK:editor instanceName="zd_intro" toolbarSet="simple" width="93%" height="280">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor>
      </td>
    </tr>
    
    
    <tr >
      <td height="30px" class="list_left_title" align="center" colspan="4">
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
