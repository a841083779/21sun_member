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

String zd_mem_no="";
String zd_mem_name="";
String zd_comp_name="",zd_comp_prop = "",zdCompModeValue="",zd_comp_owncategory="",zd_comp_ownsubcategory="",zd_per_province="",zd_per_city="",zd_comp_address="";
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
	   zd_mem_type= Common.getFormatStr(request.getParameter("zd_mem_type"));
	   zd_per_sex	= Common.getFormatStr(request.getParameter("zd_per_sex"));
	
	  if(!zd_mem_no.equals("")){   
		 sqlMemInfo = "update member_info set mem_type='"+zd_mem_type+"',per_qq='"+zd_comp_qq+"', per_email='"+zd_comp_email+"', per_phone='"+zd_comp_phone+"', mem_name='"+zd_mem_name+"', per_province='"+zd_per_province+"',per_city='"+zd_per_city+"',comp_mode='"+zd_comp_mode+"',per_sex='"+zd_per_sex+"' where mem_no='"+zd_mem_no+"'";
		result = DataManager.dataOperation(pool,sqlMemInfo);
		 		
		 if(mem_no_sub.equals(zd_mem_no)){ //扩展表和主表的mem_no相同
		   sqlMemInfoSub = "update member_info_sub set comp_phone='"+zd_comp_phone+"',comp_qq='"+zd_comp_qq+"',comp_email='"+zd_comp_email+"',comp_mode='"+zd_comp_mode+"' where mem_no ='"+zd_mem_no+"'";
		 //System.out.println(sqlMemInfoSub);
		   
		   result = DataManager.dataOperation(pool,sqlMemInfoSub);
		 }else{
			 sqlMemInfoSub = "insert member_info_sub (mem_no,comp_mode,comp_phone,comp_mobile_phone,comp_qq,comp_email) values('"+zd_mem_no+"','"+zd_comp_mode+"','"+zd_comp_phone+"','"+zd_comp_mobile_phone+"','"+zd_comp_qq+"','"+zd_comp_email+"')";			
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
			//修改配件网用户信息-begin
			if(zd_mem_no!=null && !zd_mem_no.equals("")){
				int sexInt =  zd_per_sex.equals("男")?1:0;
				String updatePartMemberSql = "update part_member set mem_name='"+zd_mem_name+"',sex="+sexInt+",mobile='"+zd_comp_phone+"',province='"+zd_per_province+"',city='"+zd_per_city+"',email='"+zd_comp_email+"' where mem_no='"+zd_mem_no+"'";;
				//System.out.println("update part_member set mem_name='"+zd_mem_name+"',sex="+sexInt+",mobile='"+zd_comp_phone+"',province='"+zd_per_province+"',city='"+zd_per_city+"',email='"+zd_comp_email+"' where mem_no='"+zd_mem_no+"'";);
				DataManager.dataOperation(conn_part,updatePartMemberSql);
			}
			//修改配件网用户信息-end
		   if(!addflag.equals("0")){
		 	 out.print("<script>alert('完善信息成功!');window.location.href='/manage/member_reg_more_person.jsp';</script>");
		  }else{
		    //out.print("<script>alert('完善信息成功!');window.location.href='comp_info_opt.jsp';</script>");
			  out.print("<script>alert('完善信息成功!');window.location.href='/manage/member_reg_more_person.jsp';</script>");
		  }
		}else{
			//out.print("<script>window.location.href='comp_info_opt.jsp';</script>"); 
			out.print("<script>window.parent.location.href='/manage/memberhome.jsp?addflag="+addflag+"';</script>");
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
          <input name="zd_mem_type" type="radio" value="1" onclick="checkMemType();"/>企业&nbsp;&nbsp;
          <input name="zd_mem_type" type="radio" value="2" checked="checked"/>个人
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
<!--
        <tr>
          <th><font>*</font>所在地XXXXX：</th>
          <td>
	          <div style="float:left; margin-right:8px;">
	          	<div style="float:left;">
	            <span class="list_cell_bg">
	            <select name="zd_per_province" id="zd_per_province" onblur="formyanzheng('zd_per_city')" onchange="set_city(this,this.value,document.theform.zd_per_city,'');" style="width:100px;" class="ri">
	              <option value="">选择省份</option>
	              <option value="北京" <%=per_province_session.equals("北京")?"selected":""%>>北京</option>
	              <option value="上海" <%=per_province_session.equals("上海")?"selected":""%>>上海</option>
	              <option value="天津" <%=per_province_session.equals("天津")?"selected":""%>>天津</option>
	              <option value="重庆" <%=per_province_session.equals("重庆")?"selected":""%>>重庆</option>
	              <option value="河北" <%=per_province_session.equals("河北")?"selected":""%>>河北</option>
	              <option value="山西" <%=per_province_session.equals("山西")?"selected":""%>>山西</option>
	              <option value="辽宁" <%=per_province_session.equals("辽宁")?"selected":""%>>辽宁</option>
	              <option value="吉林" <%=per_province_session.equals("吉林")?"selected":""%>>吉林</option>
	              <option value="黑龙江" <%=per_province_session.equals("黑龙江")?"selected":""%>>黑龙江</option>
	              <option value="江苏" <%=per_province_session.equals("江苏")?"selected":""%>>江苏</option>
	              <option value="浙江" <%=per_province_session.equals("浙江")?"selected":""%>>浙江</option>
	              <option value="安徽" <%=per_province_session.equals("安徽")?"selected":""%>>安徽</option>
	              <option value="福建" <%=per_province_session.equals("福建")?"selected":""%>>福建</option>
	              <option value="江西" <%=per_province_session.equals("江西")?"selected":""%>>江西</option>
	              <option value="山东" <%=per_province_session.equals("山东")?"selected":""%>>山东</option>
	              <option value="河南" <%=per_province_session.equals("河南")?"selected":""%>>河南</option>
	              <option value="湖北" <%=per_province_session.equals("湖北")?"selected":""%>>湖北</option>
	              <option value="湖南" <%=per_province_session.equals("湖南")?"selected":""%>>湖南</option>
	              <option value="广东" <%=per_province_session.equals("广东")?"selected":""%>>广东</option>
	              <option value="海南" <%=per_province_session.equals("海南")?"selected":""%>>海南</option>
	              <option value="四川" <%=per_province_session.equals("四川")?"selected":""%>>四川</option>
	              <option value="贵州" <%=per_province_session.equals("贵州")?"selected":""%>>贵州</option>
	              <option value="云南" <%=per_province_session.equals("云南")?"selected":""%>>云南</option>
	              <option value="陕西" <%=per_province_session.equals("陕西")?"selected":""%>>陕西</option>
	              <option value="甘肃" <%=per_province_session.equals("甘肃")?"selected":""%>>甘肃</option>
	              <option value="青海" <%=per_province_session.equals("青海")?"selected":""%>>青海</option>
	              <option value="内蒙古" <%=per_province_session.equals("内蒙古")?"selected":""%>>内蒙古</option>
	              <option value="广西" <%=per_province_session.equals("广西")?"selected":""%>>广西</option>
	              <option value="西藏" <%=per_province_session.equals("西藏")?"selected":""%>>西藏</option>
	              <option value="宁夏" <%=per_province_session.equals("宁夏")?"selected":""%>>宁夏</option>
	              <option value="新疆" <%=per_province_session.equals("新疆")?"selected":""%>>新疆</option>
	              <option value="台湾" <%=per_province_session.equals("台湾")?"selected":""%>>台湾</option>
	              <option value="香港" <%=per_province_session.equals("香港")?"selected":""%>>香港</option>
	              <option value="澳门" <%=per_province_session.equals("澳门")?"selected":""%>>澳门</option>
	              </select>
	              </span>
	              </div>
	              <div style="float:left;">
	              <span class="list_cell_bg">
	            	<select  name="zd_per_city" id="zd_per_city" onblur="formyanzheng('zd_per_city')" style="width:100px;" class="ri">
	             	 <option value="">选择城市</option>
	             	 <option value="<%=per_city_session%>" selected><%=per_city_session%></option>
	              	</select>
	                </span>
	              </div>
	          </div>
	          <div style="display:none;margin-left:32px;" id="zd_per_city_dui" class="diu"></div>
              <div style="display:none;margin-left:32px;" id="zd_per_city_cuo" class="cuo"></div>
              <div style="display:none;" id="zd_per_city_cuo_info" class="cuo1"></div>
          </td>
        </tr>
 -->
        <tr>
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
        </tr>
        <tr>
          <th>邮箱：</th>
          <td>
          	<input name="zd_comp_email" type="text" class="ri" id="zd_comp_email" value="<%=comp_email_session.equals("")?perEmailSession:comp_email_session%>" onfocus="showText('zd_comp_email')"/>	
          </td>
        </tr>
        <tr>
          <th>QQ：</th>
          <td><input type="text" name="zd_comp_qq" id="zd_comp_qq" class="ri" value="<%=perQQSession %>" /></td>
        </tr>
		<tr>
          <th width="140">类别：</th>
          <td width="780">
          <input name="zd_comp_mode" type="radio" value="201" <%=comp_mode_session.equals("201")?"checked":""%>/>操作手&nbsp;&nbsp;
          <input name="zd_comp_mode" type="radio" value="202"  <%=comp_mode_session.equals("202")?"checked":""%>/>机主&nbsp;&nbsp;
          <input name="zd_comp_mode" type="radio" value="203"  <%=comp_mode_session.equals("203")?"checked":""%>/>其他
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><input type="submit" name="button" id="button" value="提交" class="registBtn" /></td>
        </tr>
      </table>
      	<input name="flagvalue" type="hidden" id="flagvalue"  value="1"/>
		<input name="zd_mem_no" type="hidden" id="zd_mem_no" value="<%=mem_no_session%>" />
		<input type="hidden" name="zd_comp_mode" id="zd_comp_mode" value=""/>
    </form>
    </div>
    <!---->
<!--  </div>  
<div class="clear"></div>  
</div>-->
<script   language="javascript">
function checkMemType()
{
	window.location.href = 'member_reg_more.jsp';
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
	jQuery("#zd_city").val('<%=per_city_session%>');
}
function submityz2(){
	var comp_mode = "," ;
	jQuery("input[type='checkbox']:checked").each(function(){
	//  alert(jQuery(this).val()) ;
	comp_mode += jQuery(this).val() +",";
	}) ;
	jQuery("#zd_comp_mode").val(comp_mode) ;
	var isOK = 0;	
	if(!formyanzheng('zd_mem_name')){
		isOK = isOK+1;
	}
	if(!formyanzheng('zd_comp_phone')){
		isOK = isOK+1;
	}
	if(!formyanzheng('zd_city')){
		isOK = isOK+1;
	}
	if(isOK>0){
		return false;	
	}
	var mem_name = jQuery("#zd_mem_name").val() ;
	console.log("mem_name="+mem_name);
	var info = mem_name.replace(/\s+/g,"") ;	
	var cango = '' ;
	/*jQuery.ajax({
		url:'/tools/ajax.jsp' ,
		type:'post',
		async:false,
		data:{info:info,flag:'checkInputInfo'},
		success:function(msg){
		 if(jQuery.trim(msg)=='so'){
		     alert("您所填的信息中含有敏感词，请重新填写") ;
		     cango = 1 ;
		     return false ;
		 }
		}
	}) ;*/
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
