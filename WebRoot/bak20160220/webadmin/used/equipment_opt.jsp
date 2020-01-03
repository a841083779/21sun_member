<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%@ include file ="/usedmarket/include/dictionary.jsp"%>
<%
// 查询出已经推荐的设备
PoolManager pool4   = new PoolManager(4);
String[][] tempInfo = null;
//=====页面属性====
String pagename="equipment_opt.jsp";
String mypy="equipment_new";
String titlename="二手设备管理";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));

String urlpath="../used/equipment_opt.jsp";

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
      <td align="right" nowrap class="list_left_title"><div align="right"><strong><span class="STYLE1">会员编号</span>：</strong></div></td>
      <td class="list_cell_bg"><input name="zd_mem_no" type="text" id="zd_mem_no" size="20" value="<%if(adminInfo != null&&adminInfo.get("usern")!=null)out.print(adminInfo.get("usern"));%>" readonly="readonly" />
          <span class="list_left_title">会员编号：
            <input name="zd_mem_name" type="text" id="zd_mem_name" size="20" value="<%if(adminInfo != null&&adminInfo.get("realname")!=null)out.print(adminInfo.get("realname"));%>" readonly="readonly" />
        </span></td>
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
         </select>
		<input type="hidden" name="zd_subcategory" id="zd_subcategory" value="">
		<span class="list_left_title">品牌：
		<input name="zd_brand" type="hidden" id="zd_brand" size="10" maxlength="10">
        <input name="zd_brandname" type="text" id="zd_brandname" value="" size="20" maxlength="20" readonly="readonly">
		</span></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">型号：</td>
      <td class="list_cell_bg"><input name="zd_model" type="text" id="zd_model" size="10">
      车号：
      <input name="zd_car_no" type="text" id="zd_car_no" size="15" maxlength="30"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><SPAN lang="zh-cn">发动机品牌型号</SPAN>：</td>
      <td class="list_cell_bg"><input name="zd_engine" type="text" id="zd_engine" size="15">
      设备来源：
      
      <select name="zd_source" id="zd_source">
        <option value="1">演示样机</option>
        <option value="2">设备存货</option>
        <option value="3">租赁机队</option>
        <option value="4">以旧换新</option>
        <option value="5">市场收购</option>
        <option value="6">委托销售</option>
        <option value="7">其他</option>
      </select>      </td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">出厂日期：</td>
      <td class="list_cell_bg"><input name="zd_factorydate" type="text" id="zd_factorydate" size="15" maxlength="15">
        工作时间：
        <input name="zd_workingtime" type="text" id="zd_workingtime" size="15" maxlength="15"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">产地：</td>
      <td class="list_cell_bg"><span class="list_left_title">
        <input type="radio" id="radio3" name="zd_place" value="0" checked="checked">
国内
<input type="radio" id="radio3" name="zd_place" value="1">
进口 </span>
        所属省市：
          <select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:100px;"  class="validate-selection">
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
      </select></td></tr>
    <tr>
      <td align="right" nowrap class="list_left_title">价格：</td>
      <td class="list_cell_bg"><input name="zd_price" type="text" id="zd_price" size="5" maxlength="5">
      万元 <span class="list_left_title">
      点击次数：<input name="zd_clicked" id="zd_clicked" type="text" />
	  </span></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">发布状态：</td>
      <td class="list_cell_bg">
        <span class="list_left_title">
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="0">
        否</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		销售状态： <input type="radio" id="zd_is_sale" name="zd_is_sale" value="1">
		是
		<input type="radio" id="zd_is_sale" name="zd_is_sale" value="0" checked="checked">
		否 </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">推荐状态：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_recom" name="zd_recom" value="0" checked="checked">
      否
        <input type="radio" id="zd_recom" name="zd_recom" value="1"> 是 </td>
    </tr>	
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">维修记录：</td>
      <td height="22" class="list_cell_bg"><FCK:editor instanceName="zd_detail" toolbarSet="simple" width="93%" height="280">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor>
        <font color="#FF0000">*</font></td>
    </tr>
	    <tr>
      <td height="22" align="right" nowrap class="list_left_title">主图片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img1" type="text" id="zd_img1" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img1','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片1：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img2" type="text" id="zd_img2" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img2','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片2：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img3" type="text" id="zd_img3" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img3','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片3：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img4" type="text" id="zd_img4" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img4','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片4：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img5" type="text" id="zd_img5" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img5','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片5：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img6" type="text" id="zd_img6" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img6','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片6：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img7" type="text" id="zd_img7" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img7','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片7：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img8" type="text" id="zd_img8" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img8','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片8：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img9" type="text" id="zd_img9" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img9','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片9：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img10" type="text" id="zd_img10" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img10','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片10：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img11" type="text" id="zd_img11" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img11','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片11：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img12" type="text" id="zd_img12" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img12','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片12：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img13" type="text" id="zd_img13" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img13','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片13：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img14" type="text" id="zd_img14" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img14','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片14：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img15" type="text" id="zd_img15" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img15','upload',480,150)"></td>
    </tr>
	    <tr>
      <td height="22" align="right" nowrap class="list_left_title">图片15：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img16" type="text" id="zd_img16" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img16','upload',480,150)"></td>
    </tr>
	    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">图片16：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img17" type="text" id="zd_img17" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img17','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">图片17：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img18" type="text" id="zd_img18" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img18','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">图片18：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img19" type="text" id="zd_img19" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img19','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">图片19：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img20" type="text" id="zd_img20" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img20','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">图片20：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img21" type="text" id="zd_img21" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img21','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">图片21：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img22" type="text" id="zd_img22" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img22','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">驾驶室情况：</td>
      <td height="22" class="list_cell_bg">
	  	<select name="zd_cap_desc" id="zd_cap_desc">
			<option value="0">暂无信息</option>
			<%for(int i=0;i<pub_cap.length;i++){
					out.println("<option value='"+(i+1)+"'>"+pub_cap[i]+"</option>");
				}%>
		</select>
	  </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">电器系统情况：</td>
      <td height="22" class="list_cell_bg">
	  	<select name="zd_elect_desc" id="zd_elect_desc">
			<option value="0">暂无信息</option>
			<%for(int i=0;i<pub_elect.length;i++){
					out.println("<option value='"+(i+1)+"'>"+pub_elect[i]+"</option>");
				}%>
		</select>
	  </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><SPAN lang="zh-cn">动力系统情况：</SPAN>：</td>
      <td height="22" class="list_cell_bg">
	  	<select name="zd_power_desc" id="zd_power_desc">
			<option value="0">暂无信息</option>
			<%for(int i=0;i<pub_power.length;i++){
					out.println("<option value='"+(i+1)+"'>"+pub_power[i]+"</option>");
				}%>
		</select>
	  </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">液压系统情况：</td>
      <td height="22" class="list_cell_bg">
	  	<select name="zd_hyd_desc" id="zd_hyd_desc">
			<option value="0">暂无信息</option>
			<%for(int i=0;i<pub_hyd.length;i++){
					out.println("<option value='"+(i+1)+"'>"+pub_hyd[i]+"</option>");
				}%>
		</select>
	  </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">设备外观漆面：</td>
      <td height="22" class="list_cell_bg">
	  	<select name="zd_vision_desc" id="zd_vision_desc">
			<option value="0">暂无信息</option>
			<%for(int i=0;i<pub_vision.length;i++){
					out.println("<option value='"+(i+1)+"'>"+pub_vision[i]+"</option>");
				}%>
		</select>
	  </td>
    </tr>
	<!--
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><span class="STYLE1">是否竞拍：</span>&nbsp;</td>
      <td height="22" class="list_cell_bg"><span class="list_left_title">
        <input type="radio" id="radio2" name="zd_is_auction" value="0" checked="checked">
