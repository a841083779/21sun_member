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

sql ="select ID, MID, CATIDS, PRICEX, STORE, MODEL, Brand, MOUNT, Description,PUBDATE,enddate,ISPUBLISHED,level,TITLE from WEBPARTS where 1=1 order by id desc  FETCH   FIRST   100   ROWS   ONLY";
rs = DataManager.executeQueryDB2(conn,sql);// CAST(DETAIL AS VARCHAR(32672))
String busi="";
String ca="";
int ii=1;
while(rs.next()){
	ii++;
	
	String pros[]=rs.getString("STORE").split("--");
	String a1="";
	String a2="";
	if(pros.length==2){
		a1=pros[0];
		a2=pros[1];
	}
	insSql = "insert into market_parts02(add_date,mem_no,cata_num,brand,part_no,part_name,model,price,warehouse_count,province,city,is_show,flag,valid_date,db2id) values('"+rs.getString("PUBDATE")+"','"+rs.getString("MID")+"','','"+rs.getString("Brand")+"','"+rs.getString("TITLE")+"','"+rs.getString("Description")+"','"+rs.getString("MODEL")+"','"+rs.getString("PRICEX")+"','"+rs.getString("MOUNT")+"','"+a1+"','"+a2+"','"+rs.getString("ISPUBLISHED")+"','"+rs.getString("level")+"','"+rs.getString("enddate")+"','"+rs.getString("id")+"')";
	//insSql = insSql.replace("\"","");
	//out.print(rs.getString("STORE")+"--"+insSql+"<br>");
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

