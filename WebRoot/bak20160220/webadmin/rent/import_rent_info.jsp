<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库,3:表示调用的租赁数据库
	PoolManager pool1 = new PoolManager(3);
	DataManager dataManager1=new DataManager();
	Connection conn1=pool1.getConnection();
	
	PoolManager pool2 = new PoolManager(2);
  Connection conn2=pool2.getConnection();
	
//String columnsInfo[][] =DataManager.fetchFieldValueDB2(pool2, "TECHARTICLE","TITLE,PUBDATE,ISPUBLISHED,DETAIL,HTMFILE,CATEIDS,MODEIDS,CLICKED,AUTHOR", " 1=1 and ISPUBLISHED=1 order by PUBDATE desc ",2905);
				
ResultSet rs=DataManager.executeQueryDB2(conn2, "select MID,PUBDATE,PUBDAYS,ISPUBLISHED,CLICKED,TITLE,MODEL,BRAND,CATEGORY,SUBCATEGORY,PROVINCE,CITY,PRICE,AMOUNT ,cast(DETAIL as varchar(4000)),IMG,CLASS,ORDER,ISDONE,id from WEBRENT where 1=1 and ISPUBLISHED=1 order by id");

String catalog_no="";
String sql="";
String temp_img="";
int k=0;
while(rs.next())
{
k=k+1;
if(Common.getFormatStr(rs.getString(6)).equals("0700"))
   catalog_no="700401";
else 
   catalog_no="700301";
if(!Common.getFormatStr(rs.getString(16)).equals(""))
   temp_img="/images/"+Common.getFormatStr(rs.getString(16));
else
   temp_img="";
temp_img=temp_img.toLowerCase();

sql="insert into rent_info(mem_no,mem_name,PUBDATE,PUBDAYS,is_pub,CLICKED,TITLE,MODEL,BRAND,CATEGORY,SUBCATEGORY,PROVINCE,CITY,PRICE,AMOUNT ,content,IMG,CLASS,sort,ISDONE,db2id,catalog_no)values('"+Common.getFormatStr(rs.getString(1))+"','"+Common.getFormatStr(rs.getString(1))+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate(2))+"','"+Common.getFormatStr(rs.getString(3))+"','"+Common.getFormatStr(rs.getString(4))+"','"+Common.getFormatStr(rs.getString(5))+"','"+Common.getFormatStr(rs.getString(6))+"','"+Common.getFormatStr(rs.getString(7))+"','"+Common.getFormatStr(rs.getString(8))+"','"+Common.getFormatStr(rs.getString(9))+"','"+Common.getFormatStr(rs.getString(10))+"','"+Common.getFormatStr(rs.getString(11))+"','"+Common.getFormatStr(rs.getString(12))+"','"+Common.getFormatStr(rs.getString(13))+"','"+Common.getFormatStr(rs.getString(14))+"','"+Common.getFormatStr(rs.getString(15)).replace("\r\n","<br>")+"','"+temp_img+"','"+Common.getFormatStr(rs.getString(17))+"','"+Common.getFormatStr(rs.getString(18))+"','"+Common.getFormatStr(rs.getString(19))+"','"+Common.getFormatStr(rs.getString(20))+"','700701')";
dataManager1.dataOperation(conn1, sql);
sql="";
}

pool1.freeConnection(conn1);
pool2.freeConnection(conn2);
out.println("导入成功!");
%>