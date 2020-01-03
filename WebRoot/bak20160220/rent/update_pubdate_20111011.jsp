<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" errorPage=""%><%
PoolManager pool3= new PoolManager(3);
String tablename="";
String id="";
String sql="";
String urlpath="";
String mem_flag="";
String type="";
String description ="";
try{tablename=Common.decryptionByDES(Common.getFormatStr(request.getParameter("mypy")));
	id=Common.decryptionByDES(Common.getFormatStr(request.getParameter("myvalue")));
	urlpath = Common.getFormatStr(request.getParameter("urlpath"));
	mem_flag= Common.getFormatStr(request.getParameter("mem_flag"));
	
	sql="update "+tablename+" set pubdate='"+Common.getToday("yyyy-MM-dd HH:mm:ss.SSS",0)+"',orderno='"+Common.create21SUNOrderNo(1,mem_flag,0)+Common.generateDateRandom()+"',orderno1='"+Common.create21SUNOrderNo(1,mem_flag,1)+"' where id='"+id+"'";
	 DataManager.dataOperation(pool3,sql);
	 description="成功更新信息！";
	
%>
	<script>
		alert('<%=description%>');
	try{
	  window.document.location.href='<%=urlpath%>';
	}catch(e){}	
	</script>
<%
 
}catch(Exception ex)
{;}
finally{
tablename=null;
id=null;
sql=null;
}
%>