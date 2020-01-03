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
out.print("==================");
sql ="select Top 100 Brand,BRAND_NAME from WEBPARTS";
rs = DataManager.executeQueryDB2(conn,sql);// CAST(DETAIL AS VARCHAR(32672))
String busi="";
String ca="";
int ii=1;
try{
while(rs.next()){
	ii++;
	


	insSql = "insert into parts_brand(id,name)"
			+"  values('"+rs.getString("Brand")+"','"+rs.getString("BRAND_NAME")+"')";

	
	out.println(insSql);
	//insSql = insSql.replace("\"","");
	//out.print(rs.getString("STORE")+"--"+insSql+"<br>");
	int intinsert = DataManager.dataOperation(connms,insSql);
	out.println(intinsert);
%>


<%
System.out.println("=="+ii+"----:");
}

}catch(Exception e){
	out.print(e.getStackTrace());
	out.print(e.getMessage());
	e.printStackTrace();
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

