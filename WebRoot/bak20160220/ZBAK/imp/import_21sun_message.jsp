<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库,3:表示调用的租赁数据库据库
	PoolManager pool1 = new PoolManager(1);
	DataManager dataManager1=new DataManager();
	Connection conn1=pool1.getConnection();
	
	PoolManager pool2 = new PoolManager(2);
  Connection conn2=pool2.getConnection();
	
//String columnsInfo[][] =DataManager.fetchFieldValueDB2(pool2, "TECHARTICLE","TITLE,PUBDATE,ISPUBLISHED,DETAIL,HTMFILE,CATEIDS,MODEIDS,CLICKED,AUTHOR", " 1=1 and ISPUBLISHED=1 order by PUBDATE desc ",2905);
				
ResultSet rs=DataManager.executeQueryDB2(conn2, "select '','',name,IP,'',ISPUBLISHED,name,TELEPHONE,EMAIL,TITLE,cast(detail1 as varchar(4000)),cast(detail2 as varchar(4000)),PUBDATE,PUBTIME,1,id,replydate,replytime from feedback where 1=1 and ISPUBLISHED=1  and id>7708 order by id");

String catalog_no="";
String sql="";
int k=0;
try{
while(rs.next())
{k=k+1;

sql="insert into member_message(province,recipients_mem_no,sender_mem_no,add_ip,info_id,is_pub,sender_mem_name,TELEPHONE,EMAIL,TITLE,content,reply_content,add_date,is_read,db2id,reply_date,sort_flag,site_flag)values('"+Common.getFormatStr(rs.getString(1))+"','"+Common.getFormatStr(rs.getString(2))+"','"+Common.getFormatStr(rs.getString(3))+"','"+Common.getFormatStr(rs.getString(4))+"','"+Common.getFormatStr(rs.getString(5))+"','"+Common.getFormatStr(rs.getString(6))+"','"+Common.getFormatStr(rs.getString(7))+"','"+Common.getFormatStr(rs.getString(8))+"','"+Common.getFormatStr(rs.getString(9))+"','"+Common.getFormatStr(rs.getString(10))+"','"+Common.getFormatStr(rs.getString(11)).replace("\r\n","<br>")+"','"+Common.getFormatStr(rs.getString(12)).replace("\r\n","<br>")+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate(13))+" "+Common.getFormatStr(rs.getString(14))+"','"+Common.getFormatStr(rs.getString(15))+"','"+Common.getFormatStr(rs.getString(16))+"','"+Common.getFormatStr(rs.getString(17))+" "+Common.getFormatStr(rs.getString(18))+"','1',3)";





dataManager1.dataOperation(conn1, sql);

sql="";
 }

}
catch(Exception e)
{;}
finally{
pool1.freeConnection(conn1);
pool2.freeConnection(conn2);}

out.println("导入成功!");
%>