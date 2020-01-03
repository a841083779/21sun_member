<%@page contentType="text/html;charset=utf-8"import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="../manage/config.jsp"%>
	<% 
//===调租赁库====
PoolManager pool1 = new PoolManager(10);

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
String id=Common.getFormatStr(request.getParameter("id"));
String rid=Common.getFormatStr(request.getParameter("rid"));
String title=Common.decryptionByDES(request.getParameter("title"));
//=====生成静态页的相关控制===
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));

Connection conn = null;
int result = 0;
//RentToHtml rentToHtml=new RentToHtml();
try{
	String sql;
	String tname = "";
	conn = pool1.getConnection();
	sql = "update zhidao_post set renwu = "+rid+" where id = " + id;

   result =DataManager.dataOperation(conn,sql);
	 //=====更新首页相关静态页====
  // rentToHtml.indexAllHtml(request,pool1,zd_catalog_no);
    if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
	//window.document.location.reload();
	window.document.location.href='other_list.jsp?rid=<%=rid%>&title=<%=Common.encryptionByDES(title)%>';
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
	zd_catalog_no=null;
	pool1.freeConnection(conn);
	//rentToHtml=null;
}	
%>