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

sql ="select ID,AREA,CATIDS,TITLE,cast(detail as varchar(4000)) as detail,ISPUBLISHED,pubdate from biddingnews  ";
rs = DataManager.executeQueryDB2(conn,sql);// CAST(DETAIL AS VARCHAR(32672))
String busi="";
String ca="";
int ii=1;
while(rs.next()){
	ii++;
	//out.print(rs.getString("title")+"<br>");
	
	insSql = "insert into article_other(title,content,sort_num,area_flag,view_count,is_pub,pub_date,catalog_no) values('"+rs.getString("TITLE")+"','"+rs.getString("DETAIL")+"','"+rs.getString("CATIDS").replace(" ","")+"','"+rs.getString("AREA")+"',1,"+rs.getString("ISPUBLISHED")+",'"+rs.getString("pubdate")+"','700202')";
	insSql = insSql.replace("\"","");
	int intinsert = DataManager.dataOperation(connms,insSql);

%>

  <tr>
    <td>&nbsp;<br />
<br />
<%=rs.getString("pubdate")+"=="+ii+"--"%></td>

  </tr>

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

