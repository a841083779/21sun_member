<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="../manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}

String[] roles = request.getParameterValues("sel");

String roleNum = Common.getFormatStr(request.getParameter("roleNum"));

Connection conn =null;
PreparedStatement pstmt = null;	

int opt = 1;

try{
		conn = pool.getConnection();
		
		String delSql = "delete from member_role_purview_new where role_num=?";
		pstmt = conn.prepareStatement(delSql);
		pstmt.setString(1, roleNum);
		pstmt.executeUpdate();
		pstmt = null;
		
	for (int i = 0; roles != null && i < roles.length; i++) {
		if (roles[i].equals("0")) continue;
		//组装INSERT语句
		String insSql = "insert into member_role_purview_new(role_num,purview_num) values(?,?)";
		pstmt = conn.prepareStatement(insSql);
		pstmt.setString(1, roleNum);
		pstmt.setString(2, roles[i]);

		pstmt.executeUpdate();
		pstmt = null;
	}		
			
}catch(Exception e){
	e.printStackTrace();
	opt = -1;
}
finally{
	pool.freeConnection(conn);
	
}
	
%>
<script>
function alertStr(){
	var isok = "<%=opt%>";
	if(isok==1){
		alert("设置成功！");
		window.close();
	}else{
		alert("设置失败！");
		history.back();
	}
}
alertStr();
</script>