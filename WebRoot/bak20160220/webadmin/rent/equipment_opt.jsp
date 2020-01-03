<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%
// 查询出已经推荐的设备
PoolManager pool3   = new PoolManager(3);
//=====页面属性====
String pagename="equipment_opt.jsp";
String mypy="equipment";
String titlename="租赁设备管理";
//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));

String urlpath="../rent/equipment_opt.jsp";

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
   var is_recom = document.getElementsByName('zd_is_recom');
 	$("#zd_brandname").val($("select[name='zd_brand'] option[selected]").text());
	$("#zd_categoryname").val($("select[name='zd_category'] option[selected]").text().replaceAll("\u00a0",""));
	//===生成标题====
	$("#zd_title").val("出租"+$("#zd_factorydate").val()+"年产"+$("#zd_brandname").val()+$("#zd_model").val()+$('#zd_category option:selected').text().replaceAll("\u00a0",""));
	
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
      <td align="right" nowrap class="list_left_title"><strong>标　　题：</strong></td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" class="required" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><div align="right"><strong><span class="STYLE1">会员编号</span>：</strong></div></td>
      <td class="list_cell_bg"><input name="zd_mem_no" type="text" id="zd_mem_no" size="20" value="<%if(adminInfo != null&&adminInfo.get("usern")!=null)out.print(adminInfo.get("usern"));%>" >
          <span class="list_left_title">会员编号：
            <input name="zd_mem_name" type="text" id="zd_mem_name" size="20" value="<%if(adminInfo != null&&adminInfo.get("realname")!=null)out.print(adminInfo.get("realname"));%>" >
        </span></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">类别：</td>
      <td class="list_cell_bg"><select name="zd_category" id="zd_category">
                    <option value=""> --请选择类别-- </option>
                    <option value="01">路面机械</option>
                    <option value="0101">&nbsp;&nbsp;&nbsp;&nbsp;摊铺机</option>
                    <option value="0102">&nbsp;&nbsp;&nbsp;&nbsp;压路机</option>
                    <option value="0103">&nbsp;&nbsp;&nbsp;&nbsp;平地机</option>
                    <option value="0104">&nbsp;&nbsp;&nbsp;&nbsp;铣刨机 </option>
                    <option value="0105">&nbsp;&nbsp;&nbsp;&nbsp;推土机</option>
                    <option value="0106">&nbsp;&nbsp;&nbsp;&nbsp;沥青搅拌站</option>
                    <option value="0107">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
                    <option value="02">起重机系</option>
					<option value="0201">&nbsp;&nbsp;&nbsp;&nbsp;塔吊</option>
                    <option value="0202">&nbsp;&nbsp;&nbsp;&nbsp;履带吊</option>
					<option value="0203">&nbsp;&nbsp;&nbsp;&nbsp;汽车吊</option>
					<option value="0204">&nbsp;&nbsp;&nbsp;&nbsp;龙门吊</option>
					<option value="0205">&nbsp;&nbsp;&nbsp;&nbsp;高空作业车</option>
					<option value="0206">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="03">混凝土系</option>
					<option value="0301">&nbsp;&nbsp;&nbsp;&nbsp;泵车</option>
                    <option value="0302">&nbsp;&nbsp;&nbsp;&nbsp;搅拌运输车</option>
					<option value="0303">&nbsp;&nbsp;&nbsp;&nbsp;搅拌站</option>
					<option value="0304">&nbsp;&nbsp;&nbsp;&nbsp;搅拌车</option>
					<option value="0305">&nbsp;&nbsp;&nbsp;&nbsp;拖泵</option>
					<option value="0306">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="04">土石方系</option>
					<option value="0401">&nbsp;&nbsp;&nbsp;&nbsp;挖掘机</option>
                    <option value="0402">&nbsp;&nbsp;&nbsp;&nbsp;推土机</option>
					<option value="0403">&nbsp;&nbsp;&nbsp;&nbsp;定向钻机</option>
					<option value="0404">&nbsp;&nbsp;&nbsp;&nbsp;装载机</option>
					<option value="0405">&nbsp;&nbsp;&nbsp;&nbsp;自卸车</option>
					<option value="0406">&nbsp;&nbsp;&nbsp;&nbsp;挖掘装载机</option>
					<option value="0407">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="05">动力设备</option>
					<option value="0501">&nbsp;&nbsp;&nbsp;&nbsp;发电机组</option>
                    <option value="0502">&nbsp;&nbsp;&nbsp;&nbsp;发动机</option>
					<option value="0503">&nbsp;&nbsp;&nbsp;&nbsp;空压机</option>
					<option value="0504">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="06">市政机械</option>
					<option value="0601">&nbsp;&nbsp;&nbsp;&nbsp;清扫机</option>
                    <option value="0602">&nbsp;&nbsp;&nbsp;&nbsp;除雪机</option>
					<option value="0603">&nbsp;&nbsp;&nbsp;&nbsp;排障车</option>
					<option value="0604">&nbsp;&nbsp;&nbsp;&nbsp;洒水车</option>
					<option value="0605">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="07">桩工桥梁机械</option>
					<option value="0701">&nbsp;&nbsp;&nbsp;&nbsp;旋挖钻</option>
                    <option value="0702">&nbsp;&nbsp;&nbsp;&nbsp;潜孔钻机</option>
					<option value="0703">&nbsp;&nbsp;&nbsp;&nbsp;打桩机</option>
					<option value="0704">&nbsp;&nbsp;&nbsp;&nbsp;水平定向钻</option>
					<option value="0705">&nbsp;&nbsp;&nbsp;&nbsp;连续墙抓斗</option>
					<option value="0706">&nbsp;&nbsp;&nbsp;&nbsp;架桥机</option>
					<option value="0707">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="09">破碎设备</option>
					<option value="0901">&nbsp;&nbsp;&nbsp;&nbsp;破碎锤</option>
                    <option value="0902">&nbsp;&nbsp;&nbsp;&nbsp;液压剪</option>
					<option value="0903">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="08">其它机械</option>
                  </select><input type="hidden" name="zd_categoryname" id="zd_categoryname">
        <span class="list_left_title">品牌：</span>
		<select name="zd_brand" id="zd_brand">
                    <option value=""> --请选择品牌-- </option>
					<option value="174">卡特彼勒</option>
					<option value="175">沃尔沃</option>
					<option value="182">小松</option>
					<option value="214">维特根</option>
					<option value="192">斗山</option>
					<option value="209">徐工</option>
					<option value="133">三一</option>
					<option value="134">中联</option>
					<option value="212">戴纳派克</option>
					<option value="144">山推</option>
					<option value="ygsl">英格索兰</option>
					<option value="137">临工</option>
					<option value="139">厦工</option>
					<option value="136">柳工</option>
					<option value="184">日立</option>
					<option value="183">神钢</option>
					<option value="abg">ABG陕建</option>
					<option value="673">洛阳路通</option>
					<option value="142">山河智能</option>
					<option value="other">其它品牌</option>
                  </select>
       <input type="hidden" name="zd_brandname" id="zd_brandname">		</td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">型号：</td>
      <td class="list_cell_bg"><input name="zd_model" type="text" id="zd_model" size="10">
      发动机品牌：
      <input name="zd_engine_brand" id="zd_engine_brand" maxlength="28"></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">发动机品牌型号:</td>
      <td class="list_cell_bg"><input name="zd_engine" id="zd_engine" maxlength="28">项目开工时间：<input name="zd_project_startdate" id="zd_project_startdate" type="text"  value="<%=Common.getToday("yyyy-MM-dd", 0)%>" />预计完工时间：<input name="zd_project_enddate" id="zd_project_enddate" type="text"  readonly value="<%=Common.getToday("yyyy-MM-dd",3)%>" /></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">结算方式:</td>
      <td class="list_cell_bg"><select name="zd_accounts_style" id="zd_accounts_style">
                  <option value="1">按项目结算</option>
                  <option value="2">月结</option>
                 
                </select>是否配操作手:<input type="radio" id="zd_is_operater" name="zd_is_operater"
												value="1" >
                  是
                  <input type="radio" id="zd_is_operater" name="zd_is_operater"
				 								value="0" checked="checked">
                  否</td>
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
        <input type="radio" id="zd_place" name="zd_place" value="0" checked="checked">
