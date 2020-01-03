<%@page contentType="text/html;charset=utf-8"import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="../manage/config.jsp"%>
	<% 
//===调租赁库====
PoolManager pool1 = new PoolManager(10);

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
String id=Common.getFormatStr(request.getParameter("myvalue"));
String golds=Common.getFormatStr(request.getParameter("golds"));
String rid=Common.getFormatStr(request.getParameter("rid"));
//=====生成静态页的相关控制===
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
Connection conn = null;
int result = 0;
//RentToHtml rentToHtml=new RentToHtml();
try{
	int num1 = 0;
	int num2 = 0;
	int num3 = 0;
	conn = pool1.getConnection();
	ResultSet ans = DataManager.executeQuery(conn,"select * from zhidao_ans where id = " + id);
	ans.next();
	conn.setTransactionIsolation(conn.TRANSACTION_NONE);
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();
	num1 = stmt.executeUpdate("insert into zhidao_renwu_golds (uid,rid,golds,aid) values ('"+ans.getString("mem_no")+"',"+rid+","+golds+","+ans.getString("id")+")");
	num2 = stmt.executeUpdate("update zhidao_exp set golds = golds + "+golds+" where mem_no = '"+ans.getString("mem_no")+"'");
	if(num2==0){
		num3 = stmt.executeUpdate("insert into zhidao_exp (add_user,add_ip,add_date,mem_no,mem_name,point,golds,zhuanjia,add_golds,min_golds) values "
				+"('admin','',getDate(),'"+ans.getString("mem_no")+"','"+ans.getString("mem_name")+"',0,"+golds+",0,0,0)");
	}
	conn.commit();
	 //=====更新首页相关静态页====
  // rentToHtml.indexAllHtml(request,pool1,zd_catalog_no);
    if(num1>0&&(num2>0||num3>0)){
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
	conn.rollback();
	e.printStackTrace();
}finally{
	urlpath=null;
	mypy=null;
	zd_catalog_no=null;
	pool1.freeConnection(conn);
	//rentToHtml=null;
}	
%>