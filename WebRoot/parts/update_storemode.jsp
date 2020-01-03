<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" errorPage=""%><%
PoolManager pool1= new PoolManager(1);
String mem_no="",urlpath="",parts_storemodel="";
parts_storemodel = Common.getFormatInt(Common.decryptionByDES(request.getParameter("parts_storemodel")));
String description="",sql="";
try{
	mem_no=Common.decryptionByDES(Common.getFormatStr(request.getParameter("mem_no")));
	urlpath = Common.getFormatStr(request.getParameter("urlpath"));
	urlpath="store_mode.jsp";

	sql="update member_info set parts_storemodel='"+parts_storemodel+"' where mem_no='"+mem_no+"'";
	DataManager.dataOperation(pool1,sql);
	description="\u66f4\u65b0\u5e97\u94fa\u6a21\u7248\u6210\u529f!";
	
%>
	<script>
		alert('<%=description%>');
	try{
	  window.document.location.href='<%=urlpath%>';
	}catch(e){}	
	</script>
<%
}catch(Exception ex)
{;}
finally{
description=null;
sql=null;
}
%>