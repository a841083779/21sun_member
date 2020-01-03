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

sql ="select ID, level from WEBPARTS order by id";
rs = DataManager.executeQueryDB2(conn,sql);// CAST(DETAIL AS VARCHAR(32672))

String busi="";
String is_urgent="";
int ii=1;
while(rs.next()){
	ii++;

	if(rs.getString(2)!=null&&rs.getString(2).equals("4")){
		insSql = "update supply_partstore set old=2 where sid="+rs.getString(1)+"";
		//insSql = insSql.replace("\"","");
		//out.print(insSql+"<br>");
		int intinsert = DataManager.dataOperation(connms,insSql);
	}
%>


<%
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

