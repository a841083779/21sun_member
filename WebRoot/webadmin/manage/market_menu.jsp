<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@ include file ="../manage/config.jsp"%>
<%//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库
Connection conn=null;
ResultSet rs =null;
StringBuffer query=new StringBuffer();

//=======
String catalog_no=""; 
String parent_id="";
String catalog_name="";
String back_link="";

//==========
try{
%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script  src="../scripts/common.js" type="text/javascript"></script>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<script src="../scripts/jsframework.js"></script>
<style type="text/css"> 
<!--
a:link {
	font-size: 9pt;
	color: #333333;
	text-decoration: none;
}
a:visited {
	font-size: 9pt;
	color: #333333;
	text-decoration: none;
}
a:hover {
	font-size: 9pt;
	color: #000000;
	text-decoration: underline;
	background-color: #99FFFF;
}
a:active {
	font-size: 9pt;
	color: #333333;
	text-decoration: none;
}
-->
</style>
<title>商贸网人才左侧导航</title>
</head>
<body bgcolor="#F0F0F0" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
	<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table15">
			<tr>
				<td height="10"><!----></td>
			</tr>
		</table>
		<div align="center">
			<table border="0" cellpadding="0" cellspacing="0" width="90%" id="table16" style="border: 1px solid #A9A9A9" bgcolor="#FFFFFF">
				<tr>
					<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table17" background="/webadmin/images/bk11.gif" height="24">
						<tr>
							<td>　<b>友情提示</b></td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table18">
						<tr>
							<td height="10"><!----></td>
						</tr>
					</table>
					<div align="center">
						<table border="0" cellpadding="0" cellspacing="0" width="90%" id="table20">
							<tr>
								<td width="8">
								<img border="0" src="/webadmin/images/admin/sj01.gif" width="8" height="9"></td>
								<td width="100%">　单击此处进入首页</td>
							</tr>
						</table>
					</div>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table19">
						<tr>
							<td height="20"><!----></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
		</div>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table31">
			<tr>
				<td height="10"><!----></td>
			</tr>
		</table>
		<div align="center">
			<table border="0" cellpadding="0" cellspacing="0" width="90%" id="table26" style="border: 1px solid #A9A9A9" bgcolor="#FFFFFF">
				<tr>
					<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table27" background="/webadmin/images/bk11.gif" height="24">
						<tr>
							<td>　<b>系统管理</b></td>
						</tr>
					</table>
					<div align="center">
						<table border="0" cellpadding="0" cellspacing="0" width="85%" id="table33">
							
							<tr>
								<td width="22">
								<SCRIPT LANGUAGE="JavaScript"> 
   var data={};
   data["-1_70"] = "text:商贸供求系统";
   	data['70_7007'] = 'text:租赁调剂;url:javascript:void(0);target:right'; 
 	data['7007_700704'] = 'text:最新租赁信息;url:/webadmin/rent/rent_lastnews_list.jsp;target:right'; 
  	data['70_7099'] = 'text:会员管理;url:javascript:void(0);target:right'; 
     
	data['7099_709901'] = 'text:会员管理;url:/webadmin/member/member_list.jsp;target:right'; 
	var xmlstr='';
    Using("System.Web.UI.WebControls.MzTreeView");
    var a = new MzTreeView();
    a.dataSource = data
    a.loadXmlDataString(xmlstr, 1);
    //a.rootId="1";
    a.autoSort=false;
    a.useCheckbox=false
    a.canOperate=true;
    document.write(a.render());
    a.expandLevel(2);
	
	
</SCRIPT>
								</td>
							</tr>
						</table>
					</div>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table34">
						<tr>
							<td height="10"><!----></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
		</div>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table35">
			<tr>
				<td height="10"><!----></td>
			</tr>
		</table>
		<div align="center">
			<table border="0" cellpadding="0" cellspacing="0" width="90%" id="table41" style="border: 1px solid #A9A9A9" bgcolor="#FFFFFF">
				<tr>
					<td>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table42" background="/webadmin/images/bk11.gif" height="24">
						<tr>
							<td>　<b>工具区</b></td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table46">
						<tr>
							<td height="10"><!----></td>
						</tr>
					</table>
					<div align="center">
						<table border="0" cellpadding="0" cellspacing="0" width="85%" id="table47">
							<tr>
								<td width="22">
								<img border="0" src="/webadmin/images/admin/left014.gif" width="22" height="21"></td>
								<td width="100%">帮助</td>
							</tr>
						</table>
					</div>
					<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table48">
						<tr>
							<td height="10"><!----></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
		</div>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table32">
			<tr>
				<td height="10"><!----></td>
			</tr>
		</table>
</body>
</html>
 <%
}catch(Exception e){e.printStackTrace();}
finally{
catalog_no=null; 
parent_id=null;
catalog_name=null;
back_link=null;
}
%>
