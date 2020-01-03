<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,java.io.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%
	PoolManager pool = (PoolManager)application.getAttribute("poolApp");
	if(pool == null){
		pool = new PoolManager();
		application.setAttribute("poolApp",pool);
	}
	Connection conn = null;
	try{
		conn = pool.getConnection();
		
		//获得用户名、密码
		String memNo = Common.decryptionByDES(Common.getFormatStr(request.getParameter("id")));
		String passw = Common.decryptionByDES(Common.getFormatStr(request.getParameter("code")));
		String passwMD5 = DesEncrypt.MD5(passw);
		//查询出membr_info_ago表中是否存在该帐号
		String sql = " select id from member_info where mem_no = '"+memNo+"' and passw = '"+passwMD5+"' and state='0' ";
		//System.out.println(sql);
		ResultSet rs = DataManager.executeQuery(conn, sql);
		int i = 0;
		int d = 0;
		if(rs != null && rs.next()){//若存在该帐号插入到member_info表中
			String insertMemSql = " update member_info set state='1' where mem_no = '"+memNo+"' and passw = '"+passwMD5+"' ";
			i = DataManager.dataOperation(conn, insertMemSql);
			
			if(i > 0){
				%>
					<script>
						alert("您的帐号激活成功，请登录。");
						window.location.href = "/";	
					</script>
				<%
			}
		}else{//若不存在，提示信息
			%>
			<script>
				alert("激活帐号信息有误，请与管理员联系，联系电话：0535-6792736。");
				window.location.href = "/";	
			</script>
			<%
		}
		
	}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
%>