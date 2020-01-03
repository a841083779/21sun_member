<%@ page language="java" import="java.util.*,com.jerehnet.util.Common" pageEncoding="UTF-8"%><%
	String randSession = Common.getFormatStr((String)session.getAttribute("loginRand"));
	String rand = Common.getFormatStr(request.getParameter("rand"));
	if(rand.equals(randSession)){
		out.print(true);
	}else{
		out.print(false);
	}
%>