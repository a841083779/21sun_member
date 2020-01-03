<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库
	PoolManager pool1 = new PoolManager(1);
	DataManager dataManager1=new DataManager();
	Connection conn1=pool1.getConnection();
	
	PoolManager pool2 = new PoolManager(2);
   Connection conn2=pool2.getConnection();
	

ResultSet rs=DataManager.executeQueryDB2(conn2, "select count(id) from TECHARTICLE where 1=1 and ISPUBLISHED=1 ");
while(rs.next())
{out.print(rs.getString(1));}

pool1.freeConnection(conn1);
pool2.freeConnection(conn2);
//out.println("提交成功");
%>