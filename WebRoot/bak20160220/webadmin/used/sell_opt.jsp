<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%
//=====页面属性====
String pagename="sell_opt.jsp";
String mypy="sell_new";
String titlename="求出租管理";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));

String urlpath="../used/sell_opt.jsp";
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
<script src="../scripts/calendar.js"  type="text/javascript"></script>
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
			alert("请选择类型！");
			$("#zd_category").focus();
			return false;
		}			
		theform.submit();
}

</script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000;
	font-weight: bold;
}
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
      <td align="right" nowrap class="list_left_title">类别：</td>
      <td class="list_cell_bg"><select name="zd_category" id="zd_category" >
          <option value="">--请选择类别--</option>
          <option value="1">挖掘机</option>
          <option value="2">装载机</option>
          <option value="3">起重机</option>
          <option value="4">压路机</option>
          <option value="5">推土机</option>
          <option value="6">摊铺机</option>
          <option value="7">平地机</option>
          <option value="8">混凝土</option>
		  <option value="9">叉车</option>
          <option value="other">其他设备</option>
         </select></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">所在地：</td>
      <td class="list_cell_bg"><select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:100px;"  class="validate-selection">
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
        <select  name="zd_city" id="zd_city"  style="width:100px;">
          <option>选择城市</option>
        </select></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">图片：</td>
      <td class="list_cell_bg"><input name="zd_img1_1" type="text" id="zd_img1_1" size="50" maxlength="30"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><div align="right" class="STYLE1"><span class="STYLE1">会员编号</span>：</div></td>
      <td class="list_cell_bg"><input name="zd_mem_no" type="text" id="zd_mem_no" size="20" value="<%if(adminInfo != null&&adminInfo.get("usern")!=null)out.print(adminInfo.get("usern"));%>" >
          <span class="list_left_title">会员编号：
            <input name="zd_mem_name" type="text" id="zd_mem_name" size="20" value="<%if(adminInfo != null&&adminInfo.get("realname")!=null)out.print(adminInfo.get("realname"));%>" >
        </span></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">电话：</td>
      <td class="list_cell_bg"><input name="zd_per_phone" type="text" id="zd_per_phone" size="30" maxlength="30"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布日期：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_add_date" name="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" size="20" maxlength="20" />
      </td>
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
      <td height="22" align="right" nowrap class="list_left_title">内　　容：</td>
      <td height="22" class="list_cell_bg"><FCK:editor instanceName="zd_detail" toolbarSet="simple" width="93%" height="280">
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
         
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
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