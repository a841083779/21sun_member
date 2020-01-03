<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库,3:表示调用的租赁数据库据库
	PoolManager pool1 = new PoolManager(3);
	DataManager dataManager1=new DataManager();
	Connection conn1=pool1.getConnection();
	
	PoolManager pool2 = new PoolManager(2);
  Connection conn2=pool2.getConnection();
	
//String columnsInfo[][] =DataManager.fetchFieldValueDB2(pool2, "TECHARTICLE","TITLE,PUBDATE,ISPUBLISHED,DETAIL,HTMFILE,CATEIDS,MODEIDS,CLICKED,AUTHOR", " 1=1 and ISPUBLISHED=1 order by PUBDATE desc ",2905);
				
ResultSet rs=DataManager.executeQueryDB2(conn2, "select PROID,RECIEVER,SENDER,IP,ABOUTINFO,ISPUBLISHED,fullname,TELEPHONE,EMAIL,TITLE,cast(DETAIL_S as varchar(4000)),cast(DETAIL_R as varchar(4000)),PUBDATE,PUBTIME,ISREAD,id from ZL_FEEDBACK where 1=1 and ISPUBLISHED=1 order by id");

String catalog_no="";
String sql="";
int k=0;
while(rs.next())
{k=k+1;

sql="insert into rent_message(PROID,receiver,SENDER,add_ip,ABOUTINFO,is_pub,mem_name,TELEPHONE,EMAIL,TITLE,content,reply,pubdate,PUBTIME,ISREAD,db2id,catalog_no)values('"+Common.getFormatStr(rs.getString(1))+"','"+Common.getFormatStr(rs.getString(2))+"','"+Common.getFormatStr(rs.getString(3))+"','"+Common.getFormatStr(rs.getString(4))+"','"+Common.getFormatStr(rs.getString(5))+"','"+Common.getFormatStr(rs.getString(6))+"','"+Common.getFormatStr(rs.getString(7))+"','"+Common.getFormatStr(rs.getString(8))+"','"+Common.getFormatStr(rs.getString(9))+"','"+Common.getFormatStr(rs.getString(10))+"','"+Common.getFormatStr(rs.getString(11)).replace("\r\n","<br>")+"','"+Common.getFormatStr(rs.getString(12)).replace("\r\n","<br>")+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate(13))+"','"+Common.getFormatStr(rs.getString(14))+"','"+Common.getFormatStr(rs.getString(15))+"','"+Common.getFormatStr(rs.getString(16))+"','700703')";
dataManager1.dataOperation(conn1, sql);
sql="";
}

pool1.freeConnection(conn1);
pool2.freeConnection(conn2);
out.println("导入成功!");
%>