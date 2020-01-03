<%@ page language="java" import="java.util.*,javax.sql.*,javax.naming.*,java.sql.*,com.jerehnet.cmbol.database.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


PoolManager pool = new PoolManager(2);

ResultSet rs = DataManager.executeQueryDB2(pool.getConnection(),"select count(*) from part_market where mid='TONG1223' fetch first 100 rows only");

ResultSetMetaData rsmd = null;
int k = 0;
int count = 0 ;
%>
	<table border="1" cellspacing="1">
	<%
while(rs.next()){
	if(k==0){
	rsmd = rs.getMetaData();
	count = rsmd.getColumnCount();
	%>

	<tr bgcolor="#A0C5FF">
	<%

	for(int i=1;i<=rsmd.getColumnCount();i++){
		%>
		<td><%=rsmd.getColumnName(i).toLowerCase()+"("+rsmd.getColumnType(i)+")"%></td>
		
		<%
	}
	%>
	</tr>
	<%
	}
	%>
	<tr>
	<%
	for(int i=1;i<=count;i++){
	%>
	<td><%=rs.getString(i) %>&nbsp;</td>
	<%} %>
	</tr>
	<%
	k++;
}

//Class.forName("com.p6spy.engine.spy.P6SpyDriver");

//Connection con = DriverManager.getConnection("jdbc:db2://192.168.0.231:6789/WEBDB115","db2admin","12345678");
%>
</table>

