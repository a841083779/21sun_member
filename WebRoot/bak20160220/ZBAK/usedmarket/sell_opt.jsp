<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%
	long begin = Calendar.getInstance().getTime().getTime();
	PoolManager usedPool = new PoolManager(4);
	long end = Calendar.getInstance().getTime().getTime();
	System.out.println(end-begin);
	Connection connection = null;
	ResultSet she_bei_lei_bie = null;
	ResultSet she_bei_pin_pai = null;
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	ResultSet sell = null;
	String uuid = Common.getFormatStr(request.getParameter("uuid"));
	String resourceDomain = "http://resource.21-sun.com";
	try{
		connection = usedPool.getConnection();
		she_bei_lei_bie = DataManager.executeQuery(connection," select id,category_name from used_category ");
		she_bei_pin_pai = DataManager.executeQuery(connection," select id,(letter+' '+brand_name) as brand_name , brand_name as sort_name from used_brand where id <> 89 order by letter ");
		if(!"".equals(uuid)){
			sell = DataManager.executeQuery(connection," select * from used_sell where uuid = '"+uuid+"' ");
		}
		String title = "";
		String category_id = "";
		String province = "";
		String city = "";
		String img1 = "";
		String detail = "";
		String factorydate = "";
		String brand_id = "";
		String model = "";
		String other_category = "";
		String other_brand = "";
		String is_pub = "";
		if(null!=sell&&sell.next()){
			title = Common.getFormatStr(sell.getString("title"));
			category_id = Common.getFormatStr(sell.getString("category_id"));
			province = Common.getFormatStr(sell.getString("province"));
			city = Common.getFormatStr(sell.getString("city"));
			img1 = Common.getFormatStr(sell.getString("img1"));
			detail = Common.getFormatStr(sell.getString("detail"));
			factorydate = Common.getFormatStr(sell.getString("factorydate"));
			brand_id = Common.getFormatStr(sell.getString("brand_id"));
			model = Common.getFormatStr(sell.getString("model"));
			other_category = Common.getFormatStr(sell.getString("other_category"));
			other_brand = Common.getFormatStr(sell.getString("other_brand"));
			is_pub = Common.getFormatStr(sell.getString("is_pub"));
		}
		if("".equals(img1)){
			img1 = "/images/nopic.gif";
		}
		Boolean baseMember = true;
		String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag"));
		Integer mostCount = 0;
		if("1014".equals(mem_flag)){//认证经销商
			mostCount = 20;
			baseMember = false;
		}else if("1008".equals(mem_flag)){//品牌厂商
			mostCount = -1;
			baseMember = false;
		}else if("1007".equals(mem_flag)){//品牌代理商
			mostCount = -1;//不限制
			baseMember = false;
		}else{
			mostCount = 1;
		}
		Integer alreadySend = 0;
		//ResultSet rs_already_send = DataManager.executeQuery(connection," select count(*) as counts from used_sell where mem_no = '"+memberInfo.get("mem_no")+"' and datediff(d,add_date,getdate())= 0 ");
		//if(null!=rs_already_send&&rs_already_send.next()){
			//alreadySend = rs_already_send.getInt("counts");
		//}
		Integer allMostCount = 0;
		//ResultSet rs_already_send_most = DataManager.executeQuery(connection," select count(*) as counts from used_sell where mem_no = '"+memberInfo.get("mem_no")+"' ");
		//if(null!=rs_already_send_most&&rs_already_send_most.next()){
			//allMostCount = rs_already_send_most.getInt("counts");
		//}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>供应发布</title>
	<link href="style/style.css" rel="stylesheet" type="text/css" />
	<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
	<script src="../scripts/jquery-1.4.1.min.js"></script>
</head>
<body>
  <div class="loginlist_right" style="width: 100%;">
  <div class="loginlist_right2"><span class="mainyh">发布二手商机信息</span></div>
  <div class="loginlist_right1" style="width: 100%;"> 
   <form action="tools/action_sell.jsp" method="post" name="theform" id="theform">
   <table width="95%" border="0" align="center" class="tablezhuce">
   	<tr>
   		<td style="text-align: right;"><strong style="font-size: 16px;">出售意向</strong></td>
   		<td colspan="3">
   			<div style="margin-left: 52px; font-size:16px; font-weight: bold; color: red;">
	   			<span id="title"></span>
	   			<input type="hidden" name="zd_title" id="zd_title" />
   			</div>
   		</td>
   	</tr>
   	 <tr>
   		<td width="15%" style="text-align: right;"><strong><font color="#FF0000">*</font>出厂年份</strong></td>
   		<td width="35%" style="text-align: center;">
   			    <select name="zd_factorydate" id="zd_factorydate"  style="width: 138px; height: 24px;" dataType="Require" msg="请选择出厂年份！">
                  <option value=""> --请选择年份-- </option>
                  <option value="不确定"> 不确定</option>
                  <%
                  int bigYear = Calendar.getInstance().get(Calendar.YEAR);
                  for(int i=bigYear;i>1989;i--){
                	  %>
               	  <option value='<%=i %>'><%=i %>年</option>
                	  <%
                  }
                  %>
                </select>
   		</td>
   		<td width="15%" style="text-align: right;"><strong><font color="#FF0000">*</font>设备品牌</strong></td>
     	 <td width="35%" style="text-align: center;">
     	 	 <div>
               <select name="zd_brand_id" id="zd_brand_id" style="width: 138px; height: 24px;" dataType="Require" msg="请选择设备品牌！">
                  <option value=""> --请选择品牌-- </option>
                  <%
                  	while(null!=she_bei_pin_pai&&she_bei_pin_pai.next()){
                  		%>
                  <option sort_name="<%=Common.getFormatStr(she_bei_pin_pai.getString("sort_name")) %>" value="<%=Common.getFormatStr(she_bei_pin_pai.getString("id")) %>"><%=Common.getFormatStr(she_bei_pin_pai.getString("brand_name")) %></option>
                  		<%                  		
                  	}
                  %>
                  <option value="89">Q 其它</option>
                </select>
               </div>
               <div style=" margin: 3px 0 0 0;">
                <input type="text" name="zd_other_brand" id="zd_other_brand" style="height: 20px; width:134px; display: none;" value="<%=other_brand %>" dataType="Require" msg="请输入设备品牌！" />
				</div>
		</td>
   	</tr>
    <tr>
      <td style="text-align: right;"><strong><font color="#FF0000">*</font>设备类别</strong></td>
      <td style="text-align: center;">
      	<div>
               <select name="zd_category_id" id="zd_category_id" style="width: 138px; height: 24px;" dataType="Require" msg="请选择设备类别！">
                  <option value=""> --请选择类别-- </option>
                  <%
                  while(null!=she_bei_lei_bie&&she_bei_lei_bie.next()){
                	  %>
                <option value="<%=Common.getFormatStr(she_bei_lei_bie.getString("id")) %>"><%=Common.getFormatStr(she_bei_lei_bie.getString("category_name")) %></option>
                	  <%
                  }
                  %>
                </select>
          </div>
          <div style=" margin: 3px 0 0 0;">
                <input type="text" name="zd_other_category" id="zd_other_category" style="height: 20px; width:134px; display:none;" value="<%=other_category %>" />
		  </div>
		</td>
		<td style="text-align: right;"><strong><font color="#FF0000">*</font>设备型号</strong></td>
    	<td style="text-align: center;">
    		<input type="text" name="zd_model" id="zd_model" style="height: 20px; width: 134px;" value="<%=model %>" dataType="Require" msg="请输入设备型号！" />
    	</td>
    </tr>
    <tr>
    	<td style="text-align: right;"><strong>设备省份</strong></td>
    	<td style="text-align: center;">
	    	<select name="zd_province" id="zd_province" onchange="getCity(this,'zd_city')" style="width: 138px; height: 24px;"></select>
    	</td>
    	<td style="text-align: right;"><strong>设备城市</strong></td>
    	<td style="text-align: center;">
    		<select  name="zd_city" id="zd_city" style="width: 138px; height: 24px;"></select>
    	</td>
    </tr>
	 <tr>
		<td style="text-align: right;"><strong><font color="#FF0000">*</font>设备图片</strong> </td>
		<td colspan="3">
			<div style="margin-left: 52px;">
				<img src="<%=img1 %>" id="my_equi_img" width="143" height="137" />
				<%
					if(img1.equals("/images/nopic.gif")){
						img1 = "";
					}
				%>
				<input name="zd_img1" id="zd_img1" type="hidden" dataType="Require" msg="请上传设备图片！" value="<%=img1 %>" />
				<span style="margin-left: 3px;position: relative;top:-3px;"></span><span id="equi_img" style="position: relative; top:5px; left: 8px;"></span>
			</div>
		</td>
	 </tr>
    <tr>
      <td height="22" style="text-align: right;"><strong>详细说明</strong></td>
      <td height="22" colspan="3">
      	<div style="margin-left: 52px;">
      		<textarea name="zd_detail" id="zd_detail" style="overflow-y:scroll;background: none; width: 485px; height: 120px;"><%=detail %></textarea>
        </div>
      </td>
    </tr>	
	<tr>
		<td nowrap="nowrap" class="right">&nbsp;</td>
		<td class="right" colspan="3">
			<input type="button" name="submit" value="发 布" class="tijiao" style="cursor:pointer; margin-left: 200px;" onclick="doSub();" />
			<input type="button" style="margin-left:10px;" name="submit" value="返回" class="tijiao" style="cursor:pointer"  onclick="javascript:history.back();"/>
			<%
				if(!"".equals(uuid)){
					if(baseMember){//暂时为不用审核
						%>
						
						<input type="hidden" name="zd_is_pub" id="zd_is_pub" value="1" />
						<input type="hidden" name="zd_uuid" id="zd_uuid" value="<%=uuid %>" />
						<%
					}else{
						%>
						<input type="hidden" name="zd_is_pub" id="zd_is_pub" value="<%=is_pub %>" />
						<input type="hidden" name="zd_uuid" id="zd_uuid" value="<%=uuid %>" />
						<%
					}
				}else{//如果是增加
					if(baseMember){//如果是普通会员，需等待审核，暂时未不用审核
						%>
				<input type="hidden" name="zd_is_pub" id="zd_is_pub" value="1" />
						<%
					}else{
						%>
				<input type="hidden" name="zd_is_pub" id="zd_is_pub" value="1" />
						<%
					}
				}
			%>
		</td>
	</tr>
	</table>
</form>	
</body>
</html>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/area/areas.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/validator/wofoshan/validator.min.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript">
	setProvinceCity("zd_province","zd_city");
	jQuery("#equi_img").JrUpload({
		remotUrl : "<%=resourceDomain+"/upload.jsp" %>",
		folder : "used" ,
		callback : "setEquiImg"
	});
	function setEquiImg(data){
		jQuery("#my_equi_img").attr("src","<%=resourceDomain %>"+data);
		jQuery("#zd_img1").val("<%=resourceDomain %>"+data);
	}
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
		  // 此处验证
			jQuery("#theform").ajaxSubmit({
				async : false ,
				success : function(data){
					<%
					if("".equals(uuid)){
						%>
					if(jQuery.trim(data)=='ok'){
						alert("供应信息发布成功！");
						already_send = already_send + 1;
						jQuery("#theform").resetForm();
						jQuery("#my_equi_img").attr("src","/images/nopic.gif")
						jQuery("#title").html("");
					}else{
						alert("供应信息发布失败！");
					}
						<%
					}else{
						%>
					if(jQuery.trim(data)=='ok'){
						alert("供应信息修改成功！");
					}else{
						alert("供应信息修改失败！");
					}
						<%
					}
					%>
					
					<%
					if("".equals(uuid)){
						%>
					//提示
					//setDisabled();
						<%
					}
					%>
				}
			});
		}
	}
	jQuery("#zd_category_id").change(function(){
		if(this.value=='9'){
			jQuery("#zd_other_category").show();
		}else if(this.value!=''){
			jQuery("#zd_other_category").hide();
			var zd_category_id = document.getElementById("zd_category_id");
			jQuery("#zd_other_category").val(zd_category_id.options[zd_category_id.selectedIndex].innerHTML);
			setTitle();
		}
	});
	jQuery("#zd_factorydate").change(function(){
		setTitle();
	});
	jQuery("#zd_brand_id").change(function(){
		if(this.value=='89'){
			jQuery("#zd_other_brand").show();
		}else if(this.value!=''){
			jQuery("#zd_other_brand").hide();
			var zd_brand_id = document.getElementById("zd_brand_id");
			jQuery("#zd_other_brand").val(zd_brand_id.options[zd_brand_id.selectedIndex].getAttribute("sort_name"));
			setTitle();
		}
	});
	jQuery("#zd_other_category").click(function(){
		if(this.value=="请填写类别名称！"){
			this.value="";
		}
	});
	jQuery("#zd_other_category").keyup(function(){
		setTitle();
	});
	jQuery("#zd_other_brand").click(function(){
		if(this.value=="请填写品牌名称！"){
			this.value="";
		}
	});
	jQuery("#zd_other_brand").keyup(function(){
		setTitle();
	});
	jQuery("#zd_model").keyup(function(){
		setTitle();
	});
	function setTitle(){
		var title = "";
		title += "出售";
		if(jQuery("#zd_factorydate").val()!='不确定'){
			 title += jQuery("#zd_factorydate").val()+"年产的";
		}
		title += jQuery("#zd_other_brand").val();
		title += jQuery("#zd_model").val();
		title += jQuery("#zd_other_category").val();
		jQuery("#title").html(title);
		jQuery("#zd_title").val(title);
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

var most_count = <%=mostCount %>;
var already_send = <%=alreadySend %>;
var all_most_count = <%=allMostCount %>;
<%
if("".equals(uuid)){
	%>
setDisabled();
	<%
}
%>

function setDisabled(){
	if(<%=baseMember %>){//如果是普通会员
		if(all_most_count>=5){//如果最大发信息量大于五
			jQuery("input,select,textarea").attr("disabled","disabled");
			jQuery("#equi_img").hide();
			parent.jQuery.jBox.error('您发布的出售商机数量已经到达了上限，想要继续发布出售商机，请您&nbsp;<a href="javascript:void(0);" onclick="writeApply();" style="text-decoration: underline;">填写申请</a>。', '高级会员申请提示',{
				top:"40%",
				submit : function(v,h,f){
					parent.writeApply();
				}
			});
		}else if(already_send>=most_count){//如果超过今日最大发信息量
			jQuery("input,select,textarea").attr("disabled","disabled");
			jQuery("#equi_img").hide();
			parent.jQuery.jBox.error('您今日发布的出售商机数量已经到达了上限，请您明天再发，如您希望一天发布更多信息，请您&nbsp;<a href="javascript:void(0);" onclick="writeApply();" style="text-decoration: underline;">填写申请</a>。', '高级会员申请提示',{
				top:"40%",
				submit : function(v,h,f){
					parent.document.getElementById("iframeright_1").src="/usedmarket/sell_list.jsp";
				}
			});
		}
	}else{
		if(already_send>=most_count&&most_count>0){
			jQuery("input,select,textarea").attr("disabled","disabled");
			jQuery("#equi_img").hide();
			parent.jQuery.jBox.error('您发布的出售商机数量已经到达了上限，想要继续发布出售商机，请您&nbsp;<a href="javascript:void(0);" onclick="writeApply();" style="text-decoration: underline;">填写申请</a>。', '高级会员申请提示',{
				top:"40%",
				submit : function(v,h,f){
					parent.writeApply();
				}
			});
		}
	}
}
jQuery(function(){
	jQuery("#zd_category_id").val("<%=category_id %>");
	jQuery("#zd_category_id").change();
	jQuery("#zd_province").val("<%=province.replaceAll("省","") %>");
	jQuery("#zd_province").change();
	jQuery("#zd_city").val("<%=city.replaceAll("市","") %>");
	jQuery("#zd_brand_id").val("<%=brand_id %>");
    jQuery("#zd_brand_id").change();
    jQuery("#zd_factorydate").val("<%=factorydate %>");
    jQuery("#zd_factorydate").change();
    jQuery("#title").html("<%=title %>");
    jQuery("#zd_title").html("<%=title %>");
    jQuery("body").show();
});  
</script>
<%
	}catch(Exception e){
		
	}finally{
		usedPool.freeConnection(connection);
	}
%>

