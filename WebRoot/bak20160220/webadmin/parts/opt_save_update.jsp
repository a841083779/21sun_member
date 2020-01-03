<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*"
	%><%@ include file ="../manage/config.jsp"%>
	<% 
PoolManager pool7 = new PoolManager(7);
//isReload:1:表示增加,2 表示修改
String isReload=Common.getFormatStr(request.getParameter("isReload"));
String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));

try{
	int result =DataManager.dataInsUpt(request, pool7, mypy,2,0);

if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
	//window.document.location.reload();
	opener.document.location.reload();
	window.close();
	//window.document.location.href='<%=urlpath%>';
	}catch(e){}	
	
	</script>
	<%
	}else{
	%>
	<script>
		alert("操作失败！");
		history.back();
	</script>
<%
	}	
}catch(Exception e){
	e.printStackTrace();
}finally{
isReload=null;
urlpath=null;
mypy=null;
}	
%>