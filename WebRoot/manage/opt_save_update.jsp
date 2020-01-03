<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*"
	%><%@ include file ="/manage/config.jsp"%>
	<% 
if(pool==null){
	pool = new PoolManager();
}

//isReload:1:表示增加,2 表示修改
String isReload=Common.getFormatStr(request.getParameter("isReload"));
String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
//=====生成静态页的相关控制===
String flag=Common.getFormatInt(request.getParameter("flag"));
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));
String tempInfo[][]=null;

String randflag=Common.getFormatInt(request.getParameter("randflag"));
int result = 0;

try{
	if(randflag.equals("1")){
		if(Common.getFormatInt(request.getParameter("rand")).equals( Common.getFormatInt((String)session.getAttribute("loginRand")) )){
			result =DataManager.dataInsUpt(request, pool, mypy,1,5);
		}else{
			result = -1;
		}
	}else{
		result =DataManager.dataInsUpt(request, pool, mypy,1,5);
	}

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
	flag=null;
	zd_catalog_no=null;
	myvalue=null;
	tempInfo=null;
}	
%>