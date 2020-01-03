<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %><%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}
String addflag = Common.getFormatInt(request.getParameter("addflag")); //操作标识
Connection conn =null;
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

String zd_mem_no="";
String zd_comp_name="",zd_comp_prop = "",zdCompModeValue="",zd_comp_owncategory="",zd_comp_ownsubcategory="",zd_per_province="",zd_per_city="",zd_comp_address="";
String zd_comp_postcode="",zd_comp_mem_name = "";
String zd_comp_depart="",zd_comp_posi="",zd_comp_phone="",zd_comp_mobile_phone="",zd_comp_fax="";
String zd_comp_qq="",zd_comp_msn="",zd_comp_email="",zd_comp_url="",zd_comp_mainbusiness="",zd_comp_intro="",zd_member_type_apply="";

String flagvalue = Common.getFormatInt(request.getParameter("flagvalue"));  //是否为修改
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String sqlMemInfo="",sqlMemInfoSub="";
String mem_no_sub="";

String querySql="";

try{
	conn = pool.getConnection();	
	
	mem_no_sub       = Common.getFormatStr(memberInfo.get("mem_no_sub"));
	//System.out.println("mem_no_sub==="+mem_no_sub);
	
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
  
	comp_fax_session         = Common.getFormatStr(memberInfo.get("comp_fax"));
	comp_qq_session          = Common.getFormatStr(memberInfo.get("comp_qq"));
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
	
	member_type_apply_session=Common.getFormatStr(memberInfo.get("member_type_apply"));
 
   int result=0;
   if(flagvalue.equals("1")){
      // System.out.println("flagvalue==="+flagvalue);
	          
	   zd_mem_no = Common.getFormatStr(request.getParameter("zd_mem_no"));	   
	   zd_comp_name = Common.getFormatStr(request.getParameter("zd_comp_name"));
	   zd_comp_logo = Common.getFormatStr(request.getParameter("zd_comp_logo"));
	   
	   zd_comp_prop = Common.getFormatStr(request.getParameter("zd_comp_prop"));   //member_info_sub
	   zdCompModeValue = Common.getFormatStr(request.getParameter("zdCompModeValue"));   //member_info_sub
	   zd_comp_owncategory = Common.getFormatStr(request.getParameter("zd_comp_owncategory"));  //member_info_sub
	   zd_comp_ownsubcategory = Common.getFormatStr(request.getParameter("zd_comp_ownsubcategory"));  //member_info_sub
	   zd_per_province = Common.getFormatStr(request.getParameter("zd_per_province"));
	   zd_per_city = Common.getFormatStr(request.getParameter("zd_per_city"));
	   zd_comp_address = Common.getFormatStr(request.getParameter("zd_comp_address"));	   
	   zd_comp_postcode = Common.getFormatStr(request.getParameter("zd_comp_postcode"));	   
	   zd_comp_mem_name = Common.getFormatStr(request.getParameter("zd_comp_mem_name")); //member_info_sub
	   
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
	
	  if(!zd_mem_no.equals("")){   
		 sqlMemInfo = "update member_info set comp_logo='"+zd_comp_logo+"',comp_name='"+zd_comp_name+"',per_province='"+zd_per_province+"',per_city='"+zd_per_city+"',comp_address='"+zd_comp_address+"',comp_postcode='"+zd_comp_postcode+"',comp_fax='"+zd_comp_fax+"',comp_url='"+zd_comp_url+"',comp_intro='"+zd_comp_intro+"' where mem_no='"+zd_mem_no+"'";
		result = DataManager.dataOperation(pool,sqlMemInfo);
		 		
		 if(mem_no_sub.equals(zd_mem_no)){ //扩展表和主表的mem_no相同
		   sqlMemInfoSub = "update member_info_sub set comp_prop='"+zd_comp_prop+"',comp_mode='"+zdCompModeValue+"',comp_owncategory='"+zd_comp_owncategory+"',comp_ownsubcategory='"+zd_comp_ownsubcategory+"',comp_mem_name='"+zd_comp_mem_name+"',comp_depart='"+zd_comp_depart+"',comp_posi='"+zd_comp_posi+"',comp_phone='"+zd_comp_phone+"',comp_mobile_phone='"+zd_comp_mobile_phone+"',comp_qq='"+zd_comp_qq+"',comp_msn='"+zd_comp_msn+"',comp_email='"+zd_comp_email+"',comp_mainbusiness='"+zd_comp_mainbusiness+"',member_type_apply='"+zd_member_type_apply+"' where mem_no ='"+zd_mem_no+"'";
		 // System.out.println(sqlMemInfoSub);
		   
		   result = DataManager.dataOperation(pool,sqlMemInfoSub);
		 }else{
		    sqlMemInfoSub = "insert member_info_sub (mem_no,comp_prop,comp_mode,comp_owncategory,comp_ownsubcategory,comp_mem_name,comp_depart,comp_posi,comp_phone,comp_mobile_phone,comp_qq,comp_msn,comp_email,comp_mainbusiness,member_type_apply) values('"+zd_mem_no+"','"+zd_comp_prop+"','"+zdCompModeValue+"','"+zd_comp_owncategory+"','"+zd_comp_ownsubcategory+"','"+zd_comp_mem_name+"','"+zd_comp_depart+"','"+zd_comp_posi+"','"+zd_comp_phone+"','"+zd_comp_mobile_phone+"','"+zd_comp_qq+"','"+zd_comp_msn+"','"+zd_comp_email+"','"+zd_comp_mainbusiness+"','"+zd_member_type_apply+"')";			
		    result =DataManager.dataOperation(pool,sqlMemInfoSub);
		 } 
		 		 
		if(result>0){
		
			querySql = "select * from vi_member_info where mem_no=?";	
			pstmt = conn.prepareStatement(querySql);
			pstmt.setString(1, (String)memberInfo.get("mem_no"));	
			rs = pstmt.executeQuery();
						
			if (rs != null && rs.next()) {
			  rsmd = rs.getMetaData();
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
			  memberInfo.put(rsmd.getColumnName(i), rs.getString(rsmd.getColumnName(i)));
			}
			 session.setAttribute("memberInfo",memberInfo);
			}
		
		   if(!addflag.equals("0")){
		 	 out.print("<script>alert('公司资料设置成功!');window.parent.parent.location.href='/manage/membermain.jsp?addflag="+addflag+"';</script>");
		  }else{
		    out.print("<script>alert('公司资料设置成功!');window.location.href='comp_info_opt.jsp';</script>");
		  }
		}else{
		out.print("<script>window.location.href='comp_info_opt.jsp';</script>"); 
		}		 
	   }
     }	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script type="text/javascript">
