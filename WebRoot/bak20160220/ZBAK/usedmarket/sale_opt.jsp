<%@ page language="java" import="java.util.*,com.jerehnet.cmbol.database.*,java.sql.Connection,java.sql.ResultSet,com.jerehnet.util.*" pageEncoding="UTF-8"%><%
	PoolManager usedPool = new PoolManager(4);
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	Connection connection = null;
	ResultSet she_bei_lei_bie = null;
	ResultSet she_bei_pin_pai = null;
	ResultSet she_bei = null;
	//远程资源域名最后不带 / 
	String resourceDomain = "http://resource.21-sun.com";
	String uuid = Common.getFormatStr(request.getParameter("uuid"));
	try{
		connection = usedPool.getConnection();
		she_bei_lei_bie = DataManager.executeQuery(connection," select id,category_name from used_category ");
		she_bei_pin_pai = DataManager.executeQuery(connection," select id,(letter+' '+brand_name) as brand_name from used_brand order by letter ");
		if(!"".equals(uuid)){
			she_bei = DataManager.executeQuery(connection," select * from used_equipment where uuid = '"+uuid+"' ");
		}
		String category_id = "";
		String brand_id = "";
		String model = "";
		String car_no = "";
		String engine = "";
		String factorydate = "";
		String source = "";
		String place = "";
		String workingtime = "";
		String province = "";
		String city = "";
		String price = "";
		String tons = "";
		String logistics = "";
		String checkbook = "";
		String cap_desc = "";
		String elect_desc = "";
		String power_desc = "";
		String hyd_desc = "";
		String vision_desc = "";
		String repairfile = "";
		String detail = "";
		if(null!=she_bei){
			she_bei.next();
			category_id = Common.getFormatStr(she_bei.getString("category_id"));
			brand_id = Common.getFormatStr(she_bei.getString("brand_id"));
			model = Common.getFormatStr(she_bei.getString("model"));
			car_no = Common.getFormatStr(she_bei.getString("car_no"));
			engine = Common.getFormatStr(she_bei.getString("engine"));
			workingtime = Common.getFormatStr(she_bei.getString("workingtime"));
			factorydate = Common.getFormatStr(she_bei.getString("factorydate"));
			source = Common.getFormatStr(she_bei.getString("source"));
			province = Common.getFormatStr(she_bei.getString("province"));
			city = Common.getFormatStr(she_bei.getString("city"));
			price = Common.getFormatStr(she_bei.getString("price"));
			tons = Common.getFormatStr(she_bei.getString("tons"));
			logistics = Common.getFormatStr(she_bei.getString("logistics"));
			checkbook = Common.getFormatStr(she_bei.getString("checkbook"));
			cap_desc = Common.getFormatStr(she_bei.getString("cap_desc"));
			elect_desc = Common.getFormatStr(she_bei.getString("elect_desc"));
			power_desc = Common.getFormatStr(she_bei.getString("power_desc"));
			hyd_desc = Common.getFormatStr(she_bei.getString("hyd_desc"));
			vision_desc = Common.getFormatStr(she_bei.getString("vision_desc"));
			repairfile = Common.getFormatStr(she_bei.getString("repairfile"));
			detail = Common.getFormatStr(she_bei.getString("detail"));
		}
		String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag"));
		Integer mostCount = 0;
		if("1014".equals(mem_flag)){//认证经销商
			mostCount = 20;
		}else if("1008".equals(mem_flag)){//品牌厂商
			mostCount = 100;
		}else if("1007".equals(mem_flag)){//品牌代理商
			mostCount = -1;//不限制
		}else{
			mostCount = -2;
		}
		Integer alreadySend = 0;
		ResultSet rs_already_send = DataManager.executeQuery(connection," select count(*) as counts from used_equipment where mem_no = '"+memberInfo.get("mem_no")+"' ");
		if(null!=rs_already_send&&rs_already_send.next()){
			alreadySend = rs_already_send.getInt("counts");
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>二手设备发布</title>
	<link href="/usedmarket/style/style.css" rel="stylesheet" type="text/css" />
	<link type="text/css" rel="stylesheet" href="/scripts/jBox/Skins/Blue/jbox.css" />
	<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
	<script src="/scripts/jquery-1.4.1.min.js"></script>
	<style type="text/css">
		#upload{
			background-image:url('/plugin/upload/baidu/upload.png');
			border:1px solid #ccc;
			width:100px;
			height:28px;
		}
	</style>
</head>
<body>
 <form action="tools/action_sale.jsp" method="post" name="theform" id="theform">
<div class="loginlist_right" style="width: 100%;">
  <div class="loginlist_right2"> <span class="mainyh">发布二手设备信息</span><span style="font-size:14px; margin-left:30px;"></span> </div>
  <div class="loginlist_right1" style="width: 100%;">
    <table width="100%">
      <tr>
        <td>友情提示：</b><font color="#CC0000">请您详细、完整的填写以下表单，内容详细可让您获得更多商机。 标红选项为必填项</font><br />
		</td>
      </tr>
      <tr>
        <td valign="top">
        <table width="100%" border="0" align="center" class="biaoge"  style="border: none;">
            <tr>
              <td colspan="4" class="biaoge_title"><strong>1、基本信息</strong></td>
            </tr>
            <tr>
              <td class="list_left_title">
              <strong><font color="#FF0000">*</font>请选择设备类别：</strong> </td>
              <td class="list_cell_bg">
               <select name="zd_category_id" id="zd_category_id"  style="width: 138px; height: 24px;" dataType="Require" msg="请选择设备类别！">
                  <option value=""> --请选择类别-- </option>
                  <%
                  while(null!=she_bei_lei_bie&&she_bei_lei_bie.next()){
                	  %>
                <option value="<%=Common.getFormatStr(she_bei_lei_bie.getString("id")) %>"><%=Common.getFormatStr(she_bei_lei_bie.getString("category_name")) %></option>
                	  <%
                  }
                  %>
                </select>
                <script type="text/javascript">
                	jQuery("#zd_category_id").val("<%=category_id %>");
                </script>
              </td>
			  <td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>品牌(<font color="#FF0000">请先选择类别</font>)：</strong> </td>
              <td height="22" class="list_cell_bg">
              <select name="zd_brand_id" id="zd_brand_id"  style="width: 138px; height: 24px;" dataType="Require" msg="请选择品牌！">
                  <option value=""> --请选择品牌-- </option>
                  <%
                  	while(null!=she_bei_pin_pai&&she_bei_pin_pai.next()){
                  		%>
                  <option value="<%=Common.getFormatStr(she_bei_pin_pai.getString("id")) %>"><%=Common.getFormatStr(she_bei_pin_pai.getString("brand_name")) %></option>
                  		<%                  		
                  	}
                  %>
                </select>
                <script type="text/javascript">
                	jQuery("#zd_brand_id").val("<%=brand_id %>");
                </script>
              </td>
            </tr>
            <tr>
              <td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>设备型号：</strong> </td>
              <td height="22" class="list_cell_bg">
                  <input name="zd_model" id="zd_model" style="width: 136px;height: 20px;" type="text"  dataType="Require" msg="请输入设备型号！" value="<%=model %>" />
                <font color="red" id="model_font">(如：330D)</font> </td>
				  <td height="22" nowrap class="list_left_title">&nbsp;&nbsp;<strong>设备序列号（车号）：</strong> </td>
                  <td height="22" class="list_cell_bg">
                  <input name="zd_car_no" style="width: 136px;height: 20px;" type="text" id="zd_car_no" value="<%=car_no %>" />
                  </td>
            </tr>
            <tr>
              <td height="22" nowrap class="list_left_title">&nbsp;&nbsp;<strong>发动机品牌型号：</strong> </td>
              <td height="22" class="list_cell_bg">
              	<input style="width: 136px;height: 20px;" name="zd_engine" type="text" id="zd_engine" value="<%=engine %>" />
              </td>
			  <td height="22" nowrap class="list_left_title">&nbsp;&nbsp;<strong>工作时间：</strong> </td>
              <td height="22" class="list_cell_bg">
                <input name="zd_workingtime" style="width: 136px;height: 20px;" type="text" id="zd_workingtime" size="5" maxlength="30" value="<%=workingtime %>" />
                <span style="color: red;"> (小时) </span>
               </td>
            </tr>
            <tr>
              <td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>出厂年份：</strong> </td>
              <td height="22" class="list_cell_bg">
              <select name="zd_factorydate" id="zd_factorydate"   style="width: 138px; height: 24px;" dataType="Require" msg="请选择年份！">
                  <option value=""> --请选择年份-- </option>
                  <%
                  int bigYear = Calendar.getInstance().get(Calendar.YEAR);
                  for(int i=bigYear;i>1989;i--){
                	  %>
               	  <option value='<%=i %>'><%=i %>年</option>
                	  <%
                  }
                  %>
                </select>
                <script type="text/javascript">
                	jQuery("#zd_factorydate").val("<%=factorydate %>");
                </script>
              </td>
			  <td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>设备来源：</strong> </td>
              <td height="22" class="list_cell_bg">
              <select name="zd_source" id="zd_source"  style="width: 138px; height: 24px;" dataType="Require" msg="请选择设备来源！">
			  		<option value="">--请选择设备来源--</option>
				  	<option value='1'>演示样机</option>
					<option value='2'>设备存货</option>
					<option value='3'>租赁机队</option>
					<option value='4'>以旧换新</option>
					<option value='5'>市场收购</option>
					<option value='6'>委托销售</option>
					<option value='7'>其他</option>
                </select>
                <script type="text/javascript">
                	jQuery("#zd_source").val("<%=source %>");
                </script>
              </td>
            </tr>
            <tr>
              <td width="20%" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>设备产地：</strong> </td>
              <td width="26%" class="list_cell_bg">
	               <input type="radio" name="zd_place" checked="checked" id="zd_place" value="0" />
	                国产 &nbsp;&nbsp;
	                <input type="radio" name="zd_place"  id="zd_place" value="1" />
	                进口 &nbsp;&nbsp; 
                	<script type="text/javascript">
                		jQuery("#zd_place").val("<%=place %>");
                	</script>
                </td>
				<td height="22" nowrap class="list_left_title"><strong><font color="#FF0000">*</font>所在区域：</strong></td>
              <td height="22" class="list_cell_bg">
                <select name="zd_province" id="zd_province" style="width: 68px; height: 24px;" onchange="getCity(this,'zd_city')" class="validate-selection" dataType="Require" msg="请选择所在区域！"></select>
                <select name="zd_city" id="zd_city" style="width: 68px; height: 24px;"></select>
                <script type="text/javascript">
                	jQuery(function(){
                		jQuery("#zd_province").val("<%=province %>");
	                	jQuery("#zd_province").change();
	                	jQuery("#zd_city").val("<%=city %>");
                	});
                </script>
              </td>
            </tr>
			<tr>
              <td height="22" nowrap class="list_left_title">&nbsp;&nbsp;<strong>设备价格(￥)：</strong> </td>
              <td height="22" class="list_cell_bg">
                <input name="zd_price" type="text" style="width: 136px;height: 20px;" id="zd_price" value="<%=price %>" />
                <span style="color: red;">
               	 (万,不填为面议) 
                </span>
                </td>
              <td height="22" nowrap class="list_left_title">&nbsp;&nbsp;<strong>设备吨位：</strong> </td>
              <td height="2" class="list_cell_bg">
				<select name="zd_tons" id="zd_tons"  style="width: 138px; height: 24px;">
					<option value="0">--请选择设备吨位--</option>
					<option value='1'>5吨以下</option>
					<option value='2'>5-8吨</option>
					<option value='3'>8-15吨</option>
					<option value='4'>15-25吨</option>
					<option value='5'>25吨以上</option>
				</select>
				<script type="text/javascript">
                	jQuery("#zd_tons").val("<%=tons %>");
                </script>
			  </td>
            </tr>
            
            <tr>
              <td colspan="4" class="biaoge_title"><strong>2、详细信息</strong></td>
            </tr>
            
            <tr>
              <td height="22" class="list_left_title"><strong>运输情况：</strong></td>
              <td height="2" class="list_cell_bg">
              <select name="zd_logistics" id="zd_logistics"  style="width: 208px; height: 24px;" dataType="Require" msg="请选择运输方式！">
				  	<option value='1'>供货商提供运输</option>
					<option value='2'>买方自行运输</option>
					<option value='3'>协商解决运输</option>
                </select>
                
              </td>
              <td><strong>发票情况：</strong></td>
              <td>
              	 <select name="zd_checkbook" id="zd_checkbook"  style="width: 208px; height: 24px;" dataType="Require" msg="请选择是否提供发票！">
					<option value='1'>不提供发票</option>
					<option value='2'>提供发票</option>
                </select>
              	<script type="text/javascript">
                	jQuery("#zd_logistics").val("<%=logistics %>");
                	jQuery("#zd_checkbook").val("<%=checkbook %>");
                </script>
              </td>
            </tr>
            <tr>
              <td height="22" class="list_left_title"><strong>驾驶室情况：</strong> </td>
              <td height="2" class="list_cell_bg">
              <select name="zd_cap_desc" id="zd_cap_desc" style="width: 208px; height: 24px;" dataType="Require" msg="请选择设备的驾驶室情况！">
			  	<option value='1'>除成色显旧外部件基本完好</option>
				<option value='2'>有轻微变形或破损需要修理，不影响使用</option>
				<option value='3'>有较大变形和破损，需要换件或修理后使用</option>
				<option value='4'>整体总成部件很旧了，需要更换整个总成</option>
               </select>
               <script type="text/javascript">
                	jQuery("#zd_cap_desc").val("<%=cap_desc %>");
               </script>
              </td>
              <td height="22" class="list_left_title"><strong>电器系统情况：</strong> </td>
              <td height="2" class="list_cell_bg">
              <select name="zd_elect_desc" id="zd_elect_desc" style="width: 208px; height: 24px;" dataType="Require" msg="请选择设备的电器系统情况！">
			  	<option value='1'>线路、电气工作部件一切良好</option>
				<option value='2'>线路或工作部件有过更换，目前运行正常</option>
				<option value='3'>部分线路和工作部件有故障不能工作</option>
				<option value='4'>线路与工作部件损耗严重，需要更换</option>
               </select>
               <script type="text/javascript">
                	jQuery("#zd_elect_desc").val("<%=elect_desc %>");
               </script>
              </td>
			 </tr>
			<tr>
              <td height="22" class="list_left_title"><strong>动力系统情况：</strong> </td>
              <td height="2" class="list_cell_bg">
              <select name="zd_power_desc" id="zd_power_desc" style="width: 208px; height: 24px;" dataType="Require" msg="请选择动力系统情况！">
			  	<option value='1'>原厂发动机，除易损件外没换过其他部件</option>
				<option value='2'>原厂发动机，核心部件有过修理</option>
				<option value='3'>非原厂发动机，可正常使用</option>
				<option value='4'>发动机需要修理或更换</option>
              </select>
              <script type="text/javascript">
                	jQuery("#zd_power_desc").val("<%=power_desc %>");
               </script>
              </td>
              <td height="22" class="list_left_title"><strong>液压系统情况：</strong> </td>
              <td height="2" class="list_cell_bg">
              <select name="zd_hyd_desc" id="zd_hyd_desc" style="width: 208px; height: 24px;" dataType="Require" msg="请选择液压系统情况！">
			  	<option value='1'>核心部件等没有更换过，工作正常</option>
				<option value='2'>有轻微漏油、轻微刮伤等，工作正常</option>
				<option value='3'>可能有硬伤需要修理或更换</option>
                </select>
                <script type="text/javascript">
                	jQuery("#zd_hyd_desc").val("<%=hyd_desc %>");
               </script>
              </td>
            </tr>
			<tr>
              <td height="22" class="list_left_title"><strong>设备外观漆面：</strong> </td>
              <td height="2" class="list_cell_bg">
              <select name="zd_vision_desc" id="zd_vision_desc" style="width: 208px; height: 24px;" dataType="Require" msg="请选择设备外观漆面！">
			  	<option value='1'>原配漆磨损较轻</option>
				<option value='2'>原配漆，磨损较重</option>
				<option value='3'>重新喷过原厂漆</option>
				<option value='4'>重新喷过其他品牌漆</option>
                </select>
                <script type="text/javascript">
                	jQuery("#zd_vision_desc").val("<%=vision_desc %>");
               </script>
              </td>
              <td height="22" nowrap class="list_left_title"><strong>上传维修文件：</strong> </td>
              <td>
              	<input name="zd_repairfile" id="zd_repairfile" type="hidden" value="<%=repairfile %>"/>
				<div id="repairfile" style="float:left;"></div>
				<div id="repairfile_tip" style="float:left; margin-left: 5px;"></div>
				<div style="clear:left;"></div>
			  </td>
            </tr>
			<tr>
              <td height="22" nowrap class="list_left_title">&nbsp;&nbsp;<strong>详细说明：</strong> </td>
              <td height="22" colspan="3"><textarea name="zd_detail" id="zd_detail" style="overflow-y:scroll; background: none; width: 590px; height: 120px;"><%=detail %></textarea>
              </td>
            </tr>
            <tr>
              <td colspan="4" class="biaoge_title">
              	<div style="float:left;"><strong>3、设备图片</strong><span style="margin-left: 5px; font-size:12px;">上传完毕后单击图片进行移除操作！</span></div>
              	<div style="float:right; margin: 5px 3px 0 0;" id="equi_img"></div>
              	<div style="clear:left;"></div>
              </td>
            </tr>
			<tr>
				<td colspan="4">
					<div id="equi_imgs" style="width: 730px; border: none; height: 120px; overflow-x: hidden; overflow-y: scroll; ">
						<div style='line-height: 120px; text-align: center;'>请点击右上角按钮进行图片上传！</div>
					</div>
				</td>
			</tr>
            <tr>
              <td nowrap="nowrap" class="right">&nbsp;</td>
              <td class="right" colspan="3">
              	<div style=" float: right; margin-right: 50px;">
              		<input type="button" id="submitId" name="submit" value="发 布" class="tijiao" style="cursor: pointer" onclick="doSub();" />
              		<%
              			if(!"".equals(uuid)){
              				%>
              	<input type="hidden" name="zd_uuid" id="zd_uuid" value="<%=uuid %>" />
              				<%
              			}
              		%>
              	</div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </div>
</div>
 </form>
</body>
</html>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/area/areas.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/validator/wofoshan/validator.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript">
jQuery("#repairfile").JrUpload({
	remotUrl : "<%=resourceDomain+"/upload.jsp" %>",
	folder : "used" ,
	callback : "setRepairfileTip",
	fileExt : "doc,docx"
});
function setRepairfileTip(data){
	jQuery("#repairfile_tip").html("<span style='color:red;'>维修文件上传成功！</span>");
	jQuery("#zd_repairfile").val('<%=resourceDomain %>'+data);
}
jQuery("#equi_img").JrUpload({
	remotUrl : "<%=resourceDomain+"/upload.jsp" %>",
	folder : "used" ,
	callback : "setEquiImgs",
	multi : false ,
	counts : 20
});
var imgArrs = [];
var domain = '<%=resourceDomain %>';
function setEquiImgs(data){
	var tempImgArrs = data.split(",");
	for(var i=0;i<tempImgArrs.length;i++){
		imgArrs.push(domain+tempImgArrs[i]);
	}
	setImg();
}

function setImg(){
	jQuery("#equi_imgs").html("");
	for(var i=0;i<imgArrs.length;i++){
		jQuery("#equi_imgs").append('<div onclick="removeImg(this);" style="float:left;margin:5px;border:1px solid #ccc;"><img src="'+imgArrs[i]+'" style="width:100px;height:100px;" /><input type="hidden" name="img'+(i+1)+'" value="'+imgArrs[i]+'" /></div>');
	}
}

function removeImg(o){
	if(confirm("确定移除这张图片吗？")){
		var src = jQuery(o).find("img").attr("src");
		for(var i=0;i<imgArrs.length;i++){
			if(imgArrs[i]==src){
				imgArrs.splice(i,1);
			}
		}
		setImg();
	}
}
<%
	if(!"".equals(uuid)){
		String img = "";
		for(int i=1;i<32;i++){
			img = Common.getFormatStr(she_bei.getString("img"+i));
			if(!"".equals(img)){
			%>imgArrs.push("<%=img %>");<%
			}
		}
		%>
setImg();
		<%
	}
%>

setProvinceCity("zd_province","zd_city");

function doSub(){
	var rs = Validator.Validate(document.getElementById("theform"),1);
	if(rs){
		if(imgArrs.length<=0){
			alert("请上传设备图片！");
			return;
		}
		if(jQuery.trim(jQuery("#zd_price").val())==""){
			jQuery("#zd_price").val(0);
		}
		jQuery("#theform").ajaxSubmit({
			async : false ,
			success : function(d){
				if(jQuery.trim(d)=='ok'){
					alert("设备发布成功！");
					already_send = already_send + 1;
					<%
					if("".equals(uuid)){
					%>
					jQuery("#theform").resetForm();
					imgArrs = [];
					setImg();
					<%	
					}
					%>
				}else{
					alert("设备发布失败！");
				}
				<%
				if("".equals(uuid)){
					%>
				setDisabled();
					<%
				}
				%>
			}
		});
	}
}
<%
	if("".equals(uuid)){
		%>
jQuery(function(){
	jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
		var province = remote_ip_info["province"] ;
		var city = remote_ip_info["city"];
		jQuery("#zd_province").val(province);
		jQuery("#zd_province").change();
		jQuery("#zd_city").val(city);
	});
});
		<%
	}
