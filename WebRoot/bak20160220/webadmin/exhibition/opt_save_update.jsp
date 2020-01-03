<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"%>
<jsp:useBean id="pool" scope="application" class="com.jerehnet.cmbol.database.PoolManager"/>
<% 
if(pool==null){
	pool = new PoolManager();
}
//isReload:1:表示增加,2 表示修改
String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
//=====生成静态页的相关控制===
try{
	int result =DataManager.dataInsUpt(request, pool, mypy,0,0);

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
urlpath=null;
mypy=null;
}	
%>

