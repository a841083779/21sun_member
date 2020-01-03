<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@ include file ="../manage/config.jsp"%>
<%//=====得到参数=====
//===专栏的类型====
String catalogNo=Common.getFormatStr(request.getParameter("catalogNo"));
if(catalogNo.equals(""))
catalogNo="70";

String specialColumnsName="商贸网供求";
Connection conn=null;
ResultSet rs =null;
StringBuffer query=new StringBuffer();

//====列表中的临时字段===
String tempCatalogNo=""; 
String tempParentId="";
String tempCatalogName="";
String tempBackLink="";
String tempCatalogImage="";
//==========
try{
conn=pool.getConnection();
query.append("select catalog_no,catalog_name,parent_id,back_link,catalog_image from cmbol_columns_info where is_show = 1 and subweb_no=7 and parent_id ='"+catalogNo+"' ");
//======
query.append(" order by order_no");
//out.print(query.toString());
rs=DataManager.executeQuery(conn,query.toString());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>main</title>
<link rel="stylesheet" href="/webadmin/style/oper_area_style.css">
</head>

<body>

<table width="100%" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
  <tr>
    <td width="1%"><%=specialColumnsName%></td>
    <td width="98%" background="../images/admin/htback01.gif">&nbsp;</td>
    <td width="1%"><img src="../images/admin/hd02.gif" width="9" height="21"></td>
  </tr>
  <tr>
    <td colspan="2" style="border-left:1px solid #D6D5D9">
	<div class="k01">
	 <%while(rs!=null && rs.next()){
 	 tempCatalogNo=Common.getFormatStr(rs.getString("catalog_no"));
 	 tempParentId=Common.getFormatStr(rs.getString("parent_id"));
	 tempCatalogName=Common.getFormatStr(rs.getString("catalog_name"));
	 tempBackLink=Common.getFormatStr(rs.getString("back_link"));
	 tempCatalogImage=Common.getFormatStr(rs.getString("catalog_image"));
	 %>
	<div class="k02">
	<div class="k03"><a href="<%=tempBackLink.equals("")?"javascript:void(0)":tempBackLink%>" target="right"><img src="<%=tempCatalogImage%>" width="42" height="31" border="0"></a></div>
	<div class="k04"><a href="<%=tempBackLink.equals("")?"javascript:void(0)":tempBackLink%>" target="right"><%=tempCatalogName%></a></div>
	</div>
	<%}%>
	
</div>

	
	
	
	<br>
        <br></td>
    <td width="1%" style="border-right:1px solid #D6D5D9">&nbsp;</td>
  </tr>
  <tr>
    <td width="1%" valign="bottom"><img src="../images/admin/hd03.gif" width="77" height="10"></td>
    <td width="98%" height="10" style="border-bottom:1px solid #D6D5D9;line-height:9px;">&nbsp;</td>
    <td width="1%" valign="bottom"><img src="../images/admin/hd05.gif" width="9" height="10"></td>
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
tempCatalogNo=null; 
tempParentId=null;
tempCatalogName=null;
tempBackLink=null;
tempCatalogImage=null;
specialColumnsName=null;
}
%>

