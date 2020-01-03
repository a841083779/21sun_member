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
String title=Common.getFormatStr(request.getParameter("zd_title"));
String context=Common.getFormatStr(request.getParameter("zd_context"));
String golds=Common.getFormatStr(request.getParameter("zd_golds"));
String type=Common.getFormatStr(request.getParameter("zd_type"));
//=====生成静态页的相关控制===
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));

if(golds==null||golds==""){
	golds="0";
}
Connection conn = null;
int result = 0;
//RentToHtml rentToHtml=new RentToHtml();
try{
	String sql;
	String tname = "";
	conn = pool1.getConnection();
	String sql_ty = "select * from zhidao_type where nodeid='"+type+"'";
	ResultSet ty = DataManager.executeQuery(conn,sql_ty);
	if(ty!=null&&ty.next()){
		tname = Common.getFormatStr("name");
	}
	if(id==null||id.equals("")||id.equals("0")){
		sql="insert into zhidao_post (add_user,add_ip,add_date,title,context,type,state,remark,mem_no,mem_name,type_name,ansnum,golds,looks) "
						+"values ('admin','',getDate(),'"+title+"','"+context+"','"+type+"','零回答','','admin','','"+tname+"',0,"+golds+",0)";
	}else{
		sql="update zhidao_post set title = '"+title+"',context = '"+context+"',type = '"+type+"',type_name='"+tname+"',golds="+golds+" where id = "+id;
	}

   result =DataManager.dataOperation(conn,sql);
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
	pool1.freeConnection(conn);
	//rentToHtml=null;
}	
%>