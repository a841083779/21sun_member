<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.util.Map.Entry"%>
<%@ include file ="../manage/config.jsp"%>
<%
String titlename="求购信息";	
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename="+new String((titlename).getBytes(),"iso8859-1")+".xls"); 
%>
<%
pool = new PoolManager(5);
DataManager dataManager = new DataManager();
Connection conn =null;
String tablename="sell_buy_market";

String query ="select top 1000 * from "+tablename+" where 1=1  ";
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query += " and title like '%"+title+"%'";
}
 String find_mem_no=Common.getFormatStr(request.getParameter("find_mem_no"));
if(!find_mem_no.equals("")){
	query += " and mem_no ='"+find_mem_no+"'";
}

 String find_mem_flag=Common.getFormatStr(request.getParameter("find_mem_flag"));
if(!find_mem_flag.equals("")){
	query += " and mem_flag ='"+find_mem_flag+"'";
}

String find_date_start=Common.getFormatStr(request.getParameter("find_date_start"));
if(!find_date_start.equals("")){
	query += " and CONVERT(varchar(12) ,pub_date, 23 ) >='"+find_date_start+"' ";
}
String find_date_end=Common.getFormatStr(request.getParameter("find_date_end"));
if(!find_date_end.equals("")){
	query += " and CONVERT(varchar(12) ,pub_date, 23 )<='"+find_date_end+"' ";
}

//String find_category = Common.getFormatStr(request.getParameter("find_category"));
String find_category = "11";
if(!find_category.equals("")){
   query += " and business_flag ='"+find_category+"' ";
}

String find_company =  Common.getFormatStr(request.getParameter("find_company"));
if(!find_company.equals("")){
   query += " and company like '%"+find_company+"%' ";
}
query += " order by id desc ";
System.out.println(query);
try{
	conn = pool.getConnection();
	//SQL查询	
	ResultSet rs = dataManager.executeQuery(conn,query);
%>
<HTML>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head><title>Test</title></head>
<body>
<table width="100%" border="1" cellpadding="4" cellspacing="1" bgcolor="#000000" class="table_border_bg">
    <tr >
    	<td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>发布时间</strong></span></td>
    	<td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>求购信息</strong></span></td>
      	<td nowrap bgcolor="#0000FF" class="title1"><strong class="list_border_bg STYLE1">发布人</strong></td>
      	<td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>电话</strong></span></td>
      	<td colspan="2" nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>所在地区</strong></span></td>
      	<td nowrap bgcolor="#0000FF" class="title1"><span class="STYLE1"><strong>公司</strong></span></td>
      	<td nowrap bgcolor="#0000FF" class="title1" colspan="4"><span class="STYLE1"><strong>描述</strong></span></td>
    </tr>
    <%
	while(rs.next()){
%>
    <tr class="table_border_cell_bg" onMouseMove="mouseMove(this);" onMouseOut="mouseOut(this);">
    	<td height="22" align="left" bgcolor="#FFFFFF" title="">[<%=Common.getFormatStr(rs.getString("pub_date").substring(0,10))%>]</td>
    	<td align="left" bgcolor="#FFFFFF" title=""><%=Common.getFormatStr(rs.getString("title"))%></td>
    	<td height="22" align="left" bgcolor="#FFFFFF" title=""><%=Common.getFormatStr(rs.getString("mem_name"))%></td>
    	<td align="left" bgcolor="#FFFFFF" title=""><%=Common.getFormatStr(rs.getString("tel"))%></td>
	    <td align="left" bgcolor="#FFFFFF" title="">[<%=Common.getFormatStr(rs.getString("province"))%>]省</td>
	    <td align="left" bgcolor="#FFFFFF" title="">[<%=Common.getFormatStr(rs.getString("city"))%>]市</td>
	    <td align="left" bgcolor="#FFFFFF" title=""><%=Common.getFormatStr(rs.getString("company"))%></td>
	    <td height="22" colspan="4"  bgcolor="#FFFFFF" title=""><%=Common.getFormatStr(rs.getString("descr"))%></td>
    </tr>
    <%}%>
  </table>
</body>
</HTML>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
