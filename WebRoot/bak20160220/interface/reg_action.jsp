<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%
response.setHeader("P3P","CP=CAO PSA OUR");
String mem_no = Common.getFormatStr(request.getParameter("mem_no"));
String mem_name = Common.getFormatStr(request.getParameter("mem_name"));
String mem_pwd = Common.getFormatStr(request.getParameter("mem_pwd"));
String mem_email = Common.getFormatStr(request.getParameter("mem_email"));
String ip = Common.getFormatStr(request.getParameter("ip"));
String url = Common.getFormatStr(request.getParameter("url"));
String web = Common.getFormatStr(request.getParameter("web"));

PoolManager pool = new PoolManager();
if(pool==null){
	pool = new PoolManager();
}

Connection conn =null;
boolean isreg = false;
try{
	conn = pool.getConnection();
	String sql = "insert into member_info (add_ip,add_date,mem_no,mem_name,passw,comp_name,state) values "
			+"('"+ip+"',getDate(),'"+mem_no+"','"+mem_name+"','"+mem_pwd+"','"+web+"',1)";
	int num = DataManager.dataOperation(conn,sql);
	if(num>0){
		isreg = true;
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
	pool.freeConnection(conn);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<body onload="this.form1.submit();">
<form id="form1" action="<%=url %>" method="post">
<input name="reg" value="<%=isreg %>" type="hidden"/>
<input name="mem_no" value="<%=mem_no %>" type="hidden"/>
<input name="mem_name" value="<%=mem_name %>" type="hidden"/>
<input name="mem_pwd" value="<%=mem_pwd %>" type="hidden"/>
<input name="mem_email" value="<%=mem_email %>" type="hidden"/>
<input name="ip" value="<%=ip %>" type="hidden"/>
</form>
</body>
</html>
