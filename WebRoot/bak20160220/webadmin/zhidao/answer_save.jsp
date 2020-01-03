<%@page contentType="text/html;charset=utf-8"import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="../manage/config.jsp"%>
	<% 
//===调租赁库====
PoolManager pool1 = new PoolManager(10);

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
String id=Common.getFormatStr(request.getParameter("myvalue"));
String ip=Common.getFormatStr(request.getParameter("zd_add_ip"));
String date=Common.getFormatStr(request.getParameter("zd_add_date"));
String context=Common.getFormatStr(request.getParameter("zd_context"));
String parent=Common.getFormatStr(request.getParameter("zd_parent"));
//=====生成静态页的相关控制===
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
String sql;
if(id==null||id.equals("")||id.equals("0")){
	sql="insert into (add_user,add_ip,add_date,parent,context,mem_no,mem_name,likes,ticks,best,remark,tic) "
		+"values ('admin','"+ip+"',getDate(),"+parent+",'"+context+"','admin','',0,0,0,'c',0)";
}else{
	sql="update zhidao_ans set context = '"+context+"' where id = "+id;
}
int result = 0;
//RentToHtml rentToHtml=new RentToHtml();
try{
   result =DataManager.dataOperation(pool1.getConnection(),sql);
	 //=====更新首页相关静态页====
  // rentToHtml.indexAllHtml(request,pool1,zd_catalog_no);
    if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
	//window.document.location.reload();
	window.document.location.href='<%=urlpath%>';
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
	//rentToHtml=null;
}	
%>