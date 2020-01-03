<%@ page language="java" pageEncoding="utf-8"%><%@page import="com.qq.connect.javabeans.qzone.UserInfoBean,com.qq.connect.api.qzone.UserInfo,com.qq.connect.api.OpenID,com.qq.connect.javabeans.AccessToken,java.sql.ResultSetMetaData,weibo4j.QQ,weibo4j.qq.model.User,com.qq.connect.oauth.Oauth,com.jerehnet.cmbol.database.PoolManager,java.util.Map,weibo4j.Sina,com.jerehnet.cmbol.database.DataManager,java.util.HashMap,java.sql.Connection,com.jerehnet.util.Common,java.sql.ResultSet"%>
 <%
 	Oauth oauth = new Oauth() ; 
 	AccessToken accessToken = new AccessToken() ;  //     
 	accessToken = oauth.getAccessTokenByRequest(request) ;
 	OpenID openID = new OpenID(accessToken.getAccessToken().toString()) ;
    UserInfo qqUserInfo = new  UserInfo(accessToken.getAccessToken().toString(),openID.getUserOpenID().toString()) ;
    UserInfoBean user = qqUserInfo.getUserInfo() ; // qq用户信息
    String qqopenId = openID.getUserOpenID().toString() ; // qq 开放 id
    
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