国内
<input type="radio" id="zd_place" name="zd_place" value="1">
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
      <td align="right" nowrap class="list_left_title">租赁价格：</td>
      <td class="list_cell_bg"><input name="zd_rent_price" type="text" id="zd_rent_price" size="5" maxlength="5">
      <select name="zd_rent_price_style" id="zd_rent_price_style">
                    <option value="元/小时">元/小时</option>
                    <option value="元/月">元/月</option>
                  </select> <span class="list_left_title">发布日期：
      <input type="text" id="zd_pubdate" name="zd_pubdate" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" size="20" maxlength="20"  readonly="true" />
      <input name="zd_extradate" type="hidden" id="zd_extradate">
      </span></td>
    </tr>
    <tr>
      <td rowspan="2" align="right" nowrap class="list_left_title">运输与发票：</td>
      <td class="list_cell_bg"><input type="radio" name="zd_original_purpose" id="zd_original_purpose" value="1">
                  供货商提供运输&nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="radio" name="zd_original_purpose" id="zd_original_purpose" value="2">
                  买方自行运输&nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="radio" name="zd_original_purpose" id="zd_original_purpose" value="3">
                  协商解决运输</td>
    </tr>
    <tr>
      <td class="list_cell_bg"><input type="radio" name="zd_appearance" id="zd_appearance" value="1">
                  不提供发票&nbsp;&nbsp;
                  <input type="radio" name="zd_appearance" id="zd_appearance" value="2">
                  提供发票&nbsp;&nbsp;</td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><span class="list_cell_bg">当前状态：</span></td>
      <td class="list_cell_bg"><span class="list_left_title">
        <input type="radio" id="radio" name="zd_rent_state" value="1" checked="checked">
