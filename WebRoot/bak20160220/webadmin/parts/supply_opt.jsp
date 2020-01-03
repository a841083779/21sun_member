<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(7);


//=====页面属性====
String pagename="supply_opt.jsp";
String mypy="supply";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));


String urlpath="../parts/supply_list.jsp";

try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>配件发布</title>
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
		/*
		var obj2 = document.getElementsByName("product_flag");
		var productFlagValue = ",";
		for(var i=0;i<obj2.length;i++){
			if(obj2[i].checked){
				productFlagValue += obj2[i].value+",";
			}
		}
		if(productFlagValue==",") productFlagValue="";
		theform.zd_product_flag.value = productFlagValue;	
		*/
		if(theform.zd_parts_name.value==""){
			alert("请输入配件名称！");
			theform.zd_parts_name.focus();
			return false;
		}else if(theform.zd_city.value==""){
			alert("请选择省市！");
			theform.zd_city.focus();
			return false;
		}
		theform.submit();
}
</script>
<style type="text/css">
<!--
.STYLE1 {
	font-weight: bold;
	color: #FF0000;
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
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
    <tr>
      <td align="right" nowrap class="list_left_title">配件编号：</td>
      <td class="list_cell_bg"><input name="zd_parts_no" type="text" id="zd_parts_no" size="20" maxlength="20" ></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><div align="right"><strong><span class="STYLE1">会员编号</span>：</strong></div></td>
      <td class="list_cell_bg"><input name="zd_mem_no" type="text" id="zd_mem_no" size="20" value="<%if(adminInfo != null&&adminInfo.get("usern")!=null)out.print(adminInfo.get("usern"));%>" >
          <span class="list_left_title">会员编号：
            <input name="zd_mem_name" type="text" id="zd_mem_name" size="20" value="<%if(adminInfo != null&&adminInfo.get("realname")!=null)out.print(adminInfo.get("realname"));%>" >
        </span></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>配件名称</strong>：</td>
      <td class="list_cell_bg"><input name="zd_parts_name" type="text" id="zd_parts_name" size="40" maxlength="40" >
      <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">字母排序：</td>
      <td class="list_cell_bg"><input name="zd_letters" type="text" id="zd_letters" size="5" maxlength="5" ></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">规格型号：</td>
      <td class="list_cell_bg"><input name="zd_model" type="text" id="zd_model" size="40" maxlength="40" ></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">适用范围：</td>
      <td class="list_cell_bg"><input name="zd_scope" type="text" id="zd_scope" size="40" maxlength="40" ></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">价格：</td>
      <td class="list_cell_bg"><input name="zd_price" type="text" id="zd_price" size="10" maxlength="10" ></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">数量：</td>
      <td class="list_cell_bg"><input name="zd_amount" type="text" id="zd_amount" value="1" size="10" maxlength="10" ></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">标　　题：</td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" ></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">相关品牌：</td>
      <td class="list_cell_bg"><input name="zd_brandname" type="text" id="zd_brandname" size="30" maxlength="40" >
          <font color="#FF0000">
          <input type="hidden" id="zd_brand" name="zd_brand" value=""/>
          </font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">产地：</td>
      <td class="list_cell_bg"><input name="zd_place" type="text" id="zd_place" size="30" maxlength="40" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">省　　市：</td>
      <td height="22" class="list_cell_bg"><select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:100px;"  class="validate-selection">
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
          </select>
          </span><font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">所属类别：</td>
      <td height="22" class="list_cell_bg"><input name="zd_category" type="text" id="zd_category" size="10" maxlength="30" >
          <input name="zd_categoryname" type="text" id="zd_categoryname" size="10" maxlength="30" >
        <font color="#FF0000">
        <input type="hidden" id="zd_subcategory" name="zd_subcategory" value=""/>
      </font>      </td>
    </tr>
    
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图　　片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img1" type="text" id="zd_img1" size="50" maxlength="40">
<input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_img1','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">是否显示：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_show" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_show" name="zd_is_pub" value="0">
        否 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">首页推荐：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_index_recom" name="zd_index_recom" value="1">
是
  <input name="zd_index_recom" type="radio" id="zd_index_recom" value="0" checked>
否 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">产品促销：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_promotion" name="zd_is_promotion" value="1">
是
  <input name="zd_is_promotion" type="radio" id="zd_is_promotion" value="0" checked>
否 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">描　　述：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_content" cols="50" rows="8" id="zd_content" ></textarea>
      <font color="#FF0000">*</font></td>
    </tr>
    <tr >
      <td height="30" class="list_left_title" align="left" colspan="2"><div align="left">
        <input type="button" name="Submit" value="保存" onClick="submityn()">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
        <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
        <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
        
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>">
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
