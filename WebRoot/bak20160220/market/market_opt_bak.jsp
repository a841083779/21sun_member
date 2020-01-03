<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file="/manage/config.jsp"%>
<%
	String telString = Common.getFormatStr((String) adminInfo.get("per_phone"));
%>
<%
	//根据ip获得地址
	String mypy = "sell_buy_market";
	String tablename = Common.getFormatStr(request.getParameter("tablename"));
	if (tablename != null && !tablename.equals("")) {
		mypy = tablename; 
	}
	String isReload = Common.getFormatInt(request.getParameter("isReload"));
	String myvalue = Common.getFormatStr(request.getParameter("myvalue"));
	String addflag = (Common.getFormatStr(request.getParameter("addflag"))); // 获得传递来的参数，改变当前状态 1 我要卖 7 -我要买
	String urlpath = "../market/market_opt.jsp?addflag=" + addflag;
	// 推荐品牌
	String chooseBrand = "请选择品牌";
	String myValue = Common.getFormatStr(request.getParameter("myvalue")); // 
	String probrand = Common.getFormatStr(request.getParameter("probrand"));

	// 获得session中的适用机型和品牌
	String[] sessionProbrands = null;
	String sessionProbrand = (Common.getFormatStr(session.getAttribute("sessionProbrand")));
	if (!"".equals(sessionProbrand)) {
		sessionProbrands = sessionProbrand.split(",");

	}
	String sessionPartflag = (Common.getFormatStr(session.getAttribute("sessionPartflag")));
	String probrandname = Common.getFormatStr(request.getParameter("probrandname"));
	chooseBrand = Common.getFormatStr(session.getAttribute("brandname")).equals("") ? "请选择品牌" : Common.getFormatStr(session.getAttribute("brandname"));
	if (!"".equals(myValue)) {
		if (!"".equals(probrand) && !"".equals(probrandname)) {
			chooseBrand = probrandname;
		}
	}
	if (!myvalue.equals("")) {
		urlpath = urlpath + "?myvalue=" + java.net.URLEncoder.encode(myvalue, "UTF-8");
		//需要编码 才能将加密后产生的特殊字符 例如：将 +  转码成 %2B
	}
	String businessFlag = "";
	if ("1".equals(addflag)) {
		businessFlag = "10"; // 发布卖的产品
	}
	if ("7".equals(addflag)) {
		businessFlag = "11"; // 发布买的产品
	}
	if (!myvalue.equals("")) {
		urlpath = urlpath + "?myvalue=" + java.net.URLEncoder.encode(myvalue, "UTF-8");
		//需要编码 才能将加密后产生的特殊字符 例如：将 +  转码成 %2B
	}
	String mem_no = "";
	HashMap memberInfo = new HashMap();
	String city = "";
	String province = "";
	if (session.getAttribute("memberInfo") != null) {
		memberInfo = (HashMap) session.getAttribute("memberInfo"); //   获取session中存储的帐号
		mem_no = String.valueOf(memberInfo.get("mem_no")); //   登陆名字
		province = Common.getFormatStr((String) memberInfo.get("per_province"));
		city = Common.getFormatStr((String) memberInfo.get("per_city"));
	}
	// 获得用户的地址
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<link href="/style/style_new.css" rel="stylesheet" type="text/css" />
<style type="text/css">
input.error, textarea.error { border: 1px solid #b9747a; background: #fdcdcb; }
label.error { color: #ff6600; display: none; float: left; white-space: nowrap; background: url(/images/tip_ico.png) 5px 4px no-repeat; padding-left: 23px; }
.selectcity { margin-top: -25px; margin-left: 150px; clear: both; display: block; position: relative; color: #FF6600 }
.noselectcity { margin-top: -25px; margin-left: 150px; clear: both; display: block; position: relative; color: #FF6600; display: none; }
.rt { float: left; }
.error .fakerHead { background: url(/images/faker.gif) 0px 0px no-repeat !important; }
.error .fakerHead div { background: url(/images/faker.gif) right 0px no-repeat !important; }
</style>
<script src="/scripts/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/scripts/validate/jquery.metadata.js"></script>
<script type="text/javascript" src="/scripts/validate/jquery.validate.min.js"></script>
<script type="text/javascript" src="/scripts/validate/messages_cn.js"></script>
<link href="/scripts/select_city/search.css" rel="stylesheet" type="text/css" />
<link href="/scripts/select_city/style.css" rel="stylesheet" type="text/css" />
<script src="/scripts/select_city/options.js" type="text/javascript"></script>
<script type="text/javascript">var JQ = jQuery</script>
<script src="/scripts/select_city/location_array.js" type="text/javascript"></script>
<script type="text/javascript" src="/scripts/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox/Skins/Blue/jbox.css" />
<script src="/scripts/common.js" type="text/javascript"></script>
<style type="text/css">
input.moren { vertical-align: middle; line-height: 11px; padding: 1px 1px; font: 12px arial; float: left; margin: 0; border: 1px solid #B8CFE0; color: #676767; background: #F7FBFF; }
</style>
<script type="text/javascript" src="/scripts/pinyin.js"></script>
</head>
<%
		//检测用户是否完善了信息
		if ("1".equals(userInfoFlag)) {
	%>
<script type="text/javascript">
				jQuery(function(){
				jQuery.jBox.prompt('发布信息前，请先完善您的个人资料，便于您的潜在客户及时联系到您！', '温馨提醒', 'info', { closed: function () {
				parent.window.location.href="<%=mem_type_url%>" ;
				 } });
				})
			</script>
<%
		}
	%>
<body style="background-color: transparent;">
<div class="loginlist_right">
  <%
				if ("1".equals(addflag)) { 
			%>
  <div class="member_rightTitle">
    <h2 id="show_name"> 我要卖 </h2>
  </div>
  <div class="Tips"> <strong>温馨提示：</strong>请正确填写以下信息，保证信息真实有效，买家可以放心询价、购买， <font color=red>*</font> 为必填项；二手信息需要到二手栏目发布。 </div>
  <%
				} else {
			%>
  <div class="member_rightTitle">
    <h2> 我要买 </h2> 
  </div>
  <div class="Tips"> <strong>温馨提示：</strong>发布求购信息，请先完善资料，便于更快地联系到您；二手信息需要到二手栏目发布。 </div>
  <%
				}
			%>
  <div class="formTable">
    <form action="opt_save_update.jsp" method="post" name="theform" id="theform" submited="true">
      <table width="95%" border="0" align="center" cellpadding="0"
						cellspacing="0" class="formTable">
        <tr>
          <th nowrap="nowrap"> <font>* </font>标题： </th>
          <td><input name="zd_title" type="text" id="zd_title" size="75" class="ri" validate="{required:true,minlength:5,maxlength:100}" onblur="javascript:checkCanPublish(this);" /></td>
        </tr>
        <tr>
          <th nowrap="nowrap"> <font>*</font> 省市： </th>
          <td><div class="select_box w_138 required" id="province_city" name="province_city"> 
              <script>			
			      var workLocSelect = new LocationSelect('search_form', 'work');
				  workLocSelect.build();
			       </script> 
            </div>
            <label class="noselectcity" id="selectcity"> 请选择您的省市 </label></td>
          <input type="hidden" name="zd_province" id="zd_province" />
          <input type="hidden" name="zd_city" id="zd_city" />
        </tr>
        <tr>
          <th nowrap="nowrap"> <font>*</font> 品牌： </th>
          <td class="list_cell_bg">
          <select id="zd_probrand" name="zd_probrand" validate="{required:true}" style="border: 1px solid #B5B6B3;padding: 3px;width:140px;float:left;margin-right:3px;" onchange="setBrand(this);">
						 <option value="" >请选择</option>
						<option value="174">K-卡特</option>
						<option value="136" >L-柳工</option>
						<option value="184">R-日立</option>
						<option value="133" >S-三一</option>
						<option value="13721">S-三菱</option>
						<option value="144">S-山推</option>
						<option value="183">S-神钢</option>
						<option value="175">W-沃尔沃</option>
						<option value="194">X-现代</option>
						<option value="139">X-厦工</option>
						<option value="182">X-小松</option>
						<option value="209">X-徐工</option>
						<option value="185" >Z-住友</option>
						<option value="134">Z-中联</option>
						<option value="0">其他</option>
            </select>
            <input type="text" id="otherBrand" name="otherBrand" class="ri" validate="{required:true,minlength:2,maxlength:100}" onblur="javascript:checkCanPublish(this);"  style="float:left;display:none;width:156px;"/>
            <input name="factory" id="factory" type="hidden" value="" />
            <input name="catalog" id="catalog" type="hidden" value="" /></td>
        </tr>
        <tr>
          <th nowrap="nowrap"> <font>*</font> 适用机型： </th>
          <td height="22" class="list_cell_bg my_list_cell_bg">
           <select id="zd_product_flag" name="zd_product_flag" validate="{required:true}" style="border: 1px solid #B5B6B3;padding: 3px;width:140px;float:left;margin-right:3px;" onchange="setCatalog(this);">
          	<option value="">请选择</option>
          	<option value="101001">挖掘机</option>
          	<option value="101002">装载机</option>
          	<option value="101003">推土机</option>
          	<option value="102">起重机械</option>
          	<option value="103">混凝土机械</option>
          	<option value="104">养路机械</option>
          	<option value="105">桩工机械</option>
          	<option value="110">地下及矿山机械</option>
          	<option value="0">其它机械</option>
          </select>
           <input type="text" id="otherCatalog" name="otherCatalog" class="ri" validate="{required:true,minlength:2,maxlength:100}" onblur="javascript:checkCanPublish(this);"  style="float:left;display:none;width:156px;"/>
            <input type="hidden" id="zd_product_flag_name" name="zd_product_flag_name"	value="" />
        </tr>
        <tr>
          <th nowrap="nowrap"> <font>*</font> 配件类别： </th>
          <td height="22" class="list_cell_bg" style="width:100%;">
           <div style="float:left;margin-right:4px;">
          <input type="radio" name="zd_part_flag" id="zd_part_flag" 	value="101001" class="required" />
            发动机件
            <input type="radio" name="zd_part_flag" id="zd_part_flag" value="101003" />
            液压件
            <input type="radio" name="zd_part_flag" id="zd_part_flag" value="101002" />
            底盘件
            <input type="radio" name="zd_part_flag" id="zd_part_flag" value="101012" />
            电器件
            <input type="radio" name="zd_part_flag" id="zd_part_flag" value="106" /> 
            其他件 
            </div>
            <input type="text" name="other_part_flag" id="other_part_flag" class="ri" style="float:left;width:100px;display:none;" validate="{required:true,minlength:2,maxlength:20}"/>
            <input type="hidden" name="zd_part_flag_name" id="zd_part_flag_name" value=""/>
            </td>
        </tr>
        <tr>
          <th nowrap="nowrap"> <font>*</font> 产品描述： </th>
          <td height="22" class="list_cell_bg" >
          <textarea name="zd_descr" cols="50" style="width:450px;" rows="6" id="zd_descr" class="rt required" validate="{required:true,minlength:30,maxlength:2000}"></textarea>
          </td>
        </tr>
        <%
							if (null != addflag && "1".equals(addflag)) {
						%>
        <tr>
          <th nowrap="nowrap"> <font>*</font>产品图片： </th>
          <td><div> <img src="/images/nopic.gif" id="my_equi_img" width="143" 	height="137" style="float:left;" /> <span style="margin-left: 3px; position: relative; top: -3px; float:left;">尺寸(280*210)</span>
          <span id="equi_img" style="position: relative; top: 5px; left: 8px; float:left;"></span>
          <input name="zd_img1" id="zd_img1" type="text" validate="{required:true}" style="float:left; width:0px; border:none;margin-left:7px;" />
            </div></td>
        </tr>
        <%
							} else {
						%>
        <input name="zd_img1" id="zd_img1" type="hidden" value="" />
        <%
							}
						%>
        <tr>
          <th nowrap="nowrap"> <font>*</font> 验证码： </th>
          <td height="22" class="list_cell_bg"><input type="hidden" name="zd_tel" value="<%=telString%>" />
            <input type="text" name="rand" id="rand" class="ri"
									style="width: 106px;" validate="{required:true}" />
            <div
									style="width: auto; display: inline; padding-left: 8px; padding-top: 2px; padding-right: 5px;"> <img src="/auth/authImgServlet?now=<%=new java.util.Date()%>"
										name="authImg" align="absmiddle" id="authImg"
										title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();" /> 看不清？ <a href="javascript:void(0);" onClick="refresh();"
										style="color: #005aa0; text-decoration: underline;">换一张</a> </div></td>
        </tr>
        <tr>
          <td nowrap="nowrap">&nbsp;</td>
          <td><input id="submitId" type="submit" name="Submit" value="发布信息" class="registBtn01" style="cursor: pointer" /></td>
        </tr>
        <!-- 发布日期 -->
        <input type="hidden" id="zd_pub_date" name="zd_pub_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss", 0)%>" size="20" maxlength="60" readonly="true" class="moren"	style="vertical-align: middle; line-height: 11px; padding: 1px 1px; 0; font: 12px arial" />
        <!-- 默认二手产品 -->
        <input type="hidden" id="zd_is_new" name="zd_is_new" value="2" />
        <!-- 默认显示 -->
        <input type="hidden" id="zd_is_show" name="zd_is_show" value="1" />
        <!-- 交易目的 -->
        <input type="hidden" id="zd_business_flag" name="zd_business_flag" value="<%=businessFlag%>" />
        <!-- 出售目的 -->
        <input name="zd_id" type="hidden" id="zd_id" value="0" />
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>" />
        <input name="zd_add_user" type="hidden" id="zd_add_user" value="" />
        <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss", 0)%>" />
        <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request, 1)%>" />
        <input name="myvalue" type="hidden" id="myvalue"	value='<%=myvalue%>' />
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>" />
        <input name="urlpath" type="hidden" id="urlpath"	value="<%=urlpath%>" />
        <input name="randflag" type="hidden" id="randflag" value="1" />
        <input name="zd_company" type="hidden" id="zd_company" value="<%=Common.getFormatStr((String) adminInfo.get("comp_name"))%>" />
        <input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=Common.getFormatStr((String) adminInfo.get("mem_no"))%>" />
        <input name="zd_mem_name" type="hidden" id="zd_mem_name" value="<%=Common.getFormatStr((String) adminInfo.get("mem_name"))%>" />
        <input name="pub_date_temp" type="hidden" id="pub_date_temp" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss", 0)%>" />
        <input name="zd_mem_flag" type="hidden" id="zd_mem_flag" value="<%=Common.getFormatStr((String) adminInfo.get("mem_flag"))%>" />
        <input name="zd_orderno" type="hidden" id="zd_orderno" value="<%=Common.getToday("yyyyMMddHHmmss", 0)%>" />
        <input name="zd_probrandname" type="hidden" id="zd_probrandname" value="" />
        <!--  取得选中的checkbox名称插入数据库-->
        <input type="hidden" name="probrandname" id="probrandname" value="" />
        <input type="hidden" name="zd_uuid" id="zd_uuid" value="<%=UUID.randomUUID().toString()%>" />
        <!-- 防止用户重复提交信息 -->
        <input type="hidden" name="canPublish" id="canPublish" value="0" />
        <input type="hidden" name="zd_rec_index" id="zd_rec_index" value="0" />
      </table>
    </form>
  </div>
</div>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 	scrolling="no" style="visibility: hidden"></iframe>
<script language="javascript">
function refresh(){
	  document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
refresh();
function set_formxx(val){
	if(val!=null && val!=""){
	 $('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	}
}
<%
if(!myvalue.equals("")){
	out.print("set_formxx(\""+Common.decryptionByDES(myvalue)+"\");");
}
%>
</script> 
<script language="javascript">
// onloadAjax();
 </script> 
<script type="text/javascript">
// jQuery 对输入的数据进行
jQuery(function(){
	jQuery("#zd_title").focus() ; 
    jQuery.metadata.setType("attr", "validate");  // 识别 validate 属性    
    jQuery("#theform").validate({
    	rules:{
                 zd_title:{required:true} ,
                 product_flag: {required:true},
                 zd_descr:{required:true},
                 zd_part_flag:{required:true},
				 rand:{required:true},
				 zd_img1:{required:true},
				 otherBrand:{required:true},
				 other_part_flag:{required:true},
				 zd_probrand:{required:true},
				 zd_product_flag:{required:true},
				 otherCatalog:{required:true}
                },
        event: "blur",
        messages:{
                  "zd_title":{required:" 请填写 标题",minlength:" 最小长度为5个字符",maxlength:" 最大长度为100个字符"} ,
                  "product_flag": {required:" 请您至少选择一个行业类别"},
                  "zd_descr":{required:" 请填写 产品描述",minlength:" 最少30个字符",maxlengh:"最多2000个字符"} ,
                  "zd_part_flag":{required:" 请选择 配件类别"},
				  "rand":{required:" 请填写 验证码"},  
				  "other_part_flag":{required:"请填写 配件类别",minlength:" 最少5个字符", maxlengh:"最多20个字符"},
				  "zd_img1":{required:" 请上传 产品图片"} ,
				  "otherBrand":{required:"请填写 品牌"},
				  "zd_probrand":{required:"请选择 品牌"},
				  "zd_product_flag":{required:"请选择 适用机型"},
				  "otherCatalog":{required:"请填写 适用机型"}
                } ,
        errorPlacement: function (error, element) { //指定错误信息位置	
        	if (element.is(':radio') || element.is(':checkbox')) {
          		var eid = element.attr('name');
          		error.appendTo(element.parent().parent());
         	} else {
          		error.insertAfter(element);
        	}
 		},
		submitHandler: function(form) {  //通过之后回自己的调验证函数
			if(jQuery("#canPublish").val()=='1')
			 {
			 // ---------------------------------------------可能会产生重复提交表单现象-----------------------------------------------------
			    	if( jQuery("#theform").attr("submited")=="true"){
			    	  jQuery("#theform").attr("submited","false") ;
			    	   form.submit();  // 提交表单  
			    	}
			 }else{
			 	check(jQuery("#zd_title")) ;
			 }
		},
		invalidHandler: function(form, validator) {  //不通过回调 
      	} 
   });  
});    
</script> 
</body>
</html>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript">
	jQuery("#equi_img").JrUpload({
		remotUrl : "http://resource.21-sun.com/upload.jsp",
		folder : "sell_buy_market" ,
		callback : "setEquiImg"
	});
	function setEquiImg(data){
		jQuery("#my_equi_img").attr("src","http://resource.21-sun.com"+data);
		jQuery("#zd_img1").val("http://resource.21-sun.com"+data);
	}

 // 限制复选框个数，最多三个 
  jQuery(":checkbox").click(function(){  
    if ( jQuery(":checkbox:checked").length >3  ) {
        jQuery(this).removeAttr("checked") ;
        jQuery.jBox.tip("对不起，您最多能选3个");
    }
  }) ;
    jQuery(function(){
    // 给checkbox赋初始值
          for(var i=0;i<jQuery(":checkbox").length;i++)
        { 
            <%
            if(null !=sessionProbrands){
              for(int k=0;k<sessionProbrands.length;k++)
              {
            	  %>
            	    if(jQuery(":checkbox:eq("+i+")").val()==="<%=sessionProbrands[k]%>")
            	    {
            	         jQuery(":checkbox:eq("+i+")").attr("checked","checked") ;
            	    }
            	  <%
              }}
            %>
        }
        for(var m=0;m<jQuery(":radio").length;m++)
        {
          if(jQuery(":radio:eq("+m+")").val()==="<%=sessionPartflag%>")
          {
           jQuery(":radio:eq("+m+")").attr("checked","checked") ;
          }
        }
     })
   </script>
<script
	src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"
	type="text/ecmascript"></script>
<script type="text/javascript">
	if(document.getElementById("zd_province").value == ""){
		jQuery("#zd_province").val("<%=province%>");
	}
	if(document.getElementById("zd_city").value == ""){
		jQuery("#zd_city").val("<%=city%>");
	}
	function getIpPlace() {
		if(document.getElementById("zd_province").value == ""){
			document.getElementById("zd_province").value = remote_ip_info["province"];
		}
		if(document.getElementById("zd_city").value == ""){
			document.getElementById("zd_city").value = remote_ip_info["city"];
		}
	} 
	getIpPlace();
	jQuery("#cond_search_form_work_location_show").html(jQuery("#zd_province").val()+jQuery("#zd_city").val());
	function choseBrand(){
	jQuery("#errorlabel").attr("style","color:#FF6600;display:none;") ;
	jQuery("#faker-zd_probrand").removeClass("error");
	}
	function checkCanPublish(obj){
		jQuery.ajax({
		 type:"post" ,
		 url:"/tools/ajax_action.jsp",
		 data:{"title":jQuery(obj).val(),"mypy":jQuery("#mypy").val(),"mem_no":jQuery("#zd_mem_no").val()},
		 success:function(msg){
		    if(typeof msg !="undefinded" && parseInt(jQuery.trim(msg))>0 &&jQuery.trim(jQuery("#zd_title").val())!='' && '0'==jQuery("#zd_id").val()){
		    	jQuery("#canPublish").val("0")
			    jQuery.jBox.tip("对不起，您不能发布重复的信息！") ;		 
			 	jQuery(obj).css({background: "none repeat scroll 0 0 #FDCDCB",border: "1px solid #B9747A"}) ;	
			 	setTimeout(function(){
			 		jQuery(obj).select() ;
			 		jQuery(obj).focus() ;
			 	},2000) ;
		    }else{
		    	jQuery("#canPublish").val("1") ;
		    }
		 }
		})
	}
	jQuery("#zd_title").focus(function(){
		jQuery(this).removeAttr("style") ;
	}) ;
	function check(obj){
	 if('0'==jQuery.trim(jQuery("#zd_id").val())){
		 jQuery.jBox.tip("对不起，您不能发布重复的信息！") ;		 
			 	jQuery(obj).css({background: "none repeat scroll 0 0 #FDCDCB",border: "1px solid #B9747A"}) ;	
			 	setTimeout(function(){
			 		jQuery(obj).select() ;
			 		jQuery(obj).focus() ;
			 	},2000) ;
		}
	}
	function setBrand(obj){ 
	    if(document.getElementById("zd_probrand").selectedIndex>0){
	    	jQuery("#zd_probrandname").val(jQuery(obj).find("option:selected").text().substring(2)) ;
	    }
		if(jQuery.trim(jQuery(obj).val())=='0'){
		   jQuery("#otherBrand").show() ;
		}else{ 
	       jQuery("#otherBrand").hide() ;
	       jQuery("label[for='otherBrand']").hide() ;
		}
	}
	jQuery("#otherBrand").keyup(function(){
	 jQuery("#zd_probrandname").val(jQuery("#otherBrand").val()) ;
	}) ;
  function setCatalog(obj){
  	if(jQuery(obj).val()=='0'){ 
  		jQuery("#otherCatalog").show() ;
  	}else{
  	  jQuery("#zd_product_flag_name").val(jQuery(obj).find(":selected").html()) ;
  	  jQuery("#otherCatalog").hide() ;
	  jQuery("label[for='otherCatalog']").hide() ;
  	}
  } 
  jQuery("#otherCatalog").keyup(function(){
  	jQuery("#zd_product_flag_name").val(jQuery(this).val()) ;
  }) ;
  jQuery("input[type='radio']").change(function(){ 
  	if('106'==jQuery(this).val()){   
  		jQuery("#other_part_flag").show() ;
  	}else{  
  		jQuery("#zd_part_flag_name").val(jQuery.trim(this.nextSibling.nodeValue)) ;
  		jQuery("#other_part_flag").hide() ; 
  		jQuery("label[for='other_part_flag']").hide() ;
  	}
  }) ;
  jQuery("#other_part_flag").keyup(function(){
  	jQuery("#zd_part_flag_name").val(jQuery(this).val()) ;
  }) ;
</script>