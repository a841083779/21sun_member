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
				
ResultSet rs=DataManager.executeQueryDB2(conn2, "select TITLE,simg,cid,id FROM photo where id>215 order by id");

String catalog_no="";
String tempImg="";
String sql="";
int k=0;

try{
while(rs.next())
{k=k+1;
tempImg="/aboutus/photo2007/img/"+Common.getFormatStr(rs.getString(2));
catalog_no=Common.getFormatStr(rs.getString(3));
if(catalog_no.equals("8"))
{catalog_no="1";
}
else if(catalog_no.equals("5"))
{catalog_no="2";
}
else if(catalog_no.equals("4"))
{catalog_no="3";
}
else if(catalog_no.equals("7"))
{catalog_no="4";
}
else if(catalog_no.equals("9"))
{catalog_no="5";
}
else if(catalog_no.equals("12"))
{catalog_no="6";
}
else if(catalog_no.equals("10"))
{catalog_no="7";
}
else if(catalog_no.equals("11"))
{catalog_no="8";
}
else if(catalog_no.equals("14"))
{catalog_no="9";
}
else if(catalog_no.equals("15"))
{catalog_no="10";
}
else if(catalog_no.equals("16"))
{catalog_no="11";
}
sql="insert into aboutus_pic(title,img,sub_catalog_no,db2id,catalog_no,is_pub,pub_date)values('"+Common.getFormatStr(rs.getString(1))+"','"+tempImg+"','"+catalog_no+"',"+Common.getFormatStr(rs.getString(4))+",'701101',1,getdate())";
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