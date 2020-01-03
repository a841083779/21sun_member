<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库
	PoolManager pool1 = new PoolManager(1);
	DataManager dataManager1=new DataManager();
	Connection conn1=pool1.getConnection();
	
	PoolManager pool2 = new PoolManager(2);
  Connection conn2=pool2.getConnection();
	
//String columnsInfo[][] =DataManager.fetchFieldValueDB2(pool2, "TECHARTICLE","TITLE,PUBDATE,ISPUBLISHED,DETAIL,HTMFILE,CATEIDS,MODEIDS,CLICKED,AUTHOR", " 1=1 and ISPUBLISHED=1 order by PUBDATE desc ",2905);
				
ResultSet rs=DataManager.executeQueryDB2(conn2, "select TITLE,PUBDATE,ISPUBLISHED,cast(DETAIL as varchar(4000)),HTMFILE,CATEIDS,SUBCATEIDS,CLICKED,AUTHOR,IMG1,IMGTITLE1,IMG2,IMGTITLE2,IMG3,IMGTITLE3,IMG4,IMGTITLE4,IMG5,IMGTITLE5,IMG6,IMGTITLE6,IMG7,IMGTITLE7,IMG8,IMGTITLE8,IMG9,IMGTITLE9,IMG10,IMGTITLE10 from TECHARTICLE where 1=1 and ISPUBLISHED=1 ");

String catalog_no="";
String sql="";
int k=0;
while(rs.next())
{k=k+1;
if(Common.getFormatStr(rs.getString(6)).equals("0700"))
catalog_no="700401";
else 
catalog_no="700301";

sql="insert into article_other_test(title,pub_date,is_pub,content,html_filename,sort_num,sub_sort_num,view_count,author,catalog_no,IMG1,IMGTITLE1,IMG2,IMGTITLE2,IMG3,IMGTITLE3,IMG4,IMGTITLE4,IMG5,IMGTITLE5,IMG6,IMGTITLE6,IMG7,IMGTITLE7,IMG8,IMGTITLE8,IMG9,IMGTITLE9,IMG10,IMGTITLE10)values('"+Common.getFormatStr(rs.getString(1))+"','"+Common.getFormatStr(rs.getString(2))+"','"+Common.getFormatStr(rs.getString(3))+"','"+Common.getFormatStr(rs.getString(4))+"','"+Common.getFormatDate("yyyyMMddHHmmssSSS", rs.getDate(2))+"_"+k+".htm"+"','"+Common.getFormatStr(rs.getString(6))+"','"+Common.getFormatStr(rs.getString(7))+"','"+Common.getFormatStr(rs.getString(8))+"','"+Common.getFormatStr(rs.getString(9))+"','"+catalog_no+"','"+Common.getFormatStr(rs.getString(10))+"','"+Common.getFormatStr(rs.getString(11))+"','"+Common.getFormatStr(rs.getString(12))+"','"+Common.getFormatStr(rs.getString(13))+"','"+Common.getFormatStr(rs.getString(14))+"','"+Common.getFormatStr(rs.getString(15))+"','"+Common.getFormatStr(rs.getString(16))+"','"+Common.getFormatStr(rs.getString(17))+"','"+Common.getFormatStr(rs.getString(18))+"','"+Common.getFormatStr(rs.getString(19))+"','"+Common.getFormatStr(rs.getString(20))+"','"+Common.getFormatStr(rs.getString(21))+"','"+Common.getFormatStr(rs.getString(22))+"','"+Common.getFormatStr(rs.getString(23))+"','"+Common.getFormatStr(rs.getString(24))+"','"+Common.getFormatStr(rs.getString(25))+"','"+Common.getFormatStr(rs.getString(26))+"','"+Common.getFormatStr(rs.getString(27))+"','"+Common.getFormatStr(rs.getString(28))+"','"+Common.getFormatStr(rs.getString(29))+"')";
dataManager1.dataOperation(conn1, sql);
sql="";
}

pool1.freeConnection(conn1);
pool2.freeConnection(conn2);
out.println("导入成功!");
%>