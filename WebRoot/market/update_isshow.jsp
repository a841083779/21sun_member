<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" errorPage=""%><%
PoolManager pool5= new PoolManager(5);
String tablename="";
String id="";
String sql="";
String urlpath="";
String description ="";

try{
   
	tablename=Common.decryptionByDES(Common.getFormatStr(request.getParameter("mypy")));
	id=Common.decryptionByDES(Common.getFormatStr(request.getParameter("myvalue")));
	urlpath = Common.getFormatStr(request.getParameter("urlpath"));

	sql="update "+tablename+" set is_show = '0' where id='"+id+"'";
	 DataManager.dataOperation(pool5,sql);
 
}catch(Exception ex)
{;}
finally{
tablename=null;
id=null;
sql=null;
}
%>