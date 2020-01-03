<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,java.net.URLDecoder.*,com.jerehnet.util.*"%>
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
conn=pool.getConnection();
query.append("select B.catalog_no,B.catalog_name,B.parent_id,B.back_link from manager_role_purview_new A left outer join cmbol_columns_info B on A.purview_num=B.catalog_no ");
query.append(" where A.role_num='"+admin_mem_flag+"' ");
query.append(" and B.is_show = 1 ");
//======
query.append(" order by B.catalog_no");
// out.print(query.toString());
rs=DataManager.executeQuery(conn,query.toString());
%>
<html>
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
   data["-1_70"] = "text:商贸网后台管理系统";
    <%String target="right";
	while(rs!=null && rs.next()){
	 catalog_no=Common.getFormatStr(rs.getString("catalog_no"));
 	 parent_id=Common.getFormatStr(rs.getString("parent_id"));
	 catalog_name=Common.getFormatStr(rs.getString("catalog_name"));
	 back_link=Common.getFormatStr(rs.getString("back_link"));
	 //====控制外部链接专栏管理、人才网====
	 if(catalog_no.equals("710101")||catalog_no.equals("710106"))
	 {back_link=back_link+"?usern="+usern+"&passw="+java.net.URLEncoder.encode(admin_passw,"UTF-8");
	 target="_blank";
	 }//====资讯中心管理员、行业博客管理员、产品库管理员
	else if(catalog_no.equals("710102")||catalog_no.equals("710103")||catalog_no.equals("710104"))
	 {back_link=back_link+"?usern="+usern+"&passw="+java.net.URLEncoder.encode(admin_passw,"UTF-8")+"&eventNum=3002";
	 target="_blank";
	 } 
	 //杰配网管理
	 else if(catalog_no.equals("710105"))
	{back_link=back_link+"?usern=admin&passw="+java.net.URLEncoder.encode("jereh!@#!@#2011","UTF-8");
	 target="_blank";
	 }else{
		target="right";	//新加 
	 }
	%>
	data['<%=parent_id%>_<%=catalog_no%>'] = 'text:<%=catalog_name%>;url:<%=back_link.equals("")?"javascript:void(0)":back_link%>;target:<%=target%>'; 
     <%}%>	 
     <%
     if(usern.equals("usedadmin")){
    	 %>
  data['7009_700907'] = 'text:二手询价管理;url:/webadmin/used/enquiry_list.jsp;target:right';    
    	 <%
     }
     %>
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
	
</script>
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
pool.freeConnection(conn);
query=null;
conn =null;
//===
rs =null;
catalog_no=null; 
parent_id=null;
catalog_name=null;
back_link=null;
}
%>