否
<input type="radio" id="radio2" name="zd_is_auction" value="1">
是 </span></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">起拍价格：</td>
      <td height="22" class="list_cell_bg"><input name="zd_starting_price" type="text" id="zd_starting_price" size="5" maxlength="10">
      万元</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">最高出价：</td>
      <td height="22" class="list_cell_bg"><input name="zd_highest_price" type="text" id="zd_highest_price" size="5" maxlength="10">
      万元</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">竞拍次数：</td>
      <td height="22" class="list_cell_bg"><input name="zd_auction_nums" type="text" id="zd_auction_nums" size="10" maxlength="10"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">竞拍开始时间：</td>
      <td height="22" class="list_cell_bg"><input name="zd_auction_start" type="text" id="zd_auction_start" size="20" maxlength="20" onFocus="calendar(event)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">竞拍结束时间：</td>
      <td height="22" class="list_cell_bg"><input name="zd_auction_end" type="text" id="zd_auction_end" size="20" maxlength="20" onFocus="calendar(event)"></td>
    </tr>
	-->
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">物流运输：</td>
      <td height="22" class="list_cell_bg">
	  	<select name="zd_logistics" id="zd_logistics">
			<option value="0">暂无信息</option>
			<%for(int i=0;i<pub_logistics.length;i++){
				  		out.println("<option value='"+(i+1)+"'>"+pub_logistics[i]+"</option>");
				  }%>
		</select>
	  </td>
    </tr>
	
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">发   票：</td>
      <td height="22" class="list_cell_bg">
	  	<select name="zd_checkbook" id="zd_checkbook">
			<option value="0">暂无信息</option>
			<%for(int i=0;i<pub_checkbook.length;i++){
						out.println("<option value='"+(i+1)+"'>"+pub_checkbook[i]+"</option>");
				}%>
		</select>
	  </td>
    </tr>
    <!--
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">最后竞拍人：</td>
      <td height="22" class="list_cell_bg"><input name="zd_last_auction" type="text" id="zd_last_auction" size="15" maxlength="15">
      /
      <input name="zd_last_auction_no" type="text" id="zd_last_auction_no" size="15" maxlength="15"></td>
    </tr>
	-->
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">吨位：</td>
      <td height="22" class="list_cell_bg"><select name="zd_tons" id="zd_tons">
	  	<option value="0">暂无信息</option>
        <option value="1">5砘以下</option>
        <option value="2">5-8砘</option>
        <option value="3">8-15吨</option>
        <option value="4">15-25吨</option>
        <option value="5">25吨以上</option>
      </select>      </td>
    </tr>
    
	<!--
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">竞拍编号：</td>
      <td height="22" class="list_cell_bg"><input name="zd_auction_no" type="text" id="zd_auction_no" size="20" maxlength="20" ></td>
    </tr>
	-->
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
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
titlename = null;
urlpath   = null;
tempInfo  = null;
}
%>
