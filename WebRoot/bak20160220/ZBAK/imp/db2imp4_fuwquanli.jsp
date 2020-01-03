<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%>

<%

PoolManager pool = new PoolManager(2);
PoolManager poolms = new PoolManager();

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

sql ="select  title,www,image1,ispublished,pubdate from WEBCASE where ispublished=1";
rs = DataManager.executeQueryDB2(conn,sql);// CAST(DETAIL AS VARCHAR(32672))
String busi="";
String ca="";
int ii=1;
while(rs.next()){
	ii++;
	//out.print(rs.getString("title")+"<br>");
	
	insSql = "insert into service_webcase(add_date,title,url,img,is_show) values('"+rs.getString("pubdate")+"','"+rs.getString("title")+"','"+rs.getString("www")+"','"+rs.getString("image1")+"','"+rs.getString("ispublished")+"')";
	//insSql = insSql.replace("\"","");
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

