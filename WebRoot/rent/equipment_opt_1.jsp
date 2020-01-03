<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include
	file="/manage/config.jsp"%>
	
	<%
 // 获得session判断用户的信息是否完善
 Map memberInfoMap = null ;
memberInfoMap = (HashMap)session.getAttribute("memberInfo") ;
String comp_name2 = Common.getFormatStr(memberInfoMap.get("comp_name")) ;
String comp_mobile_phone = Common.getFormatStr(memberInfoMap.get("comp_mobile_phone")) ;
String comp_mode = Common.getFormatStr(memberInfoMap.get("comp_mode")) ;
%>
<%
	//=====页面属性====
	String pagename = "equipment_opt.jsp";
	String mypy = "equipment";
	String titlename = "";
	//====得到参数====
	String myvalue = Common.getFormatStr(request
			.getParameter("myvalue"));
	String urlpath = "../rent/equipment_opt.jsp";
	if (!myvalue.equals("")) {
		urlpath = urlpath + "?myvalue="
				+ java.net.URLEncoder.encode(myvalue, "UTF-8");
		//需要编码 才能将加密后产生的特殊字符 例如：将 +  转码成 %2B
	}
	String mem_no ="",comp_name="",mem_flag="",mem_name="",rent_mode="",shopid="",per_qq="";
	HashMap memberInfo = new HashMap();
	if (session.getAttribute("memberInfo") != null) {
		memberInfo = (HashMap) session.getAttribute("memberInfo");
   mem_no         = Common.getFormatStr(String.valueOf(memberInfo.get("mem_no")));  //登陆账号
   comp_name      = Common.getFormatStr(String.valueOf(memberInfo.get("comp_name")));
   mem_name       = Common.getFormatStr(String.valueOf(memberInfo.get("mem_name")));
   mem_flag       = Common.getFormatInt(String.valueOf(memberInfo.get("mem_flag")));
   rent_mode      = Common.getFormatInt(String.valueOf(memberInfo.get("rent_mode")));
   shopid      = Common.getFormatInt(String.valueOf(memberInfo.get("id")));
   per_qq     = Common.getFormatStr(String.valueOf(memberInfo.get("per_qq")));
	}
