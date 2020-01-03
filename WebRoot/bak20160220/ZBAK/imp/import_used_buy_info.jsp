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
//====查找db2中最大的id===
/*String tempdbId[][]=DataManager.fetchFieldValue(pool1,"buy", "max(convert(bigint,db2id))", "");
String db2Id="99999999";
if(tempdbId!=null)
db2Id=Common.getFormatStr(tempdbId[0][0]);
*/				
ResultSet rs=DataManager.executeQueryDB2(conn2, "select MID,PUBDATE,EXTRADATE,ISPUBLISHED,CLICKED,TITLE,MODEL,BRAND,CATEGORY,SUBCATEGORY,PROVINCE,CITY,PLACE,PRICE,AMOUNT ,cast(DETAIL as varchar(4000)) as DETAIL,IMG1,IMG2,infoCLASS,id from USEDMARKET where INFOCLASS=0  order by id");
//==and ISPUBLISHED=1 
String catalog_no="";
String sql="";
String temp_img="";
int k=0;
try{
while(rs!=null &&rs.next())
{k=k+1;
if(!Common.getFormatStr(rs.getString(17)).equals(""))
{temp_img="/images/"+Common.getFormatStr(rs.getString(17));}
else
{temp_img="";}
//temp_img=temp_img.toLowerCase();

sql="insert into buy_test(mem_no,PUBDATE,extradate,is_pub,CLICKED,TITLE,CATEGORY,SUBCATEGORY,PROVINCE,CITY,content,db2id)values('"+Common.getFormatStr(rs.getString("MID"))+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate("PUBDATE"))+"','"+Common.getFormatDate("yyyy-MM-dd",rs.getDate("EXTRADATE"))+"','"+Common.getFormatStr(rs.getString("ISPUBLISHED"))+"','"+Common.getFormatStr(rs.getString("CLICKED"))+"','"+Common.getFormatStr(rs.getString("TITLE"))+"','"+Common.getFormatStr(rs.getString("CATEGORY"))+"','"+Common.getFormatStr(rs.getString("SUBCATEGORY"))+"','"+Common.getFormatStr(rs.getString("PROVINCE"))+"','"+Common.getFormatStr(rs.getString("CITY"))+"','"+Common.getFormatStr(rs.getString("DETAIL")).replace("\r\n","<br>")+"','"+Common.getFormatStr(rs.getString("id"))+"')";

dataManager1.dataOperation(conn1, sql);
sql="";
 }
}
catch(Exception e)
{;}
finally{
pool1.freeConnection(conn1);
pool2.freeConnection(conn2);}

out.println("k:===="+k+"====导入成功!");
%>