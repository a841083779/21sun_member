<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="../manage/config.jsp"%><% 
if(pool==null){
	pool = new PoolManager();
}
//=================
String myvalue =request.getParameter("myvalue");
myvalue=Common.decryptionByDES(myvalue);

String mypy =request.getParameter("mypy");
System.out.println("myvalue="+myvalue);
System.out.println("mypy="+mypy);
int result =DataManager.deleteData(pool,request,mypy,myvalue,2,7);

//=====
if(result>0){
	out.print("1");

}else{
	out.print("0");
}
%>