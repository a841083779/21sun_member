<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}
//新配件网
PoolManager pool_part = new PoolManager(12);

String addflag = Common.getFormatInt(request.getParameter("addflag")); //操作标识
Connection conn =null;
Connection conn_part =null;
PreparedStatement pstmt = null;	
ResultSet rs = null;
ResultSetMetaData rsmd = null;

String mem_no_session="",mem_name_session="",comp_prop_session="";
String comp_mode_session="",comp_owncategory_session="",comp_ownsubcategory_session="",per_province_session="";
String per_city_session="",comp_address_session="",comp_postcode_session="",comp_mem_name_session="",comp_depart_session="",comp_posi_session="";
String comp_phone_session="",comp_mobile_phone_session="",comp_fax_session="",comp_qq_session="",comp_msn_session="",comp_email_session="";
String comp_url_session="",comp_mainbusiness_session="",comp_intro_session="",member_type_apply_session="";
String zd_comp_logo = "";
String per_phone_session="",perMobilePhoneSession="",perQQSession="",perMsnSession="",perEmailSession="";
String main_product_session = "";

String zd_mem_no="";
String zd_mem_name="";
String zd_comp_name="",zd_comp_prop = "",zdCompModeValue="",zd_comp_owncategory="",zd_comp_ownsubcategory="",zd_per_province="",zd_per_city="",zd_comp_address="",zd_main_product="";
String zd_comp_postcode="",zd_comp_mem_name = "";
String zd_comp_depart="",zd_comp_posi="",zd_comp_phone="",zd_comp_mobile_phone="",zd_comp_fax="";
String zd_comp_qq="",zd_comp_msn="",zd_comp_email="",zd_comp_url="",zd_comp_mainbusiness="",zd_comp_intro="",zd_member_type_apply="",zd_comp_mode="";
String zd_mem_type="";
String zd_per_sex="";

String flagvalue = Common.getFormatInt(request.getParameter("flagvalue"));  //是否为修改
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String sqlMemInfo="",sqlMemInfoSub="";
String mem_no_sub="";
String per_sex = "";

String querySql="";

