<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="../manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
PreparedStatement pstmt = null;	
int uptCount = 0;

HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");

//组装INSERT语句
String uptSql = "update member_info set passw=? where id=?";

String passw = Common.getFormatStr(request.getParameter("passw"));
passw = DesEncrypt.MD5(passw);
try{
	conn = pool.getConnection();
	pstmt = conn.prepareStatement(uptSql);
	pstmt.setString(2, (String)memberInfo.get("id"));
	pstmt.setString(1, passw);
	
	uptCount = pstmt.executeUpdate();

}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script>
function uptPasswOK(){
	alert("密码修改成功");
	window.location.href="/other/user_passw_opt.jsp";
}
uptPasswOK();
</script>
</head>
<body>
<%//=uptCount%>
</body>
</html>