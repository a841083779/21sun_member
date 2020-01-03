<%@page contentType="text/html;charset=utf-8" import="com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.*,java.net.*"%> 
<%
String titlename="获奖用户区域统计";	
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment; filename="+new String((titlename).getBytes(),"iso8859-1")+".xls"); 
%>
<%
	PoolManager pool = (PoolManager)application.getAttribute("poolAPP");
	if(pool == null){
		pool = new PoolManager();
	}
	DataManager dataManager = new DataManager();
	Connection conn = null;

	try{
		conn = pool.getConnection();
		//地区
		String countPorStr = "SELECT per_province,COUNT(per_province) as count  from  member_info WHERE (jiang is not NULL or jiang_chuli is not null)  and mem_name is not null and mem_name<>'' and per_province is not null and per_province<>'' GROUP BY per_province ORDER BY count desc";
		ResultSet rsPor = dataManager.executeQuery(conn,countPorStr);
%>
<HTML>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head><title>Test</title></head>
<body>
<table>
          <tr>
            <td>区域</td>
            <td>数量</td>
          </tr>
<%
while(rsPor.next()){
	String	countPor=Common.getFormatStr(rsPor.getString("count"));
	String	per_province=Common.getFormatStr(rsPor.getString("per_province"));
%>
          <tr>
            <td><%=per_province %></td>
            <td><%=countPor %></td>
          </tr>
<%
}
%>
</table>
</body>
</HTML>
<%

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
	%>
