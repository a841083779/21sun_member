<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.Common"%>
<%@page import="com.qq.connect.oauth.Oauth"%>
<%
	String to = Common.getFormatStr(request.getParameter("to")) ; // 
	String redirect_uri = Common.getFormatStr(request.getParameter("")) ;  // 回调地址
	if("2".equals(to)){  // sina
		response.sendRedirect("https://api.weibo.com/oauth2/authorize?client_id=3516048995&redirect_uri=http://member.21-sun.com/openplatform/sina.jsp&response_type=code") ;
	}
	if("4".equals(to)){  // qq
	    response.setContentType("text/html;charset=utf-8");
		response.sendRedirect(new Oauth().getAuthorizeURL(request));  //  
		//  response.sendRedirect("https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=100365337&scope=all&redirect_uri=http://member.21-sun.com/openplatform/qq.jsp") ;
	}
%>
