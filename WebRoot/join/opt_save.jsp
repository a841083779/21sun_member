<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="../manage/config.jsp"%>
	<% 
//===调租赁库====
PoolManager pool1 = new PoolManager(1);
Connection conn = pool1.getConnection();
String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("tablename"));
String flag=Common.getFormatStr(request.getParameter("flag"));
String id=Common.getFormatStr(request.getParameter("zd_id"));
//=====生成静态页的相关控制===
int result = 0;
try{
if(Common.getFormatInt(request.getParameter("rand")).equals( Common.getFormatInt((String)session.getAttribute("loginRand")) )){
   result =DataManager.dataInsUpt(request,  pool1,mypy,  2,0);
   }else{
   	result=-2;
   }
	if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
	//window.document.location.reload();
	<%if(!"0".equals(id)){%>
	window.document.location.href='<%=urlpath%>?id='+<%=id%>;
	<%}else{%>
	window.document.location.href='<%=urlpath%>';
	<%}%>
	}catch(e){}	
	
	</script>
	<%}else if(	result==-2){
		%>
	<script>
		alert("验证码输入不正确，请重新输入！");
		history.back();
	</script>
<%
	}else{%>
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
	conn.close();
}	
%>