<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,jereh.web21sun.database.*,jereh.web21sun.util.*,jereh.web21sun.action.*" %>
<% 

PoolManager pool = (PoolManager)application.getAttribute("poolAPP");
if(pool==null){
	pool = new PoolManager();
}
String id=Common.getFormatStr(request.getParameter("n"));

Connection conn =null;
try{
	conn = pool.getConnection();
	if(id!=null && !id.equals("")){
		String uptSQL="update fangtan_detail set view_count=ISNULL(view_count, 0)+1 where id="+id;
		DataManager.dataOperation(conn,uptSQL);
	}
}catch(Exception e){
	Common.println(e);
}
finally{
	pool.freeConnection(conn);
}
%>