try {//====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发布租赁设备信息</title>
  <link type="text/css" rel="stylesheet" href="/scripts/jBox/Skins/Blue/jbox.css"/>
<link href="/rent/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.7.2.min.js"></script>
<script src="../scripts/common.js" type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<!--弹出层  -->
<script type="text/javascript" src="/scripts/jBox/jquery.jBox-2.3.min.js"></script>
  <script type="text/javascript" src="/scripts/jBox/i18n/jquery.jBox-zh-CN.js"></script>

<% 
//检测用户是否完善了信息
if ("1".equals(userInfoFlag)) {
%>
<script type="text/javascript">
  	jQuery(function(){
	jQuery.jBox.prompt('发布信息前，请先完善您的个人资料，便于您的潜在客户及时联系到您！', '温馨提醒', 'info', { closed: function () {
	parent.window.location.href="/manage/memberinfo_new.jsp" ;
	 }});
	})
  </script>
<%}%>
  
<script>
 function refresh(){
  document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
 }
 //为多选框赋值
 var pubCount=0;
 function onloadAjax(){
      $.ajax({
		type: "POST",
		url: "../manage/countpub.jsp",
		data: "tablename=equipment&poolnum=4&mem_no=<%=mem_no%>&class_id=1",
		success: function(msg){ 
		      	pubCount = $.trim(msg);	
				document.getElementById("spanPubCount").innerText=pubCount;					
				if(pubCount>=10000){
				    //document.getElementById("warningId").color='red';		
					document.getElementById("submitId").disabled=true;				
					alert("您今天已发布了"+pubCount+"条租赁设备信息，已经达到最大发布数,自动跳转至列表页！");
					window.location.href="../rent/equipment_list.jsp?find_class=1";
				}
			} 
		});
	}
 
 function submityn(){ 
  	if(pubCount>=10000){
	        alert("您今天已发布了"+pubCount+"条租赁设备信息，已经达到最大发布数！");
			return false;
	}else if($("#zd_category").val()==""){
			alert("请选择设备类别！");
			$("#zd_category").focus();
			return false;	
	}else if($("#zd_brand").val()==""){
			alert("请选择品牌！");
			$("#zd_brand").focus();
			return false;	
	}else if($("#zd_model").val()==""){
			alert("请输入型号！");
			$("#zd_model").focus();
			return false;	
	}else if($("#zd_factorydate").val()==""){
	       alert("请选择设备出厂年份！");
			$("#zd_factorydate").focus();
			return false;	
	}else if($("#zd_province").val()==""){
	       alert("请选择省份！");
			$("#zd_province").focus();
			return false;	
	}else if($("#zd_city").val()==""){
	        alert("请选择城市！");
			$("#zd_city").focus();
			return false;	
	}else if($("#zd_img1").val()==""){
			alert("请上传整机外观前方照片！");
			$("#zd_img1").focus();
			return false;
	}
	$("#zd_brandname").val(document.getElementById("zd_brand").options[document.getElementById("zd_brand").selectedIndex].innerHTML);
	alert($("#zd_brandname").val());
	$("#zd_categoryname").val($("select[name='zd_category'] option[selected]").text().replaceAll("\u00a0",""));
	//===生成标题====
	$("#zd_title").val("出租"+$("#zd_factorydate").val()+"年产"+$("#zd_brandname").val()+$("#zd_model").val()+$('#zd_category option:selected').text().replaceAll("\u00a0",""));
	 document.theform.zd_pubdate.value=document.getElementById("pub_date_temp").value;
	 document.theform.zd_orderno.value="<%=Common.create21SUNOrderNo(1,mem_flag,0)%>";
	 document.theform.zd_orderno1.value="<%=Common.create21SUNOrderNo(1,mem_flag,1)%>";
	 
	document.theform.submit();
 }
 
function isNumeric(strNumber,obj) { 
	var objRegExp="";
	if(obj=="zd_workingtime"){
		objRegExp  = /^(\+|-)?(0|[1-9]\d*)(\.\d*[1-9])?$/; //不可以为小数
	}else if(obj=="price"){
		objRegExp  =  /^(\+|\-)?(\d)+(\.)?(\d)*$/; //可以为小数
	}	
	if(!objRegExp.test(strNumber.value)){
	    strNumber.value="";
	}
}
function dochange(param)
{if(param==1)
$("#id_project_time").hide();
else if(param==2)
$("#id_project_time").show();
}
 

</script>
<script  language="javascript">
function f_frameStyleResize(targObj)   
{   
  var   targWin   =   targObj.parent.document.all[targObj.name]; 
  if(targWin   !=   null)   
  {   
  var   HeightValue   =   targObj.document.body.scrollHeight   
  if(HeightValue   <100){HeightValue   =490}   //不小于540  
   targWin.height   =   HeightValue;
  }   
}  
function   f_iframeResize()   
{
  f_frameStyleResize(self);
}  
//window.onload=f_iframeResize;
//onloadAjax();
 </script>
 <style type="text/css">
 	div{
 		font-size:12px;
 	}
 </style>
</head>
<script src="../scripts/calendar.js"  type="text/javascript"></script>
<body>
<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
  <div class="loginlist_right">
    <div class="loginlist_right2"> <span class="mainyh">发布租赁设备信息</span> </div>
    <div class="loginlist_right1">
      <table>
        <tr>
          <td><table width="99%" border="0" align="center" class="tablezhuce">
              <tr>
                <td><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机。 <span class="red">*</span> 为必填项 <br />
                  <!--每天发布信息量最多只可以发布<font color="red"><b>10000</b></font>条，-->
                  您今天已经发布了<font color="green"><b><span id="spanPubCount"></span></b></font>条。<a href="../rent/equipment_list.jsp">返回管理租赁设备信息</a></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td valign="top"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" class="biaoge">
              <tr>
                <td colspan="4" class="biaoge_title"><strong>设备基本信息</strong></td>
              </tr>
              <tr>
                <td nowrap class="list_left_title"><strong><font color="#FF0000">*</font>类别：</strong> </td>
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
                    <option value="02">起重机系列</option>
					<option value="0201">&nbsp;&nbsp;&nbsp;&nbsp;塔吊</option>
                    <option value="0202">&nbsp;&nbsp;&nbsp;&nbsp;履带吊</option>
					<option value="0203">&nbsp;&nbsp;&nbsp;&nbsp;汽车吊</option>
					<option value="0204">&nbsp;&nbsp;&nbsp;&nbsp;龙门吊</option>
					<option value="0205">&nbsp;&nbsp;&nbsp;&nbsp;高空作业车</option>
					<option value="0207">&nbsp;&nbsp;&nbsp;&nbsp;叉车</option>
					<option value="0206">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="03">混凝土系列</option>
					<option value="0301">&nbsp;&nbsp;&nbsp;&nbsp;泵车</option>
                    <option value="0302">&nbsp;&nbsp;&nbsp;&nbsp;搅拌运输车</option>
					<option value="0303">&nbsp;&nbsp;&nbsp;&nbsp;搅拌站</option>
					<option value="0304">&nbsp;&nbsp;&nbsp;&nbsp;搅拌车</option>
					<option value="0305">&nbsp;&nbsp;&nbsp;&nbsp;拖泵</option>
					<option value="0306">&nbsp;&nbsp;&nbsp;&nbsp;其它</option>
					<option value="04">土石方系列</option>
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
                  </select>
                  <input type="hidden" name="zd_categoryname" id="zd_categoryname"></td>
                <td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>品牌：</strong> </td>
                <td height="22" class="list_cell_bg"><select name="zd_brand" id="zd_brand">
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
					<option value="jlg">美国JLG</option>
					<option value="other">其它品牌</option>
                  </select>
				  <input type="hidden" name="zd_brandname" id="zd_brandname">
				  				  </td>
              </tr>
              <tr>
                <td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>型号：</strong> </td>
                <td height="22" class="list_cell_bg"><input name="zd_model" id="zd_model" maxlength="28"></td>
                <td height="22" nowrap class="list_left_title"><strong>发动机品牌：</strong> </td>
                <td height="22" class="list_cell_bg"><input name="zd_engine_brand" id="zd_engine_brand" maxlength="28"></td>
              </tr>
              <tr>
                <td height="22" nowrap class="list_left_title"><strong>发动机品牌型号：</strong> </td>
                <td height="22" class="list_cell_bg"><input name="zd_engine" type="text" id="zd_engine" size="20"
												maxlength="10">                </td>
                <td height="22" nowrap class="list_left_title"><strong>当前状态：</strong> </td>
                <td height="22" class="list_cell_bg"><input type="radio" id="radio" name="zd_rent_state"
												value="1" checked="checked" onClick="dochange(1);">
                  待租
                    <input type="radio" id="radio" name="zd_rent_state" value="2" onClick="dochange(2);">
                  施工中 </td>
              </tr>
              <tr style='display:none;' id="id_project_time">
                <td height="22" nowrap class="list_left_title"><strong>项目开工时间：</strong></td>
                <td height="22" class="list_cell_bg"><input name="zd_project_startdate" id="zd_project_startdate" type="text"  value="<%=Common.getToday("yyyy-MM-dd", 0)%>" /></td>
                <td height="22" nowrap class="list_left_title"><strong>预计完工时间：</strong></td>
                <td height="22" class="list_cell_bg"><input name="zd_project_enddate" id="zd_project_enddate" type="text"  value="<%=Common.getToday("yyyy-MM-dd",3)%>" /></td>
              </tr>
              <tr>
                <td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>出厂年份：</strong> </td>
                <td height="22" class="list_cell_bg"><select name="zd_factorydate" id="zd_factorydate">
                    <option value=""> --请选择年份-- </option>
					<option value="2011"> 2011年 </option>
                    <option value="2010"> 2010年 </option>
                    <option value="2009"> 2009年 </option>
                    <option value="2008"> 2008年 </option>
                    <option value="2007"> 2007年 </option>
                    <option value="2006"> 2006年 </option>
                    <option value="2005"> 2005年 </option>
                    <option value="2004"> 2004年 </option>
                    <option value="2003"> 2003年 </option>
                    <option value="2002"> 2002年 </option>
                    <option value="2001"> 2001年 </option>
                    <option value="2000"> 2000年 </option>
                    <option value="1999"> 1999年 </option>
                    <option value="1998"> 1998年 </option>
                    <option value="1997"> 1997年 </option>
                    <option value="1996"> 1996年 </option>
                    <option value="1995"> 1995年 </option>
                    <option value="1994"> 1994年 </option>
                    <option value="1993"> 1993年 </option>
                    <option value="1992"> 1992年 </option>
                    <option value="1991"> 1991年 </option>
                    <option value="1990"> 1990年 </option>
                  </select>                </td>
                <td height="22" nowrap class="list_left_title"><strong>工作时间：</strong> </td>
                <td height="22" class="list_cell_bg"><input name="zd_workingtime" type="text" id="zd_workingtime"
												size="5" maxlength="30"
												onKeyUp="isNumeric(this,'zd_workingtime');">
                  (小时) </td>
              </tr>
              <tr>
                <td width="20%" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>产地：</strong> </td>
                <td width="26%" class="list_cell_bg"><input type="radio" name="zd_place" checked="checked" id="zd_place" value="0">
                  国产 &nbsp;&nbsp;
                  <input type="radio" name="zd_place"  id="zd_place" value="1">
                  进口 &nbsp;&nbsp; </td>
                <td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>所在区域：</strong> </td>
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
          <option value="">选择城市</option>
        </select></td>
              </tr>
              <tr>
                <td height="22" nowrap class="list_left_title"><strong>出租价格：</strong> </td>
                <td height="22" class="list_cell_bg">￥
                  <input name="zd_rent_price" type="text" id="zd_rent_price" size="5"
												maxlength="30" onKeyUp="isNumeric(this,'price');">
                  <select name="zd_rent_price_style" id="zd_rent_price_style">
                    <option value="元/小时">元/小时</option>
                    <option value="元/月">元/月</option>
                  </select></td>
                <td height="22" nowrap class="list_left_title"><strong>结算方式：</strong></td>
                <td height="22" class="list_cell_bg"><select name="zd_accounts_style" id="zd_accounts_style">
                  <option value="1">按项目结算</option>
                  <option value="2">月结</option>
                </select></td>
              </tr>
              <tr>
                <td height="22" nowrap class="list_left_title"><strong>发布日期：</strong></td>
                <td height="22" class="list_cell_bg"><input name="zd_pubdate" id="zd_pubdate" type="text"  readonly value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss", 0)%>" /></td>
                <td height="22" nowrap class="list_left_title"><strong>是否配操作手：</strong></td>
                <td height="22" class="list_cell_bg" width="500"><input type="radio" id="zd_is_operater" name="zd_is_operater"
												value="1" >
                  是
                  <input type="radio" id="zd_is_operater" name="zd_is_operater"
				 								value="0" checked="checked">
                  否 </td>
              </tr>
              <tr>
                <td height="22" nowrap class="list_left_title" rowspan="2"><strong>运输与发票：</strong> </td>
                <td height="2" class="list_cell_bg" colspan="3"><input type="radio" name="zd_original_purpose" id="zd_original_purpose" value="1">
                  供货商提供运输&nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="radio" name="zd_original_purpose" id="zd_original_purpose" value="2">
                  买方自行运输&nbsp;&nbsp;&nbsp;&nbsp;
                  <input type="radio" name="zd_original_purpose" id="zd_original_purpose" value="3">
                  协商解决运输</td>
              </tr>
              <tr>
                <td height="22" class="list_cell_bg" colspan="3"><input type="radio" name="zd_appearance" id="zd_appearance" value="1">
                  不提供发票&nbsp;&nbsp;
                  <input type="radio" name="zd_appearance" id="zd_appearance" value="2">
                  提供发票&nbsp;&nbsp;</td>
              </tr>
              <tr>
                <td colspan="4" class="biaoge_title"><strong>设备图片、详细描述</strong></td>
              </tr>
              <tr id="showimg1" style="display:''">
                <td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>整机外观前方：</strong> </td>
                <td height="22" class="list_cell_bg" colspan="3"><input name="zd_img1" id="zd_img1" type="hidden" value="" />
                  <input name="zd_img1_1" id="zd_img1_1" type="hidden" value="" />
                  <span id="txt_zd_img1"></span><span id="ifr_zd_img1">
                  <iframe id="ifr2_zd_img1" scrolling="no" frameborder="0" width="100%" height="28"
													src="http://resource.21-sun.com/web_upload_files_for_smallpic.jsp?nurl=<%=request.getServerName() + ":"
						+ request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img1&smallpic=zd_img1_1"></iframe>
                  </span>&nbsp;&nbsp;注：图片最大不超过200K,大小625*456</td>
              </tr>
              <tr id="showimg2">
                <td height="22" nowrap class="list_left_title"><strong>整机外观后方：</strong> </td>
                <td height="22" class="list_cell_bg" colspan="3"><input name="zd_img2" id="zd_img2" type="hidden" value="" />
                  <span id="txt_zd_img2"></span><span id="ifr_zd_img2">
                  <iframe
													id="ifr2_zd_img2" scrolling="no" frameborder="0"
													width="100%" height="28"
													src="http://resource.21-sun.com/web_upload_files_for_smallpic.jsp?nurl=<%=request.getServerName() + ":"
						+ request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img2"></iframe>
                  </span> </td>
              </tr>
              <tr id="showimg3">
                <td height="22" nowrap class="list_left_title"><strong>整机铭牌照片：</strong> </td>
                <td height="22" class="list_cell_bg" colspan="3"><input name="zd_img3" id="zd_img3" type="hidden" value="" />
                  <span id="txt_zd_img3"></span><span id="ifr_zd_img3">
                  <iframe
													id="ifr2_zd_img3" scrolling="no" frameborder="0"
													width="100%" height="28"
													src="http://resource.21-sun.com/web_upload_files_for_smallpic.jsp?nurl=<%=request.getServerName() + ":"
						+ request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img3"></iframe>
                  </span> </td>
              </tr>
              <tr id="showimg4">
                <td height="22" nowrap class="list_left_title"><strong>驾驶室外观照片：</strong> </td>
                <td height="22" class="list_cell_bg" colspan="3"><input name="zd_img4" id="zd_img4" type="hidden" value="" />
                  <span id="txt_zd_img4"></span><span id="ifr_zd_img4">
                  <iframe
													id="ifr2_zd_img4" scrolling="no" frameborder="0"
													width="100%" height="28"
													src="http://resource.21-sun.com/web_upload_files_for_smallpic.jsp?nurl=<%=request.getServerName() + ":"
						+ request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img4"></iframe>
                  </span> </td>
              </tr>
              <tr id="showimg5">
                <td height="22" nowrap class="list_left_title"><strong>驾驶室内部照片：</strong> </td>
                <td height="22" class="list_cell_bg" colspan="3"><input name="zd_img5" id="zd_img5" type="hidden" value="" />
                  <span id="txt_zd_img5"></span><span id="ifr_zd_img5">
                  <iframe
													id="ifr2_zd_img5" scrolling="no" frameborder="0"
													width="100%" height="28"
													src="http://resource.21-sun.com/web_upload_files_for_smallpic.jsp?nurl=<%=request.getServerName() + ":"
						+ request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_img5"></iframe>
                  </span> </td>
              </tr>
              
              <tr>
                <td height="22" nowrap class="list_left_title"><strong>详细说明：</strong> </td>
                <td height="22" class="list_cell_bg" colspan="3"><textarea name="zd_repair_record" cols="50" rows="8" id="zd_repair_record" onKeyUp="if((this.value).length>300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}" style="overflow-y:scroll;"></textarea>                </td>
              </tr>
              <tr>
                <td height="22" nowrap class="list_left_title"><strong>验 证 码：</strong> </td>
                <td height="22" class="list_cell_bg" colspan="3"><input type="text" id="rand" name="rand" value="" size="20"
												maxlength="10" class="moren" />
                  <img src="/webadmin/authImgServlet" name="authImg"
												align="absmiddle" id="authImg"
												title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();" />
                  <input name="zd_title" type="hidden" id="zd_title" size="50"
												maxlength="50"></td>
              </tr>
              <tr>
                <td nowrap="nowrap" class="right">&nbsp;</td>
                <td class="right" colspan="3"><input type="button" id="submitId" name="Submit" value="发 布" class="tijiao" style="cursor: pointer" onClick="submityn()" />                </td>
              </tr>
            </table>
            <input name="zd_id" type="hidden" id="zd_id" value="0">
            <input name="mypy" type="hidden" id="mypy"
									value="<%=Common.encryptionByDES(mypy)%>">
            <input name="zd_mem_no" type="hidden" id="zd_mem_no"
									value="<%=mem_no%>">
            <input name="zd_add_date" type="hidden" id="zd_add_date"
									value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss", 0)%>">
            <input name="zd_add_ip" type="hidden" id="zd_add_ip"
									value="<%=Common.getRemoteAddr(request,1)%>">
            <input name="myvalue" type="hidden" id="myvalue"
									value='<%=myvalue%>'>
            <input name="urlpath" type="hidden" id="urlpath"
									value="<%=urlpath%>">
            <input name="zd_is_pub" type="hidden" id="zd_is_pub" value="1">
            <input name="zd_clicked" type="hidden" id="zd_clicked" value="0">
            <input name="zd_mem_name" type="hidden" id="zd_mem_name"value="<%=mem_name%>">
			<input name="zd_comp_name"  type="hidden" id="zd_comp_name"  value="<%=comp_name%>">
			<input name="zd_rent_mode" type="hidden" id="zd_rent_mode" value="<%=rent_mode%>">
		    <input name="zd_shopid" type="hidden" id="zd_shopid" value="<%=shopid%>">
		     <input name="zd_per_qq" type="hidden" id="zd_per_qq" value="<%=per_qq%>">
			
            <input name="pub_date_temp" type="hidden" id="pub_date_temp" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>" />
            <input name="zd_mem_flag" type="hidden" id="zd_mem_flag" value="<%=mem_flag%>" />
			<input name="zd_is_recom" type="hidden" id="zd_is_recom" value="0" />
			<input name="zd_orderno" type="hidden" id="zd_orderno" />
			<input name="zd_orderno1" type="hidden" id="zd_orderno1" />
          </td>
        </tr>
        <tr>
          <td><table width="98%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td height="10"></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </div>
  </div>
</form>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1
			scrolling="no" style="visibility: hidden"></iframe>
<script language="javascript">

function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
refresh();
function set_formxx(val){
	if(val!=null && val!=""){
	   $('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val)+"&classId=1");	
	}
}
<%
	if(!myvalue.equals("")){
		out.print("set_formxx(\""+Common.decryptionByDES(myvalue)+"\");");
	}
%>
</script>
<script  language="javascript">
onloadAjax();
 </script>
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		titlename = null;
		urlpath = null;
	}
%>
