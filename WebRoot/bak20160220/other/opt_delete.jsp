<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="/manage/config.jsp"%><% 
	PoolManager pool1 = new PoolManager(1);	
	PoolManager pool4 = new PoolManager(4);
	String myvalue =request.getParameter("myvalue");
	myvalue=Common.decryptionByDES(myvalue);
	String mypy =request.getParameter("mypy");
	int result =DataManager.deleteData(pool4,request,mypy,myvalue,2,0);
	if(result>0){
		out.print("1");
	}else{
		out.print("0");
	}
%>