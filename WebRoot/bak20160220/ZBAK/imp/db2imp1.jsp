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

sql ="select id,title,orgNo,class,level,fullname,exportright,province,address,postcode,tel,email,fax,www,detail,ispublished,regdate from biddingorg ";
rs = DataManager.executeQueryDB2(conn,sql);
String busi="";
String ca="";
while(rs.next()){
	
	out.print(rs.getString("title")+"<br>");
	
	insSql = "insert into bidding_organization(name,org_no,flag,class,contact,imp_exp,province,address,postcode,tel,fax,email,url,intro,is_show,in_date) values('"+rs.getString("title")+"','"+rs.getString("orgNo")+"','"+rs.getString("class")+"','"+rs.getString("level")+"','"+rs.getString("fullname")+"','"+rs.getString("exportright")+"','"+rs.getString("Province")+"','"+rs.getString("address")+"','"+rs.getString("postcode")+"','"+rs.getString("tel")+"','"+rs.getString("fax")+"','"+rs.getString("EMAIL")+"','"+rs.getString("www")+"','"+rs.getString("detail")+"','"+rs.getString("ISPUBLISHED")+"','"+rs.getString("regdate")+"')";
	insSql = insSql.replace("\"","");
	int intinsert = DataManager.dataOperation(connms,insSql);

%>

  <tr>
    <td>&nbsp;<%="--"+insSql%></td>

  </tr>

<%
}
%>
</table>
<br />


<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	poolms.freeConnection(connms);
}


%>

