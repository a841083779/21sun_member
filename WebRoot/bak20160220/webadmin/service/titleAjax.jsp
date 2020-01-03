<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="../manage/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}
Connection conn = pool.getConnection();
ResultSet rs = null;

String titleString=Common.getFormatStr(request.getParameter("title"));
//System.out.println(titleString);
if(titleString!=null && titleString.length()>0){
	rs = DataManager.getOneData(conn, "service_webcase", "title",titleString);
	if (rs.next()) {
		out.print("exit");
	}else{
		out.print("ok");
	}
}else{
	out.print("fail");
}
%>
