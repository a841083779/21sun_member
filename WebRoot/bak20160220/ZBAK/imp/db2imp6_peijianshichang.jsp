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

sql ="select ID,MID,title,Detail,brand,direction,SubDirection,Province,city,pubdate,EndDate,ispublished,EndCount,clicked from Part_Market where SubDirection=102 order by id desc FETCH   FIRST   100   ROWS   ONLY";
rs = DataManager.executeQueryDB2(conn,sql);// CAST(DETAIL AS VARCHAR(32672))
String busi="";
String is_urgent="";
int ii=1;
while(rs.next()){
	ii++;
	busi = rs.getString("SubDirection");
	if(busi.equals("103")){
		is_urgent="2";
		busi = "102";
	}else{
		is_urgent="1";
	}
	
	insSql = "insert into market_parts01(add_date,mem_no,cata_num,brand,title,content,view_count,is_urgent,is_show,province,city,valid_date,is_new,db2id) values('"+rs.getString("pubdate")+"','"+rs.getString("MID")+"','"+rs.getString("subdirection")+"','"+rs.getString("brand")+"','"+rs.getString("title")+"','"+rs.getString("Detail")+"','"+rs.getString("clicked")+"','"+is_urgent+"','"+rs.getString("ispublished")+"','"+rs.getString("Province")+"','"+rs.getString("city")+"','"+rs.getString("EndDate")+"',"+rs.getString("direction")+","+rs.getString("id")+")";
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

