<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ taglib
	uri="/WEB-INF/oscache.tld" prefix="cache"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include	file="/manage/config.jsp"%>
<%
	pool = new PoolManager(7);


//=====页面属性====
String pagename="company_opt.jsp";
String mypy="part_company_info";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));

try{//====标题的名称====

%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>配件企业库管理</title>
		<link href="../style/style.css" rel="stylesheet" type="text/css" />
		<script src="../scripts/jquery-1.4.1.min.js"></script>
		<script src="../scripts/common.js" type="text/javascript"></script>
		<script src="../scripts/citys.js" type="text/javascript"></script>
		<script src="../scripts/calendar.js" type="text/javascript"></script>
		<script>


function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

//为多选框赋值
function submityn(){
		theform.submit();
}
</script>
	</head>
	<body>
		<table width="95%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td height="15">
					<span class="p982"><span class="pblue1">红色</span><font
						color="#FF0000">*</font><span class="pblue1">为必填项</span>
					</span>
				</td>
			</tr>
		</table>
		<table width="95%" border="0" align="center" cellpadding="0"
			cellspacing="1" class="list_border_bg">
			<form action="opt_save_update.jsp" method="post" name="theform"
				id="theform">
			<tr>
				<td align="right" nowrap class="list_left_title">
					会员编号：
				</td>
				<td class="list_cell_bg">
					<input name="zd_mem_no" id="zd_mem_no" type="text" size="40" />
					<font color="#FF0000">*</font>
				</td>
			</tr>
			<tr>
				<td align="right" nowrap class="list_left_title">
					会员姓名：
				</td>
				<td class="list_cell_bg">
					<input name="zd_mem_name" type="text" id="zd_mem_name" size="40"
						maxlength="40">
					<font color="#FF0000">*</font>
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					联系电话：
				</td>
				<td height="22" class="list_cell_bg">
					<input name="zd_per_phone" id="zd_per_phone" type="text" size="40" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					Email：
				</td>
				<td height="22" class="list_cell_bg">
					<input name="zd_per_email" type="text" id="zd_per_email" size="50"
						maxlength="50">
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					公司名称：
				</td>
				<td height="22" class="list_cell_bg">
					<input name="zd_comp_name" type="text" id="zd_comp_name" size="50"
						maxlength="40">
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					公司简称：
				</td>
				<td height="22" class="list_cell_bg">
					<input name="zd_comp_simple" type="text" id="zd_comp_simple" size="50"
						maxlength="50">
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					公司地址：
				</td>
				<td height="22" class="list_cell_bg">
					<input type="text" id="zd_comp_address" name="zd_comp_address" size="50"
						maxlength="50" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					邮编：
				</td>
				<td height="22" class="list_cell_bg">
					<input type="text" id="zd_comp_postcode" name="zd_comp_postcode" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					传真：
				</td>
				<td height="22" class="list_cell_bg">
					<input type="text" id="zd_comp_fax" name="zd_comp_fax" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					公司网址：
				</td>
				<td height="22" class="list_cell_bg">
					<input name="zd_comp_url" type="text" id=""zd_comp_url"" size="50" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					公司简介：
				</td>
				<td height="22" class="list_cell_bg">
			        <textarea id="zd_comp_intro" name="zd_comp_intro" style="width:400px;height:200px;"></textarea>
				</td>
			</tr>
			<tr>
				<td height="30" class="list_left_title" align="center" colspan="2">
					<div align="center">
						<input type="button" name="Submit" value="保存" onClick="submityn()">
						<input type="button" name="close" value="关闭" onclick="closeWindow();" />
						<input name="zd_id" type="hidden" id="zd_id" value="0">
						<input name="mypy" type="hidden" id="mypy"
							value="<%=Common.encryptionByDES(mypy)%>">
						<input name="zd_add_date" type="hidden" id="zd_add_date"
							value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
						<input name="zd_add_ip" type="hidden" id="zd_add_ip"
							value="<%=Common.getRemoteAddr(request,1)%>">

						<input name="myvalue" type="hidden" id="myvalue"
							value='<%=myvalue%>'>
						<input name="isReload" type="hidden" id="isReload"
							value="<%=isReload%>">
						<input name="zd_state" id="zd_state" value="1" />
						<input name="zd_mem_flag" id="zd_mem_flag" value="-1" />
					</div>
				</td>
			</tr>
			</form>
		</table>
		<table width="98%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td height="10"></td>
			</tr>
		</table>
		<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1
			scrolling="no" style="visibility: hidden"></iframe>
		<script language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
	}
}
<%
if(!myvalue.equals("")){
	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>
	</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
}
%>
