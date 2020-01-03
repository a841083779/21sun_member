<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%>

<%

PoolManager pool = new PoolManager(2);
PoolManager poolms = new PoolManager(7);

Connection conn =null;
Connection connms =null;
ResultSet rs = null;
ResultSet rs2 = null;

String sql ="";

String insSql="";

try{

conn = pool.getConnection();
connms = poolms.getConnection();
%>

分类：<br />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td nowrap="nowrap">&nbsp;sql</td>


  </tr>

<%

sql ="select id,name_ch from part_lstbrand ";
rs = DataManager.executeQueryDB2(conn,sql);// CAST(DETAIL AS VARCHAR(32672))

String busi="";
String is_urgent="";
int ii=1;
while(rs.next()){
	ii++;


		insSql = "insert into part_lstbrand(id,name) values ("+rs.getString(1)+",'"+rs.getString(2)+"')";

	//insSql = insSql.replace("\"","");
	//out.print(insSql+"<br>");
	int intinsert = DataManager.dataOperation(connms,insSql);

%>


<%
System.out.println("=="+ii+"----:");
}


%>
</table>
<br />


<%
out.print("==========total:"+ii);

}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	poolms.freeConnection(connms);
}


%>