var comOwnSubCategory = new Array();
<cache:cache key="cache_comOwnSubcategory" cron="0 0/30 6-23 * * ?">
<%	
String[][]comOwnSubCategory = DataManager.fetchFieldValue(pool, "member_catalog_info","num,name,parentid", "parentid<>1");
if(comOwnSubCategory!=null){
	for(int i=0;i<comOwnSubCategory.length;i++){
%>
	comOwnSubCategory[<%=i%>]=['<%=comOwnSubCategory[i][0]%>','<%=comOwnSubCategory[i][1]%>','<%=comOwnSubCategory[i][2]%>']; 
<%
	   }
	}
%>
</cache:cache>
function set_comp_ownsubcategory(obj){
	
	var sub = document.getElementById("zd_comp_ownsubcategory");
	sub.length=0;
	sub.options[0]=new Option('选择子分类','');
	for(var i=0,j=1;i<comOwnSubCategory.length;i++){
		if(comOwnSubCategory[i][0].length>3 && comOwnSubCategory[i][0].substring(0,3)==obj){
			sub.options[j]=new Option(comOwnSubCategory[i][1],comOwnSubCategory[i][0]);
			j++;
		}
	}
}
  function submityn(){  
	
	var obj= document.getElementsByName("zd_comp_mode");
	var zdCompModeValue = ",";
	for(var i=0;i<obj.length;i++){
		if(obj[i].checked){
			zdCompModeValue += obj[i].value+",";
		}
	}
	if(zdCompModeValue==",") zdCompModeValue="";
	document.theform.zdCompModeValue.value = zdCompModeValue;	
	
	//=========会员申请======
			var obj2 = document.getElementsByName("member_type_apply");
		var memberTypeApplyValue = ",";
		for(var i=0;i<obj2.length;i++){
			if(obj2[i].checked){
				memberTypeApplyValue += obj2[i].value+",";
			}
		}
		if(memberTypeApplyValue==",") memberTypeApplyValue="";
		document.theform.zd_member_type_apply.value = memberTypeApplyValue;
	//==============
	
	if($("#zd_comp_name").val()==""){ //zd_comp_name
	  alert("公司名称不能为空！");
	  $("#zd_comp_name").focus();
	  return false;
	}else if($("#zd_comp_prop").val()==""){
	  alert("公司性质不能为空！");
	  $("#zd_comp_prop").focus();
	  return false;		
	}else if(document.theform.zdCompModeValue.value==""){
	  alert("经营模式不能为空！");
	  return false;	
	}else if($("#zd_comp_owncategory").val()==""){
	  alert("所属类别不能为空！");
	   $("#zd_comp_owncategory").focus();
	   return false;	
	}else if($("#zd_comp_ownsubcategory").val()==""){
	   alert("所属子类别不能为空！");
	   $("#zd_comp_ownsubcategory").focus();
	   return false;	
	}else if($("#zd_per_province").val()==""){
	   alert("省份不能为空！");
	   $("#zd_per_province").focus();
	   return false;
	}else if($("#zd_per_city").val()==""){
	   alert("城市不能为空！");
	   $("#zd_per_city").focus();
	   return false;
	}else if($("#zd_comp_mem_name").val()==""){
	   alert("联系人不能为空！");
	   $("#zd_comp_mem_name").focus();
	   return false;
	}else if($("#zd_comp_phone").val()==""){
	   alert("联系电话不能为空！");
	   $("#zd_comp_phone").focus();
	   return false;
	}else if($("#zd_comp_mobile_phone").val()==""){
	   alert("联系手机不能为空！");
	   $("#zd_comp_mobile_phone").focus();
	   return false;
	}else if($("#zd_comp_email").val()==""){
	   alert("电子邮箱不能为空！");
	   $("#zd_comp_mobile_phone").focus();
	   return false;
	}else if($("#zd_comp_mainbusiness").val()==""){
	  alert("主营业务不能为空！");
	   $("#zd_comp_mainbusiness").focus();
	   return false;
	}else if($("#zd_comp_intro").val()==""){
	   alert("公司简介不能为空！");
	   $("#zd_comp_intro").focus();
	   return false;
	}
	document.theform.flagvalue.value="1";
	document.theform.submit();
  }  
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">公司资料设置</span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请您详细、完整的填写以下表单，内容详细可让您获得更多商机。</td>
      </tr>
    </table>
    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" class="tablezhuce">
      <form method="post" name="theform" id="theform">
        <tr>
          <td  nowrap="nowrap"  class="right"><span class="grayb">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span></td>
          <td ><%=memberInfo.get("mem_no")%>
          <input name="addflag" type="hidden" id="addflag" value="<%=addflag%>" /></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">公司名称：</span></td> 
          <td height="22" ><input name="zd_comp_name" type="text" id="zd_comp_name" size="66" maxlength="200" value="<%=Common.getFormatStr(memberInfo.get("comp_name"))%>"  class="moren"/></td>
        </tr> 
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">公司性质：</span></td> 
          <td height="22" ><select name="zd_comp_prop" id="zd_comp_prop"><option value="">请选择</option><option value="1" <%=Common.getFormatStr(memberInfo.get("comp_prop")).equals("1")?"selected":""%>>私营</option><option value="2" <%=Common.getFormatStr(memberInfo.get("comp_prop")).equals("2")?"selected":""%>>集体</option><option value="3" <%=Common.getFormatStr(memberInfo.get("comp_prop")).equals("3")?"selected":""%>>联营</option><option value="4" <%=Common.getFormatStr(memberInfo.get("comp_prop")).equals("4")?"selected":""%>>股份</option><option value="5" <%=Common.getFormatStr(memberInfo.get("comp_prop")).equals("5")?"selected":""%>>中外合作</option><option value="6" <%=Common.getFormatStr(memberInfo.get("comp_prop")).equals("6")?"selected":""%>>中外合资</option><option value="7" <%=Common.getFormatStr(memberInfo.get("comp_prop")).equals("7")?"selected":""%>>外资</option><option value="8" <%=Common.getFormatStr(memberInfo.get("comp_prop")).equals("8")?"selected":""%>>国有</option></select></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">经营模式：</span></td> 
          <td height="22" ><input name="zd_comp_mode" id="zd_comp_mode" type="checkbox" value="1" <%=comp_mode_session.equals("1")?"checked":""%>>生产销售 <input name="zd_comp_mode" id="zd_comp_mode" type="checkbox" value="2" <%=comp_mode_session.equals("2")?"selected":""%>>代理销售 <input name="zd_comp_mode" id="zd_comp_mode" type="checkbox" value="3" <%=comp_mode_session.equals("3")?"selected":""%>>租赁<input name="zd_comp_mode" id="zd_comp_mode" type="checkbox" value="4" <%=comp_mode_session.equals("4")?"checked":""%>>二手改装/销售 <input name="zd_comp_mode" id="zd_comp_mode" type="checkbox" value="5" <%=comp_mode_session.equals("5")?"selected":""%>>检测维修<input name="zd_comp_mode" id="zd_comp_mode" type="checkbox" value="6" <%=comp_mode_session.equals("6")?"selected":""%>>配套<input name="zd_comp_mode" id="zd_comp_mode" type="checkbox" value="7" <%=comp_mode_session.equals("7")?"selected":""%>>其它</td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">所属类别：</span></td>
          <td height="22"><select name="zd_comp_owncategory" id="zd_comp_owncategory" onchange="set_comp_ownsubcategory(this.value);" style="width:100px;"  class="blue1"><option value="">请选择分类</option><cache:cache key="member_catalog_info" cron="0 0/30 6-23 * * ?">
          		<%=Common.option_str(pool,"member_catalog_info","num,name","parentid=1","",0) %></cache:cache>
            </select>
			<select  name="zd_comp_ownsubcategory" id="zd_comp_ownsubcategory" style="width:100px;" class="blue1">
			<option>选择子分类</option>
			</select>		  </td>
        </tr> 
        <!-- 
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">会员类型：</span></td>
          <td height="22" ><input name="zd_mem_flag" type="radio" id="zd_mem_flag" value=""/>VIP会员&nbsp;&nbsp;<input name="zd_mem_flag" type="radio" id="zd_mem_flag" value=""/>A类会员&nbsp;&nbsp;<input name="zd_mem_flag" type="radio" id="zd_mem_flag" value=""/>B类会员&nbsp;&nbsp;<input name="zd_mem_flag" type="radio" id="zd_mem_flag" value=""/>人才网（金伯乐）<input name="zd_mem_flag" type="radio" id="zd_mem_flag" value=""/>人才网（银伯乐）<input name="zd_mem_flag" type="radio" id="zd_mem_flag" value=""/>人才网（季度）<input name="zd_mem_flag" type="radio" id="zd_mem_flag" value=""/>人才网（月度）<input name="zd_mem_flag" type="radio" id="zd_mem_flag" value=""/>配件网备备通</td>
         -->
        <tr> 
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">所在地域：</span></td>
          <td height="22" ><select name="zd_per_province" id="zd_per_province" onchange="set_city(this,this.value,theform.zd_per_city,'');" style="width:100px;"  class="validate-selection">
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
              <select  name="zd_per_city" id="zd_per_city"  style="width:100px;">
                <option>选择城市</option>
            </select></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">联系地址：</span></td>
          <td height="22" ><input name="zd_comp_address" type="text" id="zd_comp_address" size="66" maxlength="200" value="<%=comp_address_session%>"  class="moren"/></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">邮　　编：</span></td>
          <td height="22" ><input name="zd_comp_postcode" type="text" id="zd_comp_postcode" size="66" maxlength="200" value="<%=comp_postcode_session%>"  class="moren"/></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">联系人：</span></td>
          <td height="22" ><input name="zd_comp_mem_name" type="text" id="zd_comp_mem_name" size="66" maxlength="200" value="<%=comp_mem_name_session.equals("")?mem_name_session:comp_mem_name_session%>"  class="moren"/></td>
        </tr>
	
		 <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">所在部门：</span></td>
          <td height="22" ><input name="zd_comp_depart" type="text" id="zd_comp_depart" size="48" maxlength="48" value="<%=comp_depart_session%>"  class="moren"/></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">职务：</span></td>
          <td height="22" ><input name="zd_comp_posi" type="text" id="zd_comp_posi" size="48" maxlength="48" value="<%=comp_posi_session%>"  class="moren"/></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">联系电话：</span></td>
          <td height="22" ><input name="zd_comp_phone" type="text" id="zd_comp_phone" size="66" maxlength="200" value="<%=comp_phone_session.equals("")?per_phone_session:comp_phone_session%>"  class="moren"/></td>
        </tr>
        
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">手　　机：</span></td>
          <td height="22" ><input name="zd_comp_mobile_phone" type="text" id="zd_comp_mobile_phone" size="66" maxlength="200" value="<%=comp_mobile_phone_session.equals("")?perMobilePhoneSession:comp_mobile_phone_session%>"  class="moren"/></td>
        </tr>
        
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">传　　真：</span></td>
          <td height="22" ><input name="zd_comp_fax" type="text" id="zd_comp_fax" size="66" maxlength="200" value="<%=comp_fax_session%>"  class="moren"/></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">QQ：</span></td>
          <td height="22" ><input name="zd_comp_qq" type="text" id="zd_comp_qq" size="66" maxlength="200" value="<%=comp_qq_session.equals("")?perQQSession:comp_qq_session%>"  class="moren"/></td>
        </tr>
        
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">MSN：</span></td>
          <td height="22" ><input name="zd_comp_msn" type="text" id="zd_comp_msn" size="66" maxlength="200" value="<%=comp_msn_session.equals("")?perMsnSession:comp_msn_session%>"  class="moren"/></td>
        </tr>
		<tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">电子邮件：</span></td>
          <td height="22" ><input name="zd_comp_email" type="text" id="zd_comp_email" size="66" maxlength="200" value="<%=comp_email_session.equals("")?perEmailSession:comp_email_session%>"  class="moren"/></td>
        </tr>
        
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">公司主页：</span></td>
          <td height="22" ><input name="zd_comp_url" type="text" id="zd_comp_url" size="66" maxlength="200" value="<%=comp_url_session%>"  class="moren"/></td>
        </tr>
        
        <tr id="showimg2">
                <td height="22" nowrap class="list_left_title"><strong>公司Logo：</strong> </td>
                <td height="22" class="list_cell_bg" colspan="3"><input name="zd_comp_logo" id="zd_comp_logo" type="hidden" value="" />
                  <span id="txt_zd_comp_logo"></span><span id="ifr_zd_comp_logo">
                  <iframe
													id="ifr2_zd_comp_logo" scrolling="no" frameborder="0"
													width="100%" height="28"
													src="http://resource.21-sun.com/web_upload_files_for_smallpic.jsp?nurl=<%=request.getServerName() + ":"
						+ request.getServerPort()%>&websiteId=22&dir=used&fieldname=zd_comp_logo"></iframe>
                  </span> </td>
              </tr>
        
        
		 <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">主营业务：</span></td>
          <td height="22" ><input name="zd_comp_mainbusiness" type="text" id="zd_comp_mainbusiness" size="66" maxlength="200" value="<%=comp_mainbusiness_session%>"  class="moren"/></td>
        </tr> 
           
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="red">*</span><span class="grayb">公司简介：</span></td>
          <td height="22" ><textarea name="zd_comp_intro" id="zd_comp_intro" cols="66" rows="6" style="overflow-y:scroll;"><%=Common.filterHtmlString(comp_intro_session).replace("<br />","\r\n")%></textarea></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right">会员申请：</td>
          <td height="22" >
            <input name="member_type_apply" type="checkbox" id="member_type_apply"  value="A类"/>A类
		  <input name="member_type_apply" type="checkbox" id="member_type_apply"  value="B类"/>		  
		  B类&nbsp;&nbsp;
		  人才网(<input name="member_type_apply" type="checkbox" id="member_type_apply"  value="金伯乐"/>金伯乐&nbsp;<input name="member_type_apply" type="checkbox" id="member_type_apply"  value="银伯乐"/>银伯乐&nbsp;<input name="member_type_apply" type="checkbox" id="member_type_apply"  value="季度"/>季度&nbsp;<input name="member_type_apply" type="checkbox" id="member_type_apply"  value="月度"/>月度)
		  <input name="member_type_apply" type="checkbox" id="member_type_apply"  value="配件备备通"/>配件备备通
		  <input name="member_type_apply" type="checkbox" id="member_type_apply"  value="杰配网"/>杰配网
		  <br />
		  <input name="member_type_apply" type="checkbox" id="member_type_apply"  value="配套网"/>配套网
		  <input name="member_type_apply" type="checkbox" id="member_type_apply"  value="租赁通"/>租赁通
