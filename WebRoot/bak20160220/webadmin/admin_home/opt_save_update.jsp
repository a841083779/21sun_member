<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="/manage/config.jsp"%>
	<% 
if(pool==null){
	pool = new PoolManager();
}

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));

int result = 0;
try{
   result =DataManager.dataInsUpt(request, pool, mypy,2,0);
	
	if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
//opener.document.forms[0].submit();
	window.close();
	}catch(e){}	
	
	</script>
	<%}else{%>
	<script>
		alert("操作失败！");
		history.back();
	</script>
<%
	}	
}catch(Exception e){
	e.printStackTrace();
}finally{
	urlpath=null;
	mypy=null;
}	
%>