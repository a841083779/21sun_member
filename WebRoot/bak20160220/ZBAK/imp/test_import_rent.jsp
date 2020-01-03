<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库,3:表示调用的租赁数据库,4:表示调用二手的数据
	PoolManager pool1 = new PoolManager(4);
	Connection conn1=pool1.getConnection();
	
PoolManager pool2 = new PoolManager(2);
Connection conn2=pool2.getConnection();
	

try{
//ResultSet rs=DataManager.executeQueryDB2(conn2, "select MID,PUBDATE,EXTRADATE,ISPUBLISHED,CLICKED,TITLE,MODEL,BRAND,CATEGORY,SUBCATEGORY,PROVINCE,CITY,PLACE,PRICE,AMOUNT ,cast(DETAIL as varchar(4000)) as DETAIL,IMG1,IMG2,infoCLASS,id from USEDMARKET where mid='SHRIZHAO' and INFOCLASS=1 and ISPUBLISHED=1  order by id");

				
ResultSet rs=DataManager.executeQueryDB2(conn2, "select count(MID) as cou from WEBRENT ");
//out.println("---配件仓库-(181213)-");
	if(rs.next())
	{
	out.println(rs.getString("cou"));
	}
	
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	pool1.freeConnection(conn1);
	pool2.freeConnection(conn2);
}


%>--------