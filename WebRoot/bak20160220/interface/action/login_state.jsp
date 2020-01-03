<%@ page language="java" import="java.util.*,org.json.*,com.jerehnet.util.*" pageEncoding="UTF-8"%><%
	String callback = Common.getFormatStr(request.getParameter("callback"));
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	if(null!=memberInfo){
		JSONObject obj = new JSONObject(memberInfo);
		out.print(callback+"("+obj.toString()+")");
	}else{
		JSONObject obj = new JSONObject();
		out.print(callback+"("+obj.toString()+")");
	}
%>