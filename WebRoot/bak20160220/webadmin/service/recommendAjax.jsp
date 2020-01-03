<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="../manage/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}

String id=Common.getFormatInt(request.getParameter("id"));
String rec = Common.getFormatInt(request.getParameter("rec"));
//System.out.println(id);
//System.out.println(rec);
if(id!=null && rec!=null && rec.length()>0){
	if(rec.equals("0")){
		rec = null;
	}
	String sql = "update service_webcase set recommend="+rec+" where id="+id;
//	System.out.println(sql);
	int result = DataManager.executeSQL(pool,sql);
	if (result>0) {
		out.print("ok");
	}else{
		out.print("no");
	}
}else{
	out.print("fail");
}
%>
