<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@ include file ="/include/config.jsp"%>
<%
	String key = Common.getFormatStr(request.getParameter("key"));
	String email = Common.getFormatStr(request.getParameter("email"));
	String pwd = Common.getFormatStr(request.getParameter("passw"));
	pwd = DesEncrypt.MD5(pwd);
	String code = Common.getFormatStr(request.getParameter("code"));
	String codeCookie = Common.getFormatStr(Common.getCookies(request, "code"));
	if(code.equals("") || !code.equals(codeCookie)){
		%>
        	<script>
				alert("该链接已经失效，请重新获取修复密码邮件");
				window.location.href = "/member_pass_find.jsp";
			</script>
        <%	
	}
	if(pool==null){
		pool = new PoolManager();
	}
	Connection conn =null;
	PreparedStatement pstmt = null;	
	ResultSet rs = null;
	String sql = " update member_info set passw = ? where mem_no = ? and per_email = ? ";
	try{
		conn = pool.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pwd);
		pstmt.setString(2, key);
		pstmt.setString(3, email);
		int flag = pstmt.executeUpdate();
		%>
        	<script>
				alert("密码重置成功，请登录");
				window.location.href = "/";
			</script>
        <%
	}catch(Exception e){e.printStackTrace();}
	finally{
		pool.freeConnection(conn);
	}
%>
