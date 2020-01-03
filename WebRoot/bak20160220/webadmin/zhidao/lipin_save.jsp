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
String name=Common.getFormatStr(request.getParameter("zd_name"));
String num=Common.getFormatStr(request.getParameter("zd_num"));
String price=Common.getFormatStr(request.getParameter("zd_price"));
String state=Common.getFormatStr(request.getParameter("zd_state"));
String golds=Common.getFormatStr(request.getParameter("zd_golds"));
//=====生成静态页的相关控制===
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
String sql;
if(id==null||id.equals("")||id.equals("0")){
	sql="insert into zhidao_lipin (add_user,add_ip,add_date,image,num,price,show,name,golds) "
		+"values ('admin','',getDate(),'c',"+num+","+price+","+state+",'"+name+"',"+golds+")";
}else{
	sql="update zhidao_lipin set image = 'c',num = "+num+",price = "+price+",show = "+state+",name='"+name+"',golds="+golds+" where id= " + myvalue;
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