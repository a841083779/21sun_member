<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%
	PoolManager usedPool = new PoolManager(4);
	Connection connection = null;
	ResultSet she_bei_lei_bie = null;
	ResultSet she_bei_pin_pai = null;
	ResultSet buy = null;
	String uuid = Common.getFormatStr(request.getParameter("uuid"));
	try{
		connection = usedPool.getConnection();
		she_bei_lei_bie = DataManager.executeQuery(connection," select id,category_name from used_category ");
		she_bei_pin_pai = DataManager.executeQuery(connection," select id,(letter+' '+brand_name) as brand_name , brand_name as sort_name from used_brand order by letter ");
		if(!"".equals(uuid)){
			buy = DataManager.executeQuery(connection," select * from used_buy where uuid = '"+uuid+"' ");
		}
		String title = "";
		String category_id = "";
		String province = "";
		String city = "";
		String detail = "";
		String factorydate = "";
		String brand_id = "";
		String model = "";
		if(null!=buy&&buy.next()){
			title = Common.getFormatStr(buy.getString("title"));
			category_id = Common.getFormatStr(buy.getString("category_id"));
			province = Common.getFormatStr(buy.getString("province"));
			city = Common.getFormatStr(buy.getString("city"));
			detail = Common.getFormatStr(buy.getString("detail"));
			factorydate = Common.getFormatStr(buy.getString("factorydate"));
			brand_id = Common.getFormatStr(buy.getString("brand_id"));
			model = Common.getFormatStr(buy.getString("model"));
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>供应发布</title>
	<link href="style/style.css" rel="stylesheet" type="text/css" />
	<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
	<script src="../scripts/jquery-1.4.1.min.js"></script>
<script type="text/javascript" src="/scripts/_citys.js"></script>
<script type="text/javascript" src="/scripts/pinyin.js"></script></head>
<body>
  <div class="loginlist_right" style="width: 100%;">
  <div class="loginlist_right2"><span class="mainyh">发布二手求购信息</span></div>
  <div class="loginlist_right1" style="width: 100%;"> 
   <form action="tools/action_buy.jsp" method="post" name="theform" id="theform">
   <table width="95%" border="0" align="center" class="tablezhuce">
   	<tr>
   		<td style="text-align: right;"><strong style="font-size: 16px;">求购意向</strong></td>
   		<td colspan="3">
   			<div style="margin-left: 52px; font-size:16px; font-weight: bold; color: red;">
	   			<span id="title"></span>
	   			<input type="hidden" name="zd_title" id="zd_title" />
   			</div>
   		</td>
   	</tr>
   	 <tr>
   		<td width="15%" style="text-align: right;"><strong><font color="#FF0000"></font>出厂年份</strong></td>
   		<td width="35%" style="text-align: center;">
   			    <select name="zd_factorydate" id="zd_factorydate"  style="width: 138px; height: 24px;">
                  <option value="">--不限--</option>
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
   		<td style="text-align: right;"><strong>意向品牌</strong></td>
	    <td style="text-align: center;">
	    		<div>
	               <select name="zd_brand_id" id="zd_brand_id" style="width: 138px; height: 24px;">
	                  <option value=""> --不限-- </option>
	                  <%
	                  	while(null!=she_bei_pin_pai&&she_bei_pin_pai.next()){
	                  		%>
	                  <option sort_name="<%=Common.getFormatStr(she_bei_pin_pai.getString("sort_name")) %>" value="<%=Common.getFormatStr(she_bei_pin_pai.getString("id")) %>"><%=Common.getFormatStr(she_bei_pin_pai.getString("brand_name")) %></option>
	                  		<%                  		
	                  	}
	                  %>
	                </select>
	              </div>
	              <div style="margin-top:3px;">
	                <input type="text" name="zd_other_brand" id="zd_other_brand" style="height: 20px; width:134px; display: none;" />
	              </div>
	 	</td>
   	</tr>
    <tr>
      <td style="text-align: right;"><font color="#FF0000">*</font><strong>意向类别</strong></td>
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
               <div style="margin-top: 3px;">
                <input type="text" name="zd_other_category" id="zd_other_category" style="height: 20px; width:134px; display:none;" />
                </div>
		</td>
		<td style="text-align: right;"><strong>意向型号</strong></td>
    	<td style="text-align: center;">
    		<input type="text" name="zd_model" id="zd_model" style="height: 20px; width: 134px;" value="<%=model %>"/>
    	</td>
    </tr>
    <tr>
    	<td style="text-align: right;"><strong>意向省份</strong></td>
    	<td style="text-align: center;">
    		<select name="zd_province" id="zd_province" onchange="set_city(this,this.value,theform.zd_city,'');" style="width: 138px; height: 24px;">
    		<option value="安徽">安徽</option>
          <option value="北京">北京</option>
          <option value="重庆">重庆</option>
          <option value="福建">福建</option>
          <option value="甘肃">甘肃</option>
          <option value="广东">广东</option>
          <option value="广西">广西</option>
          <option value="贵州">贵州</option>
          <option value="海南">海南</option>
          <option value="河北">河北</option>
          <option value="黑龙江">黑龙江</option>
          <option value="河南">河南</option>
          <option value="湖北">湖北</option>
          <option value="湖南">湖南</option>
          <option value="内蒙古">内蒙古</option>
          <option value="江苏">江苏</option>
          <option value="江西">江西</option>
          <option value="吉林">吉林</option>
          <option value="辽宁">辽宁</option>
          <option value="宁夏">宁夏</option>
          <option value="青海">青海</option>
          <option value="山西">山西</option>
          <option value="山东">山东</option>
          <option value="上海">上海</option>
          <option value="四川">四川</option>
          <option value="天津">天津</option>
          <option value="西藏">西藏</option>
          <option value="新疆">新疆</option>
          <option value="云南">云南</option>
          <option value="浙江">浙江</option>
          <option value="陕西">陕西</option>
          <option value="台湾">台湾</option>
          <option value="香港">香港</option>
          <option value="澳门">澳门</option>
          <option value="海外">海外</option>
    		</select>
    	</td>
    	<td style="text-align: right;"><strong><font color="#FF0000"></font>意向城市</strong></td>
    	<td style="text-align: center;">
    		<select  name="zd_city" id="zd_city" style="width: 138px; height: 24px;">
    		<option value="">选择城市</option>
    		</select>	
    	</td>
    </tr>
    <tr>
      <td height="22" style="text-align: right;"><font color="#FF0000">*</font><strong>意向说明</strong></td>
      <td height="22" colspan="3">
      	<div style="margin-left: 52px;">
      		<font color="#FF0000">*</font><textarea name="zd_detail" id="zd_detail" style="overflow-y:scroll;background: none; width: 485px; height: 120px;"dataType="Require" msg="请输入意向说明！" ><%=detail %></textarea>
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
					%>
			<input type="hidden" name="zd_uuid" id="zd_uuid" value="<%=uuid %>" />
					<%
				}
			%>
		</td>
	</tr>
	</table>
</form>	
</body>
</html>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/validator/wofoshan/validator.min.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript">
	jQuery("#equi_img").JrUpload({
		domain : document.domain + ":1007",
		folder : "used" ,
		callback : "setEquiImg"
	});
	function setEquiImg(data){
		jQuery("#my_equi_img").attr("src","http://192.168.0.154:2112"+data);
		jQuery("#zd_img1").val("http://192.168.0.154:2112"+data);
	}
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({ 
				async : false ,
				success : function(data){  
					<%
					if("".equals(uuid)){
						%>
					if(jQuery.trim(data)=='ok'){
						alert("供应信息发布成功！");
						self.opener = null; 
						self.window.close() ;
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
		title += "求购";
		if(jQuery("#zd_factorydate").val()!=''){
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
    
  	jQuery("#zd_province option").each(function(){
		jQuery(this).text(codefans_net_CC2PY(jQuery(this).text()).substring(0,1)+"-"+jQuery(this).text());
	}) ;
});
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		usedPool.freeConnection(connection);
	}
%>
