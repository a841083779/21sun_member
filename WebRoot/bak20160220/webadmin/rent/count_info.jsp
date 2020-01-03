<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库,3:表示调用的租赁数据库
	PoolManager pool1 = new PoolManager(3);
	DataManager dataManager1=new DataManager();
	Connection conn1=pool1.getConnection();
	
	PoolManager pool2 = new PoolManager(2);
  Connection conn2=pool2.getConnection();
	
//String columnsInfo[][] =DataManager.fetchFieldValueDB2(pool2, "TECHARTICLE","TITLE,PUBDATE,ISPUBLISHED,DETAIL,HTMFILE,CATEIDS,MODEIDS,CLICKED,AUTHOR", " 1=1 and ISPUBLISHED=1 order by PUBDATE desc ",2905);
String flag=Common.getFormatInt(request.getParameter("flag"));

String tablename="WEBRENT";

String strname="";

if(flag.equals("1"))
{tablename="WEBRENT";
strname="租赁";
}
else if(flag.equals("2"))
{tablename="USEDMARKET";
strname="二手";
}
else if(flag.equals("3"))
{tablename="PART_MARKET";
strname="配件";
}
else if(flag.equals("4"))
{tablename="WEBMARKET"; 
strname="供求";
}


ResultSet rs=DataManager.executeQueryDB2(conn2, "select count(*) from  "+tablename+" where 1=1 and ISPUBLISHED=1 ");
ResultSet rs1=DataManager.executeQueryDB2(conn2, "select count(*) from  "+tablename+" where 1=1 and ISPUBLISHED=1 and PUBDATE='2010-08-16' ");


if(rs.next())
{out.print(strname+"==总共数量:==="+Common.getFormatStr(rs.getString(1)));
}
if(rs1.next())
{out.print("====每天发布量:===="+Common.getFormatStr(rs1.getString(1)));
}

pool1.freeConnection(conn1);
pool2.freeConnection(conn2);
//out.println("导入成功!");
%>