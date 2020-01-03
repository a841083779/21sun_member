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
//====查找db2中最大的id===
String tempdbId[][]=DataManager.fetchFieldValue(pool1,"rent_news", "max(convert(bigint,db2id))", "");
String db2Id="99999999";
if(tempdbId!=null)
db2Id=Common.getFormatStr(tempdbId[0][0]);

ResultSet rs=DataManager.executeQueryDB2(conn2, "select AREA,CATIDS,TITLE,KEYWORDS,cast(DETAIL as varchar(4000)),FROM,URL,PUBDATE,PUBTIME,CLICKED,ISPUBLISHED,PUBDAYS,ORDER,IMG1,IMGTITLE1,IMG2,IMGTITLE2,IMG3,IMGTITLE3,IMG4,IMGTITLE4,id from zl_news where 1=1 and ISPUBLISHED=1 and id>"+db2Id+" order by id");

String catalog_no="";
String sql="";
int k=0;
try{
while(rs.next())
{k=k+1;
sql="insert into rent_news(AREA,category,TITLE,KEYWORDS,content,source,URL,PUBDATE,PUBTIME,CLICKED,is_pub,PUBDAYS,sort,other_content,catalog_no,html_filename,db2id)values('"+Common.getFormatStr(rs.getString(1))+"','"+Common.getFormatStr(rs.getString(2))+"','"+Common.getFormatStr(rs.getString(3))+"','"+Common.getFormatStr(rs.getString(4))+"','"+Common.getFormatStr(rs.getString(5)).replace("\r\n","<br>")+"','"+Common.getFormatStr(rs.getString(6))+"','"+Common.getFormatStr(rs.getString(7))+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate(8))+"','"+Common.getFormatStr(rs.getString(9))+"','"+Common.getFormatStr(rs.getString(10))+"','"+Common.getFormatStr(rs.getString(11))+"','"+Common.getFormatStr(rs.getString(12))+"','"+Common.getFormatStr(rs.getString(13))+"','"+Common.getFormatStr(rs.getString(14))+";"+Common.getFormatStr(rs.getString(15))+";"+Common.getFormatStr(rs.getString(16))+";"+Common.getFormatStr(rs.getString(17))+";"+Common.getFormatStr(rs.getString(18))+";"+Common.getFormatStr(rs.getString(19))+";"+Common.getFormatStr(rs.getString(20))+";"+Common.getFormatStr(rs.getString(21))+"','700702','"+Common.getFormatDate("yyyyMMddHHmmssSSS", rs.getDate(8))+"_"+k+".htm','"+Common.getFormatStr(rs.getString(22))+"')";
dataManager1.dataOperation(conn1, sql);
sql="";
}

}
catch(Exception e)
{;}
finally{
pool1.freeConnection(conn1);
pool2.freeConnection(conn2);
}


out.println("导入成功!");
%>