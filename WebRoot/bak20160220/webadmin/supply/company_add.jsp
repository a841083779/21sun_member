<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%
String id = Common.getFormatStr(request.getParameter("id"));
String mem_no = Common.getFormatStr(request.getParameter("mem_no"));
String tablename= "webypage";
String urlpath = "company_list.jsp";
String cla="";

//用户信息
String corporation="";//公司信息
String address = "";//地址
String postalcode="";//邮政编码
String fullname = "";//联系人
String telephone="";//联系电话
String fax = "";//传真
String email = "";//邮箱
String homepage="";//主页
String introduction="";//介绍
String mem_flag="";
Connection conn = pool.getConnection();
try{
if(!"".equals(id)){
		ResultSet rs = DataManager.executeQuery(conn,"select class from webypage where id='"+id+"'");
		while(rs.next()){
			cla = rs.getString("class");
		}
	
}else if(!"".equals(mem_no)){
String sql = " select * from member_info where mem_no='"+mem_no+"'";
ResultSet rs = DataManager.executeQuery(conn,sql);
	while(rs.next()){ 
	corporation = Common.getFormatStr(rs.getString("comp_name"));
	address = Common.getFormatStr(rs.getString("comp_address"));
	postalcode = Common.getFormatStr(rs.getString("comp_postcode"));
	fullname = Common.getFormatStr(rs.getString("mem_name"));
	telephone = Common.getFormatStr(rs.getString("per_phone"));
	fax = Common.getFormatStr(rs.getString("comp_fax"));
	email = Common.getFormatStr(rs.getString("per_email"));
	homepage = Common.getFormatStr(rs.getString("comp_url"));
	introduction = Common.getFormatStr(rs.getString("comp_intro"));
	mem_flag=Common.getFormatStr(rs.getString("mem_flag"));
	}
}

}catch(Exception e){
		e.printStackTrace();
	}finally{
		conn.close();
	}

 %>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>企业库</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script type="text/javascript">
function sub(){
	var cl = document.getElementsByName("classa");
	var cla = "";
	for(var i=0;i<cl.length;i++){
		if(cl[i].checked==true){
			cla+=cl[i].value+",";
		}
	}
	if(cla==''){
		alert("请选择公司类别");
		return false;
	}
	var zd_corporation = document.getElementById("zd_corporation").value;
	if(zd_corporation==''){
		alert("请输入公司名称");
		document.getElementById("zd_corporation").focus();
		return false;
	}
	var zd_address = document.getElementById("zd_address").value;
	if(zd_address==''){
		alert("请输入联系地址");
		document.getElementById("zd_address").focus();
		return false;
	}
	var zd_province = document.getElementById("zd_province").value;
	if(zd_province==''){
		alert("请选择地域");
		document.getElementById("zd_province").focus();
		return false;
	}
	 
	 
	 
	var zd_postalcode = document.getElementById("zd_postalcode").value;
	if(zd_postalcode==''){
		alert("请输入邮编");
		document.getElementById("zd_postalcode").focus();
		return false;
	}
	var zd_fullname = document.getElementById("zd_fullname").value;
	if(zd_fullname==''){
		alert("请输入联系人名称");
		document.getElementById("zd_fullname").focus();
		return false;
	}
	var zd_telephone = document.getElementById("zd_telephone").value;
	if(zd_telephone==''){
		alert("请输入联系电话");
		document.getElementById("zd_telephone").focus();
		return false;
	}
	var zd_introduction = document.getElementById("zd_introduction").value;
	if(zd_introduction==''){
		alert("请输入联系公司简介");
		document.getElementById("zd_introduction").focus();
		return false;
	}
	
		document.getElementById("zd_class").value=cla;
	theform.submit();

}
</script>


</head>

