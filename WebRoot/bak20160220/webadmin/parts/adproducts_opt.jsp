<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(7);


//=====页面属性====
String pagename="adproducts_opt.jsp";
String mypy="ad_products_category";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));

try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>配件产品分类管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script src="../scripts/calendar.js"  type="text/javascript"></script>
<script>
var subCategory = new Array();
<cache:cache key="cache_subcategory" cron="0 0/30 6-23 * * ?">
<%	
String[][] subCategory = DataManager.fetchFieldValue(pool, "parts_catalog","num,name,parentid", "parentid<>0");
if(subCategory!=null){
	for(int i=0;i<subCategory.length;i++){
%>
	subCategory[<%=i%>]=['<%=subCategory[i][0]%>','<%=subCategory[i][1]%>','<%=subCategory[i][2]%>']; 
<%
	   }
	}
%>
</cache:cache>
function set_subcategory(obj){
	document.getElementById("zd_categoryname").value=obj.options[obj.selectedIndex].text;
	var sub = document.getElementById("zd_subcategory");
	sub.length=0;
	sub.options[0]=new Option('选择子分类','');
	for(var i=0,j=1;i<subCategory.length;i++){
		if(subCategory[i][0].length>3 && subCategory[i][0].substring(0,3)==obj.value){
			sub.options[j]=new Option(subCategory[i][1],subCategory[i][0]);
			j++;
		}
	}
}
function set_subcategoryname(obj){
	document.getElementById("zd_subcategoryname").value=obj.options[obj.selectedIndex].text;
}

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
		if(theform.zd_ads_name.value==""){
			alert("请输入图片广告名称！");
			theform.zd_ads_name.focus();
			return false;
		}
		theform.submit();
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
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
    <tr>
      <td align="right" nowrap class="list_left_title">产品分类：</td>
      <td class="list_cell_bg"><select name="zd_category" id="zd_category" onChange="set_subcategory(this);" style="width:100px;"  class="blue1">
        <option value="">请选择分类</option>
		<option value="101">挖掘机配件</option>
		<option value="102">装载机配件</option>
		<option value="103">路面设备配件</option>
		<option value="104">混凝土机械配件</option>
		<option value="105">破碎锤配件</option>
		<option value="106">其它配件</option>
		<option value="107">原料、加工设备</option>
		<option value="108">矿山机械</option>
      </select>
        <select  name="zd_subcategory" id="zd_subcategory" style="width:100px;" class="blue1" onChange="set_subcategoryname(this);">
          <option>选择子分类</option>
        </select>
        <input type="hidden" name="zd_categoryname"    id="zd_categoryname"/>
        <input type="hidden" name="zd_subcategoryname" id="zd_subcategoryname"/>
        </span></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>图片广告名称</strong>：</td>
      <td class="list_cell_bg"><input name="zd_ads_name" type="text" id="zd_ads_name" size="40" maxlength="40" >
      <font color="#FF0000">*</font></td>
    </tr>
    
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片广告图片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_ads_pic" type="text" id="zd_ads_pic" size="50" maxlength="40">
<input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=23&dir=part&fieldname=zd_ads_pic','upload',480,150)">
(100*40)</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片广告链接：</td>
      <td height="22" class="list_cell_bg"><input name="zd_ads_url" type="text" id="zd_ads_url" size="50" maxlength="40"></td>
    </tr>
	    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片广告显示：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_ads_isshow" name="zd_ads_isshow" value="1" checked="checked">
        是
        <input type="radio" id="zd_ads_isshow" name="zd_ads_isshow" value="0">
        否 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司(产品)名称：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_name" type="text" id="zd_comp_name" size="50" maxlength="40"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司(产品)链接：</td>
      <td height="22" class="list_cell_bg"><input name="zd_comp_url" type="text" id="zd_comp_url" size="50" maxlength="40"></td>
    </tr>
	    <tr>
      <td height="22" align="right" nowrap class="list_left_title">公司显示：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_comp_isshow" name="zd_comp_isshow" value="1">
        是
        <input name="zd_comp_isshow" type="radio" id="zd_comp_isshow" value="0" checked>
        否 </td>
    </tr>
	    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">首页大类推荐：</td>
	      <td height="22" class="list_cell_bg"><input type="radio" id="zd_index_recom" name="zd_index_recom" value="1">
是
  <input name="zd_index_recom" type="radio" id="zd_index_recom" value="0" checked>
否 </td>
    </tr>
	    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">广告发布时间：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_pub_date" type="text" id="zd_pub_date" size="15" value="<%=Common.getToday("yyyy-MM-dd",0)%>" onFocus="calendar(event)"></td>
    </tr>
	    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">广告结束时间：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_end_date" type="text" id="zd_end_date" size="15"onFocus="calendar(event)"></td>
    </tr>
	    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">广告类型：</td>
	      <td height="22" class="list_cell_bg"><input type="radio" id="zd_ads_type" name="zd_ads_type" value="1" checked="checked">
	        购买
	        <input type="radio" id="zd_ads_type" name="zd_ads_type" value="2">赠送
			  <input type="radio" id="zd_ads_type" name="zd_ads_type" value="3">临时
	         </td>
    </tr> 
    <tr >
      <td height="30" class="list_left_title" align="left" colspan="2"><div align="left">
        <input type="button" name="Submit" value="保存" onClick="submityn()">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
        <input name="zd_mem_no" type="hidden" id="zd_mem_no" value="">
        <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
        <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
        
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>">
        

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
}
%>
