<%@ page language="java" import="java.util.*,com.jerehnet.util.*" pageEncoding="UTF-8"%><%
	String callback = Common.getFormatPic(request.getParameter("callback"));
	session.removeAttribute("memberInfo");
	out.print(callback+"({'rs':'true'})");
%>