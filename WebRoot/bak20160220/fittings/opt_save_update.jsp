<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="../manage/config.jsp"%>
	<% 
PoolManager pool9 = new PoolManager(9);

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
String randflag=Common.getFormatInt(request.getParameter("randflag"));
//=====生成静态页的相关控制===
//String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
int result = 0;
//UsedToHtml usedToHtml=new UsedToHtml();
try{
	//if(Common.getFormatInt(request.getParameter("rand")).equals( Common.getFormatInt((String)session.getAttribute("loginRand")) )){
   		result =DataManager.dataInsUpt(request, pool9, mypy,1,0);
	//}else{
	//	result = -1;
	//}
 //=====更新首页相关静态页====
 //   usedToHtml.indexAllHtml(request,pool9,zd_catalog_no);	
	if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
	//window.document.location.reload();
	window.document.location.href='<%=urlpath%>';
	}catch(e){}	
	
	</script>
	<%
	}else if(result==-1){
	%>
	<script>
		alert("验证码输入不正确，请重新输入！");
		history.back();
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