%>

jQuery("#zd_price,#zd_workingtime").keydown(function(e){
	return check(e);
});

function check(event){
    var e = window.event || event;
    var target = e.srcElement || e.target;
    var k = e.keyCode;
    if (isFunKey(k)) {
        return true;
    }
    var c = getChar(k);
    if (target.value.length == '' && (c == '-' || c == '+')) {
        return true;
    }
    if (isNaN(target.value + getChar(k))) {
        return false;
    }
    return true;
}

function isFunKey(code){
    var funKeys = [8, 35, 36, 37, 39, 46];
    for (var i = 112; i <= 123; i++) {
        funKeys.push(i);
    }
    for (var i = 0; i < funKeys.length; i++) {
        if (funKeys[i] == code) {
            return true;
        }
    }
    return false;
}

function getChar(k){
    if (k >= 48 && k <= 57) {
        return String.fromCharCode(k);
    }
    if (k >= 96 && k <= 105) {
        return String.fromCharCode(k - 48);
    }
    if (k == 110 || k == 190) {
        return ".";
    }
    if (k == 109 || k == 189) {
        return "-";
    }
    if (k == 107 || k == 187) {
        return "+";
    }
    return "#";
}
var most_count = <%=mostCount %>;
var already_send = <%=alreadySend %>;
<%
if("".equals(uuid)){
	%>
setDisabled();
	<%
}
%>
function setDisabled(){
	if((already_send>=most_count&&most_count>0)||most_count==-2){
		jQuery("input,select,textarea").attr("disabled","disabled");
		jQuery("#equi_img,#repairfile").hide();
		parent.jQuery.jBox.error('你发布设备的数量已经到达了上限，想要继续发布设备，请您&nbsp;<a href="javascript:void(0);" onclick="writeApply();" style="text-decoration: underline;">填写申请</a>。', '高级会员申请提示',{
			top:"40%",
			submit : function(v,h,f){
				parent.writeApply();
			}
		});
	}
}
</script>
<%
	}catch(Exception e){
		
	}finally{
		usedPool.freeConnection(connection);
	}
%>