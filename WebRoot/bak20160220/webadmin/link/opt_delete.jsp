<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"
	%>
<% 

String tablename = Common.getFormatStr(request.getParameter("tablename"));
String id = Common.getFormatStr(request.getParameter("id"));
int result = DataManager.deleteData(request,tablename,id,0,0);

if(result>0){
	out.print("1");	
}else{
	out.print("0");
}
%>