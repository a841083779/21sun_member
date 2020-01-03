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
rs=DataManager.executeQuery(connms,"select max(db2id) from market_parts01");
int db2id = 0;
if(rs.next()){
	db2id = rs.getInt(1);
}


sql ="select id,mid,title,Detail,brand,direction,subdirection,province,city,pubdate,enddate,ispublished,endcount,clicked from part_market where id> "+db2id;
rs = DataManager.executeQueryDB2(conn,sql);// CAST(DETAIL AS VARCHAR(32672))

String busi="";
String is_urgent="";
int ii=1;
while(rs.next()){
	ii++;
	busi = rs.getString("subdirection");
	if(busi.equals("103")){
		is_urgent="2";
		busi = "102";
	}else{
		is_urgent="1";
	}
	if(null==rs.getString("enddate")){
		insSql = "insert into market_parts01(add_date,mem_no,cata_num,brand,title,content,view_count,"
			+"is_urgent,is_show,province,city,is_new,db2id) values('"+rs.getString("pubdate")+"','"+rs.getString("mid")+"','"+rs.getString("subdirection")+"','"+rs.getString("brand")+"','"+rs.getString("title")+"','"+rs.getString("Detail").replaceAll("\\n","<br>").replaceAll("'","''")+"','"+rs.getString("clicked")+"','"+is_urgent+"','"+rs.getString("ispublished")+"','"+rs.getString("province")+"','"+rs.getString("city")+"',"+rs.getString("direction")+","+rs.getString("id")+")";
	}else{
		insSql = "insert into market_parts01(add_date,mem_no,cata_num,brand,title,content,view_count,"
			+"is_urgent,is_show,province,city,valid_out,is_new,db2id) values('"+rs.getString("pubdate")+"','"+rs.getString("mid")+"','"+rs.getString("subdirection")+"','"+rs.getString("brand")+"','"+rs.getString("title")+"','"+rs.getString("Detail").replaceAll("\\n","<br>").replaceAll("'","''")+"','"+rs.getString("clicked")+"','"+is_urgent+"','"+rs.getString("ispublished")+"','"+rs.getString("province")+"','"+rs.getString("city")+"','"+rs.getString("enddate")+"',"+rs.getString("direction")+","+rs.getString("id")+")";
	}
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

