<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.cmbol.database.PoolManager"%>
<%@page import="java.util.Map"%>
<%@page import="weibo4j.Sina"%>
<%@page import="com.jerehnet.cmbol.database.DataManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.Common"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="weibo4j.QQ"%>
<%@page import="weibo4j.qq.model.User"%>
<%@page import="com.qq.connect.oauth.Oauth"%>
<%@page import="com.qq.connect.javabeans.qzone.UserInfoBean"%>
<%@page import="com.qq.connect.api.qzone.UserInfo"%>
<%@page import="com.qq.connect.api.OpenID"%>
<%@page import="com.qq.connect.javabeans.AccessToken"%>
 <%
 	Oauth oauth = new Oauth() ;
 	AccessToken accessToken = new AccessToken() ;
 	accessToken = oauth.getAccessTokenByRequest(request) ;
 	OpenID openID = new OpenID(accessToken.getAccessToken().toString()) ;
    UserInfo qqUserInfo = new  UserInfo(accessToken.getAccessToken().toString(),openID.getUserOpenID().toString()) ;
    UserInfoBean user = qqUserInfo.getUserInfo() ; // qq用户信息
    String qqopenId = openID.getUserOpenID().toString() ; // qq 开放id
	PoolManager pool = PoolManager.getInstance();
	DataManager dataManager = new DataManager();
	Connection conn = null;
	ResultSetMetaData rsmd = null;
	ResultSet rs = null;
	Map userInfo = new HashMap(); // 商贸网用户信息
    try {
		conn = pool.getConnection();
		if (user != null) {
			session.setAttribute("qqUserInfoSESSION", user);
			session.setAttribute("qqOpenId",qqopenId) ;
			session.setAttribute("figureurl50",user.getAvatar().getAvatarURL50().toString()) ;
			String sel_sql = " select * from vi_member_info where qq_id=";
			rs = dataManager.getOneData(conn, "member_info", "qq_id", qqopenId);
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
				  	  opener.location.href='/openplatform/member_reg.jsp?flag=qq' ;
				</script>
					 <%
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(conn);
	}
%>