闲置
<input type="radio" id="radio" name="zd_rent_state" value="2">
施工中 </span></td></tr>
     <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布状态：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="0">
        否 <span class="list_left_title">销售状态：
        <input type="radio" id="zd_is_sale" name="zd_is_sale" value="1" checked="checked">
是
<input type="radio" id="zd_is_sale" name="zd_is_sale" value="0">
否 </span></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">推荐状态：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_recom" name="zd_is_recom" value="0" checked="checked">
      否
        <input type="radio" id="zd_is_recom" name="zd_is_recom" value="1">
		首页推荐 
		<input type="radio" id="zd_is_recom" name="zd_is_recom" value="2">
		设备列表推荐        </td>
    </tr>	
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">备注：</td>
      <td height="22" class="list_cell_bg"><FCK:editor instanceName="zd_repair_record" toolbarSet="simple" width="93%" height="280">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor>
        <font color="#FF0000">*</font></td>
    </tr>
	    <tr>
      <td height="22" align="right" nowrap class="list_left_title">整机外观前方：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img1" type="text" id="zd_img1" size="50" maxlength="40">
        <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img1','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">整机外观后方：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img2" type="text" id="zd_img2" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img2','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">整机铭牌照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img3" type="text" id="zd_img3" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img3','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">驾驶室外观照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img4" type="text" id="zd_img4" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img4','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">驾驶室内部照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img5" type="text" id="zd_img5" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img5','upload',480,150)"></td>
    </tr>
  <!--  <tr>
      <td height="22" align="right" nowrap class="list_left_title">左侧后履带（轮胎）照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img6" type="text" id="zd_img6" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img6','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">右侧前履带（轮胎）照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img7" type="text" id="zd_img7" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img7','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">右侧后履带（轮胎）照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img8" type="text" id="zd_img8" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img8','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">整机铭牌照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img9" type="text" id="zd_img9" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img9','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发动机外观照：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img10" type="text" id="zd_img10" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img10','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发动机铭牌照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img11" type="text" id="zd_img11" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img11','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">液压泵（马达、管路）照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img12" type="text" id="zd_img12" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img12','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">电路控制箱照片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img13" type="text" id="zd_img13" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img13','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">作业装置照片（1）：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img14" type="text" id="zd_img14" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img14','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">作业装置照片（2）：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img15" type="text" id="zd_img15" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img15','upload',480,150)"></td>
    </tr>
	    <tr>
      <td height="22" align="right" nowrap class="list_left_title">作业装置照片（3）：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img16" type="text" id="zd_img16" size="50" maxlength="40">
          <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img16','upload',480,150)"></td>
    </tr>
	    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">作业装置照片（4）：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img17" type="text" id="zd_img17" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img17','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">驾驶室外观照片：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img18" type="text" id="zd_img18" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img18','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">驾驶室内部操纵杆照片：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img19" type="text" id="zd_img19" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img19','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">驾驶室内部仪表盘照片：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img20" type="text" id="zd_img20" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img20','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">驾驶室内部工作时数照片：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img21" type="text" id="zd_img21" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img21','upload',480,150)"></td>
    </tr>
		    <tr>
	      <td height="22" align="right" nowrap class="list_left_title">驾驶室内部座椅照片：</td>
	      <td height="22" class="list_cell_bg"><input name="zd_img22" type="text" id="zd_img22" size="50" maxlength="40">
            <input name="selectimg3" type="button" class="form_button" id="selectimg3" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img22','upload',480,150)"></td>
    </tr>
	
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">竞拍编号：</td>
      <td height="22" class="list_cell_bg"><input name="zd_auction_no" type="text" id="zd_auction_no" size="20" maxlength="20" ></td>
    </tr>
	-->
    <tr >
      <td height="30" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
		  <input name="zd_catalog_no" type="hidden" id="zd_catalog_no" value="700901">
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
}
%>
