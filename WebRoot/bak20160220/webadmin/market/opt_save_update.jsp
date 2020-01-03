<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*"
	%><%@ include file ="../manage/config.jsp"%>
	<% 
	pool = new PoolManager(5);
//isReload:1:表示增加,2 表示修改
String isReload=Common.getFormatStr(request.getParameter("isReload"));
String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
//=====生成静态页的相关控制===
String flag=Common.getFormatInt(request.getParameter("flag"));
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));
String tempInfo[][]=null;
try{
	int result =DataManager.dataInsUpt(request, pool, mypy,2,0);
	//如果是新增，获得新增后最大id	
	if(myvalue.equals("")&&(flag.equals("4"))){
	tempInfo=DataManager.fetchFieldValue(pool,Common.decryptionByDES(mypy),"max(id)", " catalog_no='" + zd_catalog_no + "'");
  if(tempInfo!=null&&tempInfo[0][0]!=null)
    {
		myvalue=Common.getFormatInt(tempInfo[0][0]);
	}
}else if(!myvalue.equals("")&&(flag.equals("4"))){
   myvalue=Common.decryptionByDES(myvalue);
}

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
flag=null;
zd_catalog_no=null;
myvalue=null;
tempInfo=null;
}	
%>