try{
	conn = pool.getConnection();
	conn_part = pool_part.getConnection();
	mem_no_sub       = Common.getFormatStr(memberInfo.get("mem_no_sub"));
	mem_no_session            = Common.getFormatStr(memberInfo.get("mem_no"));
	mem_name_session          = Common.getFormatStr(memberInfo.get("mem_name"));
	comp_prop_session         = Common.getFormatStr(memberInfo.get("comp_prop"));
	comp_mode_session         = Common.getFormatStr(memberInfo.get("comp_mode"));  
	comp_owncategory_session  = Common.getFormatStr(memberInfo.get("comp_owncategory"));
	comp_ownsubcategory_session  = Common.getFormatStr(memberInfo.get("comp_ownsubcategory"));
	
	per_province_session	  = Common.getFormatStr(memberInfo.get("per_province"));
	per_city_session          = Common.getFormatStr(memberInfo.get("per_city"));
	comp_address_session      = Common.getFormatStr(memberInfo.get("comp_address"));
	comp_postcode_session     = Common.getFormatStr(memberInfo.get("comp_postcode"));
	comp_mem_name_session     = Common.getFormatStr(memberInfo.get("comp_mem_name"));
	comp_depart_session       = Common.getFormatStr(memberInfo.get("comp_depart"));
	comp_posi_session         = Common.getFormatStr(memberInfo.get("comp_posi"));
	comp_phone_session        = Common.getFormatStr(memberInfo.get("comp_phone"));
	comp_mobile_phone_session = Common.getFormatStr(memberInfo.get("comp_mobile_phone"));	
	main_product_session      = Common.getFormatStr(memberInfo.get("main_product"));
  
	comp_fax_session         = Common.getFormatStr(memberInfo.get("comp_fax"));
	comp_qq_session          = Common.getFormatStr(memberInfo.get("per_qq"));
	comp_msn_session         = Common.getFormatStr(memberInfo.get("comp_msn"));
	comp_email_session       = Common.getFormatStr(memberInfo.get("comp_email"));	
	
	comp_url_session           = Common.getFormatStr(memberInfo.get("comp_url"));
	comp_mainbusiness_session  = Common.getFormatStr(memberInfo.get("comp_mainbusiness"));
	comp_intro_session         = Common.getFormatStr(memberInfo.get("comp_intro"));
	
	per_phone_session          = Common.getFormatStr(memberInfo.get("per_phone"));
	perMobilePhoneSession      = Common.getFormatStr(memberInfo.get("per_mobile_phone"));
	perMsnSession              = Common.getFormatStr(memberInfo.get("per_msn"));
	perQQSession               = Common.getFormatStr(memberInfo.get("per_qq"));
	perEmailSession            = Common.getFormatStr(memberInfo.get("per_email"));
	zd_mem_type				   = Common.getFormatStr(memberInfo.get("mem_type"));
	per_sex          		   = Common.getFormatStr(memberInfo.get("per_sex"));
	
	member_type_apply_session=Common.getFormatStr(memberInfo.get("member_type_apply"));
 
   int result=0;
   if(flagvalue.equals("1")){
      //System.out.println("flagvalue==="+flagvalue);
	          
	   zd_mem_no = Common.getFormatStr(request.getParameter("zd_mem_no"));
	   zd_mem_name = Common.getFormatStr(request.getParameter("zd_mem_name"));	
	   zd_comp_name = Common.getFormatStr(request.getParameter("zd_comp_name"));
	   zd_comp_logo = Common.getFormatStr(request.getParameter("zd_comp_logo"));
	   zd_comp_mode = Common.getFormatStr(request.getParameter("zd_comp_mode"));
	   zd_comp_prop = Common.getFormatStr(request.getParameter("zd_comp_prop"));   //member_info_sub
	   zdCompModeValue = Common.getFormatStr(request.getParameter("zdCompModeValue"));   //member_info_sub
	   zd_comp_owncategory = Common.getFormatStr(request.getParameter("zd_comp_owncategory"));  //member_info_sub
	   zd_comp_ownsubcategory = Common.getFormatStr(request.getParameter("zd_comp_ownsubcategory"));  //member_info_sub
	   zd_per_province = Common.getFormatStr(request.getParameter("zd_province"));
	   zd_per_city = Common.getFormatStr(request.getParameter("zd_city"));
	   zd_comp_address = Common.getFormatStr(request.getParameter("zd_comp_address"));	   
	   zd_comp_postcode = Common.getFormatStr(request.getParameter("zd_comp_postcode"));	   
	   zd_comp_mem_name = Common.getFormatStr(request.getParameter("zd_comp_mem_name")); //member_info_sub
	   zd_main_product = Common.getFormatStr(request.getParameter("zd_main_product"));	
	   
	   zd_comp_depart = Common.getFormatStr(request.getParameter("zd_comp_depart")); //member_info_sub
	   zd_comp_posi = Common.getFormatStr(request.getParameter("zd_comp_posi"));    //member_info_sub
	   zd_comp_phone = Common.getFormatStr(request.getParameter("zd_comp_phone"));  //member_info_sub
	   zd_comp_mobile_phone = Common.getFormatStr(request.getParameter("zd_comp_mobile_phone")); //member_info_sub
	   zd_comp_fax = Common.getFormatStr(request.getParameter("zd_comp_fax"));
	   zd_comp_qq = Common.getFormatStr(request.getParameter("zd_comp_qq")); //member_info_sub
	   zd_comp_msn = Common.getFormatStr(request.getParameter("zd_comp_msn")); //member_info_sub
	   zd_comp_email = Common.getFormatStr(request.getParameter("zd_comp_email")); //member_info_sub
	   zd_comp_url = Common.getFormatStr(request.getParameter("zd_comp_url")); 
	   zd_comp_mainbusiness = Common.getFormatStr(request.getParameter("zd_comp_mainbusiness")); //member_info_sub
	   zd_comp_intro = Common.getFormatStr(request.getParameter("zd_comp_intro"));
	   zd_member_type_apply= Common.getFormatStr(request.getParameter("zd_member_type_apply"));
	   zd_mem_type	= Common.getFormatStr(request.getParameter("zd_mem_type"));
	   zd_per_sex	= Common.getFormatStr(request.getParameter("zd_per_sex"));
	
	  if(!zd_mem_no.equals("")){   
		 sqlMemInfo = "update member_info set comp_logo='"+Common.getFormatStr(request.getParameter("zd_comp_logo"))+"',mem_type='"+zd_mem_type+"',per_qq='"+zd_comp_qq+"', per_email='"+zd_comp_email+"', per_phone='"+zd_comp_phone+"',  comp_mobile_phone='"+zd_comp_mobile_phone+"', mem_name='"+zd_mem_name+"', comp_name='"+zd_comp_name+"',per_province='"+zd_per_province+"',per_city='"+zd_per_city+"',comp_address='"+zd_comp_address+"',main_product='"+zd_main_product+"',comp_fax='"+zd_comp_fax+"',comp_url='"+zd_comp_url+"',comp_intro='"+zd_comp_intro+"',comp_mode='"+zd_comp_mode+"',per_sex='"+zd_per_sex+"' where mem_no='"+zd_mem_no+"'";
		 result = DataManager.dataOperation(pool,sqlMemInfo);
		 		
		 if(mem_no_sub.equals(zd_mem_no)){ //扩展表和主表的mem_no相同
			 sqlMemInfoSub = "update member_info_sub set comp_phone='"+zd_comp_phone+"',comp_mobile_phone='"+zd_comp_mobile_phone+"',comp_qq='"+zd_comp_qq+"',comp_email='"+zd_comp_email+"',comp_mode='"+zd_comp_mode+"' where mem_no ='"+zd_mem_no+"'";
		     result = DataManager.dataOperation(pool,sqlMemInfoSub);
		 }else{
		    sqlMemInfoSub = "insert member_info_sub (mem_no,comp_mode,comp_phone,comp_mobile_phone,comp_qq,comp_email) values('"+zd_mem_no+"','"+zd_comp_mode+"','"+zd_comp_phone+"','"+zd_comp_mobile_phone+"','"+zd_comp_qq+"','"+zd_comp_email+"')";			
		    result =DataManager.dataOperation(pool,sqlMemInfoSub);
		 } 
		 		 
		 
	   }
     }	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员注册 - 中国工程机械商贸网</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<link href="../style/style_new.css" rel="stylesheet" type="text/css" />
<script src="/scripts/jquery-1.4.1.min.js"></script>
<script src="/scripts/common.js"  type="text/javascript"></script>
<script type="text/javascript" src="/scripts/citys.js"  type="text/javascript"></script>
<script type="text/javascript" src="/scripts/regmoreyanzheng.js"  type="text/javascript"></script>
<!--city-->
<link href="/scripts/select_city/search.css" rel="stylesheet" type="text/css"/>
<script src="/scripts/select_city/options.js" type="text/javascript"></script>
<script type="text/javascript">var JQ = jQuery</script>
<script src="/scripts/select_city/location_array.js" type="text/javascript"></script>
<!--city-->
</head>
<body style="background-color:transparent;">
<!--<div class="registForm">
  <div class="registBg">-->
    <!---->
    <div class="moreInfo">
  <div class="registTitle">完善信息 <span>发布出售、求购、租赁等信息，便于更快地联系到您！</span></div>
  <div class="zccg"><b>为了让您获得更精准的服务的商业机会，我们建议您立即完善以下信息：</b></div>
    <form method="post" name="theform" id="theform" onsubmit="return submityz2();">
      <table width="950" border="0" cellspacing="0" cellpadding="0" class="registMore">
      	<tr>
          <th width="140">用户类型：</th>
          <td width="780">
          <input name="zd_mem_type" type="radio" value="1" checked="checked"/>企业&nbsp;&nbsp;
          <input name="zd_mem_type" type="radio" value="2" onclick="checkMemType();"/>个人
          </td>
        </tr>
        <tr>
          <th width="140">用户名：</th>
          <td width="780"><%=memberInfo.get("mem_no")%>
          <input name="addflag" type="hidden" id="addflag" value="<%=addflag%>" /></td>
        </tr>
        <tr>
          <th><font>*</font>姓名：</th>
          <td>
          	<input name="zd_mem_name" type="text" class="ri" id="zd_mem_name" onblur="formyanzheng('zd_mem_name')" value="<%=mem_name_session %>" onfocus="showText('zd_mem_name')"/>
          	<div style="display:none;" id="zd_mem_name_dui" class="diu"></div>
            <div style="display:none;" id="zd_mem_name_cuo" class="cuo"></div>
            <div style="display:none;" id="zd_mem_name_cuo_info" class="cuo1"></div>
            <div class="showinfo" id="zd_mem_name_show_info" style="display:none">请如实填写，方便客户联系，我们将保障您的信息隐私。</div>	
          </td>
        </tr>
        <tr>
          <th>性别：</th>
          <td>
          	<input name="zd_per_sex" type="radio" value="男" <%if(per_sex.equals("")|| per_sex.equals("男")){ %>checked="checked"<%} %>/>男&nbsp;&nbsp;
          	<input name="zd_per_sex" type="radio" value="女" <%if(per_sex.equals("女")){ %>checked="checked"<%} %>/>女
          </td>
        </tr>
        <tr>
          <th><font>*</font>手机号：</th>
          <td>
          	<input type="text" name="zd_comp_phone" id="zd_comp_phone" onblur="formyanzheng('zd_comp_phone')" class="ri" value="<%=per_phone_session %>" onfocus="showText('zd_comp_phone')"/>
          	<div style="display:none;" id="zd_comp_phone_dui" class="diu"></div>
            <div style="display:none;" id="zd_comp_phone_cuo" class="cuo"></div>
            <div style="display:none;" id="zd_comp_phone_cuo_info" class="cuo1"></div>
            <div class="showinfo" id="zd_comp_phone_show_info" style="display:none">请按格式 '18605451292' 如实填写，方便客户联系。</div>	
          </td>
        </tr>
        <!-- <tr>
          <th><font>*</font>所在地：</th>
          <td>
	          <div style="float:left;">
	          	<div style="float:left;">
	            <span class="list_cell_bg">
                   <div class="select_box w_138" id="province_city" name="province_city" style="width:247px;">      
                    <script>			
                      var workLocSelect = new LocationSelect('search_form', 'work');
                      workLocSelect.build();
                     </script>			    
                  </div>
	            </span>
	            </div>
	             
	          </div>
              <input type="hidden" name="zd_province" id="zd_province" value=""/>
			  <input type="hidden" name="zd_city" id="zd_city" value=""/> 
	          <div style="display:none;" id="zd_city_dui" class="diu"></div>
              <div style="display:none;" id="zd_city_cuo" class="cuo"></div>
              <div style="display:none;" id="zd_city_cuo_info" class="cuo1"></div>
          </td>
        </tr> -->
        <tr>
        	<th><font>*</font>所在地：</th>
        	<td>
        		<select name="zd_province" id="zd_province" style="height:23px; line-height:23px; float:left;" onchange="set_city(this,this.value,theform.zd_city,'');">
                      <option value="">请选择省份</option>
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
              <select  name="zd_city" id="zd_city" style="float:left; height:23px; line-height:23px; margin-left:5px;" onblur="formyanzheng('zd_city');">
                <option value="">请选择城市</option>
              </select>
              <div style="display:none;" id="zd_city_dui" class="diu"></div>
              <div style="display:none;" id="zd_city_cuo" class="cuo"></div>
              <div style="display:none;" id="zd_city_cuo_info" class="cuo1"></div>
        	</td>
        </tr>
        <tr>
        	<th><font>*</font>详细地址：</th>
        	<td>
        		<input type="text" id="zd_comp_address" name="zd_comp_address" class="ri" value="<%=comp_address_session %>" onblur="formyanzheng('zd_comp_address');" onfocus="showText('zd_comp_address');" />
				<div style="display:none;" id="zd_comp_address_dui" class="diu"></div>
                <div style="display:none;" id="zd_comp_address_cuo" class="cuo"></div>
                <div style="display:none;" id="zd_comp_address_cuo_info" class="cuo1"></div>
        		<div class="showinfo" id="zd_comp_address_show_info" style="display:none">如：山东烟台莱山区同和路26号</div>
        	</td>
        </tr>
        <tr>
          <th><font>*</font>邮箱：</th>
          <td>
          	<input name="zd_comp_email" type="text" class="ri" id="zd_comp_email" onblur="formyanzheng('zd_comp_email')" value="<%=comp_email_session.equals("")?perEmailSession:comp_email_session%>" onfocus="showText('zd_comp_email')"/>
          	<div style="display:none;" id="zd_comp_email_dui" class="diu"></div>
            <div style="display:none;" id="zd_comp_email_cuo" class="cuo"></div>
            <div style="display:none;" id="zd_comp_email_cuo_info" class="cuo1"></div>
            <div class="showinfo" id="zd_comp_email_show_info" style="display:none">请输入您的常用邮箱。</div>		
          </td>
        </tr>
        <tr>
          <th><font>*</font>公司名称：</th>
          <td>
          	<input type="text" name="zd_comp_name" id="zd_comp_name" class="ri" onblur="formyanzheng('zd_comp_name')" value="<%=Common.getFormatStr(memberInfo.get("comp_name"))%>" onfocus="showText('zd_comp_name')"/>
          	<div style="display:none;" id="zd_comp_name_dui" class="diu"></div>
            <div style="display:none;" id="zd_comp_name_cuo" class="cuo"></div>
            <div style="display:none;" id="zd_comp_name_cuo_info" class="cuo1"></div>
            <div class="showinfo" id="zd_comp_name_show_info" style="display:none">请如实填写，方便客户联系，我们将保障您的信息隐私。</div>	
          </td>
        </tr>
        <tr>
        	<th><font>*</font>主营产品：</th>
        	<td>
        		<input type="text" id="zd_main_product" name="zd_main_product" class="ri" value="<%=Common.getFormatStr(memberInfo.get("main_product"))%>" onblur="formyanzheng('zd_main_product');" onfocus="showText('zd_main_product');" maxlength="100" />
				<div style="display:none;" id="zd_main_product_dui" class="diu"></div>
                <div style="display:none;" id="zd_main_product_cuo" class="cuo"></div>
                <div style="display:none;" id="zd_main_product_cuo_info" class="cuo1"></div>
        		<div class="showinfo" id="zd_main_product_show_info" style="display:none">请至少输入一项贵公司主营产品，如：发动机，液压泵，底盘件</div>
        	</td>
        </tr>
        <tr>
          <th><font>*</font>主营行业：</th>
          <td>
          <div id="mrm_select" onmouseover="document.getElementById('mrm_select').className='scur'" onmouseout="document.getElementById('mrm_select').className=''">
            <span class="t"><%if(comp_mode_session.equals("")){%>请选择<%}else{%>已选择<%}%></span>
            <div class="selectContain">
              <ul class="selist">
                <li>
                  <strong>整机生产：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101001" <%=comp_mode_session.equals("101001")?"checked":""%>/>  挖掘机</span>
            	    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101002" <%=comp_mode_session.equals("101002")?"checked":""%>/> 装载机</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101003" <%=comp_mode_session.equals("101003")?"checked":""%>/> 起重机 </span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101004" <%=comp_mode_session.equals("101004")?"checked":""%>/> 推土机</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101005" <%=comp_mode_session.equals("101005")?"checked":""%>/>  路面机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101006" <%=comp_mode_session.equals("101006")?"checked":""%>/> 混凝土机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101007" <%=comp_mode_session.equals("101007")?"checked":""%>/> 桩工机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101008" <%=comp_mode_session.equals("101008")?"checked":""%>/> 破碎设备</span> 
            		<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="101009" <%=comp_mode_session.equals("101009")?"checked":""%>/> 矿山机械</span>
            		<span><input name="cd_comp_mode" id="cd_comp_mode" type="checkbox" value="101010" <%=comp_mode_session.equals("101010")?"checked":""%>/>其他</span>
                  </div>
                </li>
                <li>
                  <strong>整机销售：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102001" <%=comp_mode_session.equals("102001")?"checked":""%>/>   挖掘机</span>
            	    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102002" <%=comp_mode_session.equals("102002")?"checked":""%>/> 装载机</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102003" <%=comp_mode_session.equals("102003")?"checked":""%>/> 起重机 </span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102004" <%=comp_mode_session.equals("102004")?"checked":""%>/>  推土机</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102005" <%=comp_mode_session.equals("102005")?"checked":""%>/> 路面机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102006" <%=comp_mode_session.equals("102006")?"checked":""%>/>混凝土机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102007" <%=comp_mode_session.equals("102007")?"checked":""%>/>桩工机械</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102008" <%=comp_mode_session.equals("102008")?"checked":""%>/>破碎设备</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="102009" <%=comp_mode_session.equals("102009")?"checked":""%>/>矿山机械</span>
            		<span><input name="cd_comp_mode" id="cd_comp_mode" type="checkbox" value="102010" <%=comp_mode_session.equals("102010")?"checked":""%>/>其他</span>
                  </div>
                </li>
                <li>
                  <strong>配件：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="103001" <%=comp_mode_session.equals("103001")?"checked":""%>/>  配套件</span>
            	    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="103002" <%=comp_mode_session.equals("103002")?"checked":""%>/> 配件零售</span>
            		<span><input name="cd_comp_mode" id="cd_comp_mode" type="checkbox" value="103003" <%=comp_mode_session.equals("103003")?"checked":""%>/>其他</span>
                  </div>
                </li>
                <li>
                  <strong>代理商：</strong>
                  <div class="sc">
                   <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="104001" <%=comp_mode_session.equals("104001")?"checked":""%>/>  代理商</span>
                  </div>
                </li>
                <li>
                  <strong>终端用户：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="105001" <%=comp_mode_session.equals("105001")?"checked":""%>/>  施工单位</span>
            	    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="105002" <%=comp_mode_session.equals("105002")?"checked":""%>/> 承包商</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="105003" <%=comp_mode_session.equals("105003")?"checked":""%>/> 其他</span>
                  </div>
                </li>
                <li>
                  <strong>租赁企业：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="106001" <%=comp_mode_session.equals("106001")?"checked":""%>/> 租赁企业</span>
                  </div>
                </li>
                <li>
                  <strong>二手机：</strong>
                  <div class="sc">
                    <span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="107001" <%=comp_mode_session.equals("107001")?"checked":""%>/>  上游</span>
					<span><input name="cd_comp_mode" id="cd_comp_mode"  onclick="compModeHidden()" type="checkbox" value="107002" <%=comp_mode_session.equals("107002")?"checked":""%>/> 其他 </span>
                  </div>
                </li>
              </ul>
            </div>
          </div>
          <span style="float:left; line-height:24px; padding-left:10px; color:#aaa">【可多选】</span>
            </td>
        </tr>
        <tr>
          <th>公司网址：</th>
          <td><input type="text" name="zd_comp_url" id="zd_comp_url" class="ri" value="<%=comp_url_session%>" /></td>
        </tr>
        <tr>
          <th><font>*</font>办公电话：</th>
          <td>
          	<input name="zd_comp_mobile_phone" type="text" class="ri" id="zd_comp_mobile_phone" onblur="formyanzheng('zd_comp_mobile_phone')" value="<%=comp_mobile_phone_session %>"  onfocus="showText('zd_comp_mobile_phone')"/>
          	<div style="display:none;" id="zd_comp_mobile_phone_dui" class="diu"></div>
            <div style="display:none;" id="zd_comp_mobile_phone_cuo" class="cuo"></div>
            <div style="display:none;" id="zd_comp_mobile_phone_cuo_info" class="cuo1"></div>
            <div class="showinfo" id="zd_comp_mobile_phone_show_info" style="display:none">请按格式 '0535-6792736' 如实填写，方便客户联系。</div>
          </td>
        </tr>
        <tr>
          <th>QQ：</th>
          <td><input type="text" name="zd_comp_qq" id="zd_comp_qq" class="ri" value="<%=perQQSession %>" /></td>
        </tr>
        <tr>
          <th>传真：</th>
          <td><input type="text" name="zd_comp_fax" id="zd_comp_fax" class="ri" value="<%=comp_fax_session%>" /></td>
        </tr>
        <tr>
          <th>公司LOGO：</th>
          <td>
          	<img id="my_logo_img" onerror="this.src='/images/no_big.gif'" src="<%=Common.getFormatStr(memberInfo.get("comp_logo"))%>" style="width: 90px;height: 30px;" />
          	<input type="hidden" name="zd_comp_logo" id="zd_comp_logo" value="<%=Common.getFormatStr(memberInfo.get("comp_logo"))%>" />
          	<span style="margin-left: 3px;position: relative;top:0px;"></span><span id="logo_img"></span>LOGO尺寸（90*30）
          </td>
        </tr>
        <tr>
          <th><font>*</font>公司介绍：</th>
          <td>
          	<div style="float:left;">
          	<textarea name="zd_comp_intro" id="zd_comp_intro" onfocus="showText('zd_comp_intro')" onblur="formyanzheng('zd_comp_intro')" cols="45" rows="5" class="registTextarea"><%=Common.filterHtmlString(comp_intro_session).replace("<br />","\r\n")%></textarea>
          	</div>
          	<div style="display:none;" id="zd_comp_intro_dui" class="diu"></div>
            <div style="display:none;" id="zd_comp_intro_cuo" class="cuo"></div>
            <div style="display:none;" id="zd_comp_intro_cuo_info" class="cuo1"></div>
            <div class="showinfo" id="zd_comp_intro_show_info" style="display:none">公司介绍不能少于10个字。</div>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><input type="submit" name="button" id="button" value="提交" class="registBtn" /></td>
        </tr>
      </table>
      	<input name="flagvalue" type="hidden" id="flagvalue"  value="1"/>
		<input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=mem_no_session%>" />
		<input name="zdCompModeValue" type="hidden" id="zdCompModeValue"/>
		<input type="hidden" name="zd_comp_mode" id="zd_comp_mode" value=""/>
    </form>
    </div>
    <!---->
<!--  </div>  
<div class="clear"></div>  
</div>-->
<script src="/scripts/city/citys.js" type="text/javascript"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script   language="javascript">
jQuery("#logo_img").JrUpload({
	remotUrl : "http://resource.21-sun.com/upload.jsp",
	folder : "member" ,
	watermark:false,
	callback : "setLogoImg"
});
function setLogoImg(data){
	jQuery("#my_logo_img").attr("src","http://resource.21-sun.com"+data);
	jQuery("#zd_comp_logo").val("http://resource.21-sun.com"+data);
}

function checkMemType()
{
	window.location.href = 'member_reg_more_person.jsp';
}
function compModeHidden()
{
	//var cuoObj = document.getElementById("zdCompModeValue_cuo");
	//var cuoInfoObj = document.getElementById("zdCompModeValue_cuo_info");
	//cuoObj.style.display = "none";
	//cuoInfoObj.style.display = "none";
}

//根据传入的字段，返回是否在字符串中
function fieldInFields(fields,field){
result=false;
if(fields!=null && field!=null){
	tp=fields.split(",");
	for(i=0;i<tp.length;i++){
		if(field==(tp[i])){
			result=true;
			break;
		}
	}	
}
return result;
}

function setChecks(sorts,name){
var obj=document.getElementsByName(name); 

for(var i=0;i<obj.length;i++){ 
	if(fieldInFields(sorts,obj[i].value)) 
	{ 
		obj[i].checked=true; 
	} 
}
}
setChecks('<%=comp_mode_session%>','cd_comp_mode');

</script>
<script type="text/javascript">
if('<%=per_province_session%>'!=''&&'<%=per_city_session%>'!=''){
	jQuery("#cond_search_form_work_location_show").html('<%=per_province_session%><%=per_city_session%>');
	jQuery("#zd_province").val('<%=per_province_session%>');
	$("#zd_province").change();
	jQuery("#zd_city").val('<%=per_city_session%>');
}
function submityz2(){
	var len = jQuery("input[type='checkbox']:checked").length ;
	var comp_mode = "," ;
	if(len==0)
	{
	alert("请至少选择一项主营行业！") ;
	return false ;
	}
	jQuery("input[type='checkbox']:checked").each(function(){
	//  alert(jQuery(this).val()) ;
		comp_mode += jQuery(this).val() +",";
	}) ;
	jQuery("#zd_comp_mode").val(comp_mode) ;
	//
  	var isOK = 0;
	if(!formyanzheng('zd_mem_name')){
		isOK = isOK+1;
		return false;
	}
	if(!formyanzheng('zd_comp_phone')){
		isOK = isOK+1;
		return false;
	}
	if(!formyanzheng('zd_city')){
		isOK = isOK+1;
		return false;
	}
	if(!formyanzheng('zd_comp_address')){
		isOK = isOK + 1;
		return false;
	}
	if(!formyanzheng('zd_comp_email')){
		isOK = isOK+1;
		return false;
	}
	if(!formyanzheng('zd_comp_name')){
		isOK = isOK+1;
		return false;
	}
	if(!formyanzheng('zd_main_product')){
		isOK = isOK + 1;
		return false;
	}
	if(!formyanzheng('zd_comp_mobile_phone')){
		isOK = isOK+1;
		return false;
	}
	//if(!formyanzheng('zdCompModeValue')){
	//	isOK = isOK+1;
	//}
	if(!formyanzheng('zd_comp_intro')){
		isOK = isOK+1;
		return false;
	}

	var mem_name = jQuery("#zd_mem_name").val() ;
	var comp_name = jQuery("#zd_comp_name").val() ;
	var comp_intro = jQuery("#zd_comp_intro").val() ;
	var info = (mem_name+comp_name).replace(/\s+/g,"") ;	
	var cango = '' ;
	jQuery.ajax({
		url:'/tools/ajax.jsp' ,
		type:'POST',
		async:false,
		data:{info:info,flag:'checkInputInfo'},
		success:function(msg){
		 if(jQuery.trim(msg)=='so'){
		     alert("请您不要发布国家禁止的敏感词汇或与工程机械行业无关的信息，请重新填写。") ;
		     cango = 1 ;
		     return false ;
		 }
		}
	}) ;
	if(cango==1){
	 	return false ;
	}else{
		return true ;
	}
}
</script>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	pool_part.freeConnection(conn_part);
}
%>