<input type="hidden" id="zd_member_type_apply" name="zd_member_type_apply" /></td>
        </tr>  
          
        <tr>
          <td height="22"></td><td  align="center"  bgcolor="#FFFFFF"> <input type="button" id="submitId" name="Submit" value="保 存" class="tijiao" style="cursor:pointer"  onClick="submityn()"/></td>
        </tr>
        <input name="flagvalue" type="hidden" id="flagvalue"  />
		<input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=mem_no_session%>" />
		<input name="zdCompModeValue" type="hidden" id="zdCompModeValue" />
	</form>
    </table>
  </div>
</div>
<script   language="javascript">
document.theform.zd_per_province.value="<%=per_province_session%>";
set_city(theform.zd_per_province,theform.zd_per_province.value,theform.zd_per_city,'');
document.theform.zd_per_city.value="<%=per_city_session%>";

document.theform.zd_comp_owncategory.value="<%=comp_owncategory_session%>";  //给
set_comp_ownsubcategory('<%=comp_owncategory_session%>');
document.theform.zd_comp_ownsubcategory.value="<%=comp_ownsubcategory_session%>";

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
setChecks('<%=comp_mode_session%>','zd_comp_mode');
setChecks('<%=member_type_apply_session%>','member_type_apply');

</script>
<script type="text/javascript">
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
window.onload=f_iframeResize;
</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