<body>
 <div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">加入企业名录</span></div>
  <div class="loginlist_right1"> 
	<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td width="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width="100%">
					<form method="POST" action="opt_save_cpm.jsp" name="theform"  >
						<input type="hidden" name="zd_mid" value="<%=usern %>">
						<input type="hidden" name="zd_id" value="0"  >
						 <input type="hidden" name="urlpath" value="<%=urlpath %>"  >
						 <input type="hidden" name="zd_class" value=""  >
						 <input type="hidden" name="zd_order_by" value="9999"  >
						 <input type="hidden" name="zd_isdisplay" value="0"  >
						 <input type="hidden" name="zd_recommend" value="0"  >
						 <input type="hidden" name="zd_city" value="00"  >
						 <input type="hidden" name="zd_mem_flag" value="<%=mem_flag %>"  >
						 <input type="hidden" name="zd_regts" value="<%=Common.getToday("yyyy-MM-dd",0)%>"  >
						 <input type="hidden" name="zd_poppage" value="<%=10 %>"  >
						 <input type="hidden" name="tablename" value="<%=Common.encryptionByDES(tablename) %>"  >
						<div align="center" class="loginlist_right1">
							<center>
							<table border="0" cellpadding="2" cellspacing="0" width="100%"  >
								<tr>
									<td width="10%" align="right" nowrap valign="top"><font color="#FF0000">*</font><span class="grayb">公司类别：</span></td>
									<td width="90%" align="left">
									<div align="center">
										<center>
										<table border="0" cellpadding="0" cellspacing="0" width="100%"  class="tablezhuce">
											<tr >
												<td width="33%"  ><input type="checkbox" name="classa" value="5" <%if(cla.indexOf("5")!=-1){ %>  checked<%} %> ><font size="2">各种整机生产销售企业</font></td>
												<td width="33%"><input type="checkbox" name="classa" value="2" <%if(cla.indexOf("2")!=-1){ %>  checked<%} %>><font size="2">各种配件生产经销企业</font></td>
												<td width="34%"><input type="checkbox" name="classa" value="4"  <%if(cla.indexOf("4")!=-1){ %>  checked<%} %>><font size="2">工程机械最终用户企业</font></td>
											</tr>
											<tr>
												<td width="33%"><input type="checkbox" name="classa" value="6"  <%if(cla.indexOf("6")!=-1){ %>  checked<%} %>><font size="2">工程机械检测维修企业</font></td>
												<td width="33%"><input type="checkbox" name="classa" value="7"  <%if(cla.indexOf("7")!=-1){ %>  checked<%} %>><font size="2">国外工程机械相关企业</font></td>
												<td width="34%"><input type="checkbox" name="classa" value="9"  <%if(cla.indexOf("9")!=-1){ %>  checked<%} %>><font size="2">其它企业、机构、院校</font></td>
											</tr>
											<tr>
												<td width="33%"><input type="checkbox" name="classa" value="1"  <%if(cla.indexOf("1")!=-1){ %>  checked<%} %>><font size="2">各发动机生产经销企业</font></td>
												<td width="33%"><input type="checkbox" name="classa" value="3"  <%if(cla.indexOf("3")!=-1){ %>  checked<%} %>><font size="2">液压产品生产经销企业</font></td>
												<td width="34%">&nbsp;</td>
											</tr>
										</table>
										</center>
									</div>
									</td>
								</tr>
								<tr>
									<td width="10%" align="right" nowrap><font color="#FF0000">*</font><span class="grayb">所在地域：</span></td>
									<td width="90%" align="left">
									<select name="zd_province" size="1">
									<option value="">请选择</option>
          	   	<cache:cache key="include_privince" cron="0 0/30 6-23 * * ?">
          		<%=Common.option_str(pool,"lstdistrict","id1,district","id1%10!=0","",0) %>          		</cache:cache>
 									</select></td>
								</tr>
								<tr>
									<td width="10%" align="right" nowrap><font color="#FF0000">*</font> <span class="grayb">公司名称：</span></td>
									<td width="90%" align="left"><input type="text" name="zd_corporation" value="<%=corporation %>" size="50" maxlength="20" >
									 </td>         
								</tr>
								<tr>
									<td width="10%" align="right" nowrap><font color="#FF0000">*</font> <span class="grayb">联系地址：</span></td>
									<td width="90%" align="left"><input type="text" name="zd_address" size="50"  value="<%=address %>"   maxlength="30">
									 </td>         
								</tr>
								<tr>
									<td width="10%" align="right" nowrap><font color="#FF0000">*</font> <span class="grayb">邮政编码：</span></td>
									<td width="90%" align="left"><input type="text" name="zd_postalcode" size="10"   value="<%=postalcode %>"  maxlength="20">
									 </td>         
								</tr>
								<tr>
									<td width="10%" align="right" nowrap><font  color="#FF0000">*</font> <span class="grayb">联 系 人：</span></td>
									<td width="90%" align="left"><input type="text" name="zd_fullname" size="20"  value="<%=fullname %>"   maxlength="20">
									 </td>         
								</tr>
								<tr>
									<td width="10%" align="right" nowrap><font color="#FF0000">*</font> <span class="grayb">联系电话：</span></td>
									<td width="90%" align="left"><input type="text" name="zd_telephone" size="30"   value="<%=telephone %>"  maxlength="20">
									 </td>         
								</tr>
								<tr>
									<td width="10%" align="right" nowrap><span class="grayb">传&nbsp;&nbsp;&nbsp;          
									真：</span></td>
									<td width="90%" align="left"><input type="text" name="zd_fax" size="20"  value="<%=fax %>"   maxlength="20"> </td>
								</tr>
								<tr>
									<td width="10%" align="right" nowrap><span class="grayb">电子邮件：</span></td>
									<td width="90%" align="left"><input type="text" name="zd_email" size="50"   value="<%=email %>" > </td>
								</tr>
								<tr>
									<td width="10%" align="right" nowrap><span class="grayb">公司主页：</span></td>
									<td width="90%" align="left"><input type="text" name="zd_homepage" size="50"  value="<%=homepage %>"   maxlength="40"> </td>
								</tr>
								<tr>
									<td width="10%" align="right" nowrap valign="top"><span class="grayb">主营业务：<br>
									</span> 
									</td>
									<td width="90%" align="left"><textarea rows="5" name="zd_bussiness" cols="60"></textarea></td>
								</tr>
								 
								<tr>
									<td width="10%" align="right" nowrap valign="top"><font color="#FF0000">*</font><span class="grayb">公司简介：</span></td>
									<td width="90%" align="left"><textarea rows="5" name="zd_introduction" cols="60" ><%=introduction %></textarea></td>
								</tr>
								<tr>
		<td  height="22" align="right" nowrap class="list_left_title"><font color="#FF0000">*</font><span class="grayb">是否发布：</span></td>
		<td height="22" class="list_cell_bg">		  
		<select name="zd_ispublished">
			<option value="1">是</option>
			<option value="0">否</option>
		</select>		 
		 </td>
	</tr>
								<tr>
									<td width="10%" align="right" nowrap valign="top"></td>
									<td width="90%" align="left"></td>
								</tr>
								<tr>
									<td width="100%" align="center" colspan="2">&nbsp;&nbsp;&nbsp; <input type="button" value="  提  交  " name="btnJoin" onclick="sub();" class="tijiao" style="cursor:pointer"> 
									 </td>
								</tr>
							</table>
							</center>
						</div>
					</form>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
 </div>
 </div>
 
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=tablename%>')+"&paraName=id&paraValue="+encodeURIComponent(val));
	
	}
}
<%
if(!id.equals("0")){
	out.print("set_formxx(\""+id+"\");");
}
%>
</script>
</body>
</html>
