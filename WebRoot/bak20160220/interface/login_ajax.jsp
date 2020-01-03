<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%
response.setHeader("P3P","CP=CAO PSA OUR");
String mem_no = Common.getFormatStr(request.getParameter("mem_no"));
String mem_pwd = Common.getFormatStr(request.getParameter("mem_pwd"));
String url = Common.getFormatStr(request.getParameter("url"));
String mem_name = "";

PoolManager pool = new PoolManager();
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
String cls = "";
try{
	conn = pool.getConnection();
	String sql = "select * from member_info where mem_no = '"+mem_no+"' and passw = '"+mem_pwd+"' and state = 1";
	ResultSet rs = DataManager.executeQuery(conn,sql);
	if(rs!=null&&rs.next()){
		cls = "{\"add_ip\":\""+Common.getFormatStr(rs.getString("add_ip"))+"\","
				+"\"add_date\":\""+Common.getFormatStr(rs.getString("add_date"))+"\","
				+"\"mem_no\":\""+Common.getFormatStr(rs.getString("mem_no"))+"\","
				+"\"mem_name\":\""+Common.getFormatStr(rs.getString("mem_name"))+"\"}"
				+"\"passw\":\""+Common.getFormatStr(rs.getString("passw"))+"\","
				+"\"per_sex\":\""+Common.getFormatStr(rs.getString("per_sex"))+"\","
				+"\"per_phone\":\""+Common.getFormatStr(rs.getString("per_phone"))+"\","
				+"\"per_email\":\""+Common.getFormatStr(rs.getString("per_email"))+"\","
				+"\"per_province\":\""+Common.getFormatStr(rs.getString("per_province"))+"\","
				+"\"per_city\":\""+Common.getFormatStr(rs.getString("per_qq"))+"\","
				+"\"comp_name\":\""+Common.getFormatStr(rs.getString("comp_name"))+"\","
				+"\"comp_simple\":\""+Common.getFormatStr(rs.getString("comp_simple"))+"\","
				+"\"comp_address\":\""+Common.getFormatStr(rs.getString("comp_address"))+"\","
				+"\"comp_postcode\":\""+Common.getFormatStr(rs.getString("comp_postcode"))+"\","
				+"\"comp_fax\":\""+Common.getFormatStr(rs.getString("comp_fax"))+"\","
				+"\"comp_url\":\""+Common.getFormatStr(rs.getString("comp_url"))+"\"}";
		mem_name = Common.getFormatStr(rs.getString("mem_name"));
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
<input name="mem_no" value="<%=mem_no %>" type="hidden"/>
<input name="mem_name" value="<%=mem_name %>" type="hidden"/>
<input name="mem_pwd" value="<%=mem_pwd %>" type="hidden"/>
<input name="cls" value="<%=cls %>" type="hidden"/>
</form>
</body>
</html>
