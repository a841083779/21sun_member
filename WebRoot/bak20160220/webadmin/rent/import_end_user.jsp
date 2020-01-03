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
				
ResultSet rs=DataManager.executeQueryDB2(conn2, "select   ID,CORPORATION,PROVINCE,CITY,CREATEYEAR,CREATEMONTH,CREATEDAY,CATIDS,ADDRESS,POSTCODE,fullname,OCCUPATION,TELEPHONE,FAX ,EMAIL,WWW,ISPUBLISHED,CLICKED,INFORMATION,cast(DETAIL as varchar(4000)),BRAND,EXISTEQUIPMENT,BUYEQUIPMENT,BUYBUDGET,cast(ACHIEVEMENT as varchar(4000)) from ENDUSER where 1=1 ");
// fetch first 2000 rows only
String catalog_no="";String temp_img="";String sql="";
int k=0;
while(rs.next()){
k=k+1;
	sql="insert into enduser(id,corporation,province,city,createyear,createmonth,createday,catids,address,postcode,mem_name,occupation,telephone,fax ,email,www,ispublished,clicked,information,detail,brand,existequipment,buyequipment,buybudget,achievement)values('"+Common.getFormatInt(rs.getString(1))+"','"+Common.getFormatStr(rs.getString(2))+"','"+Common.getFormatStr(rs.getString(3))+"','"+Common.getFormatStr(rs.getString(4))+"','"+Common.getFormatStr(rs.getString(5))+"','"+Common.getFormatStr(rs.getString(6))+"','"+Common.getFormatStr(rs.getString(7))+"','"+Common.getFormatStr(rs.getString(8))+"','"+Common.getFormatStr(rs.getString(9))+"','"+Common.getFormatStr(rs.getString(10))+"','"+Common.getFormatStr(rs.getString(11))+"','"+Common.getFormatStr(rs.getString(12))+"','"+Common.getFormatStr(rs.getString(13))+"','"+Common.getFormatStr(rs.getString(14))+"','"+Common.getFormatStr(rs.getString(15))+"','"+Common.getFormatStr(rs.getString(16))+"','"+Common.getFormatInt(rs.getString(17))+"','"+Common.getFormatInt(rs.getString(18))+"','"+Common.getFormatStr(rs.getString(19))+"','"+Common.getFormatStr(rs.getString(20))+"','"+Common.getFormatStr(rs.getString(21))+"','"+Common.getFormatStr(rs.getString(22))+"','"+Common.getFormatStr(rs.getString(23))+"','"+Common.getFormatStr(rs.getString(24))+"','"+Common.getFormatStr(rs.getString(25))+"')";
	dataManager1.dataOperation(conn1, sql);
	sql="";
//out.println("id="+Common.getFormatInt(rs.getString(1)));
}

pool1.freeConnection(conn1);
pool2.freeConnection(conn2);
out.println("导入成功!"+k);
%>