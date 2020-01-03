<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%
	pool = new PoolManager(9);

//=====页面属性====
String pagename="supply_opt.jsp";
String mypy="fittings_business_info";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
//flag 1:配套合作;2:代理招商;3:求购信息;4:供应信息
String flag=Common.getFormatInt(request.getParameter("flag"));
if(flag.equals("0")){
	flag = "4";
}
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));


String urlpath="../fittings/supply_list.jsp";

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
		//var obj2 = document.getElementsByName("product_flag");
		//var productFlagValue = ",";
		//for(var i=0;i<obj2.length;i++){
		//	if(obj2[i].checked){
		//		productFlagValue += obj2[i].value+",";
		//	}
		//}
		//if(productFlagValue==",") productFlagValue="";
		//theform.zd_product_flag.value = productFlagValue;
			
		if(theform.zd_title.value==""){
			alert("请输入标题！");
			theform.zd_title.focus();
			return false;
		}else if(theform.zd_province.value==""){
			alert("请选择省份！");
			theform.zd_province.focus();
			return false;
		}else if(theform.zd_city.value==""){
			alert("请选择城市！");
			theform.zd_city.focus();
			return false;
		//}else if(theform.zd_product_flag.value==""){
		//	alert("请选择机型！");
		//	return false;
		}else if(returnRadio("zd_part_sort")==false){
			alert("请选择所属类别！");
			return false;			
		}else if(theform.zd_describ.value==""){
			alert("请输入详情，内容控制在300个汉字以内！");
			theform.zd_describ.focus();
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
      <td align="right" nowrap class="list_left_title">销售价格：</td>
      <td class="list_cell_bg"><input name="zd_price" type="text" id="zd_price" size="60" maxlength="50" ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><font color="#FF0000">*</font>发 货 地：</td>
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
          <td  class="right" nowrap="nowrap" ><div align="right"><font color="#FF0000">*</font><span class="grayb">信息类型：</span></div></td>
          <td height="22" class="list_cell_bg"><input type="radio" id="info_type1" name="zd_info_type" value="配套件" style="border:0"; onClick="showTr();"/>
            配套件
            <input type="radio" id="info_type2" name="zd_info_type" value="原料" style="border:0"; onClick="showTr();"/>
            原料
            <input type="radio" id="info_type3" name="zd_info_type" value="加工设备" style="border:0"; onClick="showTr();" />
            加工设备
            <input type="radio" id="info_type4" name="zd_info_type" value="其它" style="border:0"; onClick="showTr();" />
            其它 </td>
        </tr>
    <tr>
          <td  class="right"nowrap="nowrap"><div align="right"><font color="#FF0000">*</font><span class="grayb">所属类别：</span></div></td>
          <td height="22" class="list_cell_bg">
		    <input type="radio" id="part_sort1" name="zd_part_sort" value="10" /style="border:0";>
            结构件
            <input type="radio" id="part_sort2" name="zd_part_sort" value="11" style="border:0";/>
            液压系统
            <input type="radio" id="part_sort3" name="zd_part_sort" value="12" style="border:0";/>
            传动系统
            <input type="radio" id="part_sort4" name="zd_part_sort" value="13" style="border:0";/>
            动力系统
            <input type="radio" id="part_sort5" name="zd_part_sort" value="14" style="border:0";/>
            电气系统<br />
			<input type="radio" id="part_sort6" name="zd_part_sort" value="15" style="border:0";/>
            覆盖件（钣金件）
			<input type="radio" id="part_sort7" name="zd_part_sort" value="16" style="border:0";/>
            精加工件
			<input type="radio" id="part_sort8" name="zd_part_sort" value="17" style="border:0";/>
            特殊工作装置
			<input type="radio" id="part_sort9" name="zd_part_sort" value="18" style="border:0";/>
            辅料及其他</td>
        </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图　　片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img" type="text" id="zd_img" size="50" maxlength="40">
<input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=19&dir=fittings&fieldname=zd_img','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">是否发布：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_show1" name="zd_is_show" value="1" checked="checked">
        发布
        <input type="radio" id="zd_is_show2" name="zd_is_show" value="0">
        暂停 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">详　　情：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_describ" cols="50" rows="8" id="zd_describ" onKeyUp="if((this.value).length>300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}"></textarea>
      <font color="#FF0000">*</font></td>
    </tr>	
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">发布人帐号：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_mem_no" name="zd_mem_no" size="20" maxlength="20"/></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">发布人qq：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_qq" name="zd_qq" size="20" maxlength="20"/></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">所属公司：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_company" name="zd_company" size="20" maxlength="200"/></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">联系电话：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_tel" name="zd_tel" size="20" maxlength="20"/></td>
    </tr>
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">网　　址：</td>
      <td height="22" class="list_cell_bg"><font color="#FF0000">*</font><input type="text" id="zd_url" name="zd_url" size="20" maxlength="20"/></td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
        <input type="button" name="Submit" value="保存" onClick="submityn()">
        <input name="zd_id" type="hidden" id="zd_id" value="0" />
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
        <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
		<input name="zd_update_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
        <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>" />
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>' />
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
        <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>" />
        <input name="randflag" type="hidden" id="randflag" value="1" />
		<input name="zd_flag" type="hidden" id="zd_flag" value="<%=flag%>" />
		<input name="zd_no" type="hidden" id="zd_no" value="<%=Common.generateDateRandom()%>" />
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
