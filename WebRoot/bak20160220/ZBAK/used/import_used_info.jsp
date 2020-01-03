<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库,3:表示调用的租赁数据库,4:表示调用二手的数据
	PoolManager pool1 = new PoolManager(4);
	DataManager dataManager1=new DataManager();
	Connection conn1=pool1.getConnection();
	
PoolManager pool2 = new PoolManager(2);
Connection conn2=pool2.getConnection();
	
//String columnsInfo[][] =DataManager.fetchFieldValueDB2(pool2, "TECHARTICLE","TITLE,PUBDATE,ISPUBLISHED,DETAIL,HTMFILE,CATEIDS,MODEIDS,CLICKED,AUTHOR", " 1=1 and ISPUBLISHED=1 order by PUBDATE desc ",2905);
				
ResultSet rs=DataManager.executeQueryDB2(conn2, "select MID,PUBDATE,EXTRADATE,ISPUBLISHED,CLICKED,TITLE,MODEL,BRAND,CATEGORY,SUBCATEGORY,PROVINCE,CITY,PLACE,PRICE,AMOUNT ,cast(DETAIL as varchar(4000)) as DETAIL,IMG1,IMG2,infoCLASS,id from USEDMARKET where 1=1 and ISPUBLISHED=1 order by id");

String catalog_no="";
String sql="";
String temp_img="";
int k=0;
while(rs.next())
{k=k+1;
if(!Common.getFormatStr(rs.getString(17)).equals(""))
temp_img="/images/"+Common.getFormatStr(rs.getString(17));
else
temp_img="";
temp_img=temp_img.toLowerCase();

sql="insert into used_info(add_user,PUBDATE,extradate,is_pub,CLICKED,TITLE,MODEL,BRAND,CATEGORY,SUBCATEGORY,place,PROVINCE,CITY,PRICE,AMOUNT ,content,img1,img2,CLASS,db2id,catalog_no)values('"+Common.getFormatStr(rs.getString("MID"))+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate("PUBDATE"))+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate("EXTRADATE"))+"','"+Common.getFormatStr(rs.getString("ISPUBLISHED"))+"','"+Common.getFormatStr(rs.getString("CLICKED"))+"','"+Common.getFormatStr(rs.getString("TITLE"))+"','"+Common.getFormatStr(rs.getString("MODEL"))+"','"+Common.getFormatStr(rs.getString("BRAND"))+"','"+Common.getFormatStr(rs.getString("CATEGORY"))+"','"+Common.getFormatStr(rs.getString("SUBCATEGORY"))+"','"+Common.getFormatStr(rs.getString("place"))+"','"+Common.getFormatStr(rs.getString("PROVINCE"))+"','"+Common.getFormatStr(rs.getString("CITY"))+"','"+Common.getFormatStr(rs.getString("PRICE"))+"','"+Common.getFormatStr(rs.getString("AMOUNT"))+"','"+Common.getFormatStr(rs.getString("DETAIL")).replace("\r\n","<br>")+"','"+Common.getFormatStr(rs.getString("img1"))+"','"+Common.getFormatStr(rs.getString("img2"))+"','"+Common.getFormatStr(rs.getString("infoCLASS"))+"','"+Common.getFormatStr(rs.getString("id"))+"','700901')";
dataManager1.dataOperation(conn1, sql);
sql="";
}

pool1.freeConnection(conn1);
pool2.freeConnection(conn2);
out.println("导入成功!");
%>