<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="weibo4j.model.User"%>
<%@page import="com.jerehnet.cmbol.database.PoolManager"%>
<%@page import="java.util.Map"%>
<%@page import="weibo4j.Sina"%>
<%@page import="com.jerehnet.cmbol.database.DataManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.Common"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>新浪微博登陆</title>
	</head>
	<body>
		<%
		    String code = Common.getFormatStr(request.getParameter("code"));
			PoolManager pool = PoolManager.getInstance();
			DataManager dataManager = new DataManager();
			Connection conn = null;
			ResultSetMetaData rsmd = null;
			ResultSet rs = null;
			Map userInfo = new HashMap();
			try {
				conn = pool.getConnection();
				User user = Sina.getUserInfo(request);
				// out.println(user) ;
				if (user != null) {
					session.setAttribute("sinaUserInfoSESSION", user);
					String sel_sql = " select * from vi_member_info where sina_id=";
					rs = dataManager.getOneData(conn, "vi_member_info", "sina_id", Common.getFormatStr(user.getId()));
					if (null != rs && rs.next()) {
						rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							 userInfo.put(Common.getFormatStr(rsmd.getColumnName(i)), Common.getFormatStr(rs.getString(rsmd.getColumnName(i))));
						}
					}
				}
				if (userInfo != null && userInfo.size() > 0) {
					session.setAttribute("memberInfo", userInfo);
					 %>
						<script type="text/javascript">
						setTimeout(function(){
						window.close() ;
						},10) ;
						  	  opener.location.href='/manage/memberhome.jsp' ;
						</script>
							 <%
				 //    response.sendRedirect("/manage/memberhome.jsp");
				} else {
					 %>
						<script type="text/javascript">
						setTimeout(function(){
						window.close() ;
						},10) ;
						  	  opener.location.href='/openplatform/member_reg.jsp?flag=sina' ;
						</script>
							 <%
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(conn);
			}
		%>
	</body>
</html>
