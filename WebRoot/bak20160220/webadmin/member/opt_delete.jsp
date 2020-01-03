<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"
	%><%@ include file ="../manage/config.jsp"%><% 

	pool = new PoolManager(1);
System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//=================
String myvalue =request.getParameter("myvalue");
myvalue=Common.decryptionByDES(myvalue);

String mypy =request.getParameter("mypy");

// ====保存日志====
//Common.saveLogs(pool, request, mypy, myvalue,"3",1,5);
//================================
int result =DataManager.deleteData(pool,request,mypy,myvalue,2,7);
if(result>0){
	out.print("1");

}else{
	out.print("0");
}
%>