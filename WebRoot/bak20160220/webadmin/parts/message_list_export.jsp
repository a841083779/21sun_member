<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.util.Map.Entry"%>
<%@ include file ="../manage/config.jsp"%>
<%
String titlename="配件留言信息";	
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename="+new String((titlename).getBytes(),"iso8859-1")+".xls"); 
%>
<%
pool = new PoolManager(1);
DataManager dataManager = new DataManager();
Connection conn =null;

String query ="select top 1000 * from member_message where 1=1 and site_flag=4  ";
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query += " and title like '%"+title+"%'";
}
String sort_flag=Common.getFormatStr(request.getParameter("sort_flag"));
if(!sort_flag.equals("")){
	query += " and sort_flag="+sort_flag;
}
query += " order by id desc ";
try{
	conn = pool.getConnection();
	//SQL查询	
	ResultSet rs = dataManager.executeQuery(conn,query);
%>
<HTML>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head><title>Test</title></head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td width="10%" align="center" bgcolor="e8f2ff">留言人</td>
          	<td width="1=%" align="center" bgcolor="e8f2ff">会员号</td>
            <td width="44%" bgcolor="e8f2ff"><strong>留言内容</strong></td>
            <td width="7%" bgcolor="e8f2ff"><strong>留言类型</strong></td>
            <td width="10%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>日期</strong></span></div></td>
            <td width="7%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否发布</strong></span></div></td>
          </tr>
          <%
          	  int k=0;
			  while (rs!=null && rs.next()){
				  String temp_sort_flag=Common.getFormatStr(rs.getString("sort_flag"));
		  %>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
          	<td><%=Common.getFormatStr(rs.getString("sender_mem_name")) %></td>
          	<td><%=Common.getFormatStr(rs.getString("recipients_mem_no")) %></td>
            <td><%=Common.getFormatStr(rs.getString("content"))%></td>
            <td><%if(temp_sort_flag.equals("1"))out.print("供货");else if(temp_sort_flag.equals("2"))out.print("询价");%></td>
            <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd HH:mm",rs.getDate("add_date"))%></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_pub")).equals("1")?"显示":"不显示"%></span></div></td>
          </tr>
          <%
          	  	  k++;
			  }
		  %>
        </table>
</body>
</HTML>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
