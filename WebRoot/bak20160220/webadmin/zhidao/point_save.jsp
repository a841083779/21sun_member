<%@page contentType="text/html;charset=utf-8"import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="../manage/config.jsp"%>
	<% 
//===调租赁库====
PoolManager pool1 = new PoolManager(1);

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
String id=Common.getFormatStr(request.getParameter("myvalue"));
String ip=Common.getFormatStr(request.getParameter("zd_add_ip"));
String date=Common.getFormatStr(request.getParameter("add_date"));
String num=Common.getFormatStr(request.getParameter("zd_num"));
String type=Common.getFormatStr(request.getParameter("zd_type"));
//=====生成静态页的相关控制===
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
String sql;
if(id==null||id.equals("")||id.equals("0")){
	sql="insert into zhidao_integral (add_user,add_ip,add_date,num,type,point_user,men_no) values "
	+"('admin','"+ip+"',convert(datetime,'"+date+"'),"+num+","+type+",0,'admin')";
}else{
	sql="update zhidao_integral set add_user='admin',add_ip='"+ip+"',add_date=convert(datetime,'"+date+"'),num="+num+",type="+type+",point_user=0,men_no='admin' where id="+id;
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