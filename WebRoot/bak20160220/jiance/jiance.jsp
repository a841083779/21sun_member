<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%>
<%
	//供求监测
	PoolManager pool = (PoolManager)application.getAttribute("poolAPP");
	if(pool==null){
		pool = new PoolManager();
	}
	Connection conn = null;
	try{
		conn = pool.getConnection();
		ResultSet rs = DataManager.executeQuery(conn," select top 1 id from parts_words where id=3 ");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>监测</title>
</head>

<body>
<table>
<%
	while(rs.next()){
%>
	<tr><td><%=Common.getFormatStr(rs.getString("id"))%></td></tr>
<%			
	}
%>
</table>
</body>
</html>
<%
}catch(Exception e){
Common.println(e);
}
finally{
	pool.freeConnection(conn);
}
%>