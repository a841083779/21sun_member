<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><% 

response.setHeader("P3P","CP=CAO PSA OUR");

Common.createCookie(response,"cookieMemNo","",0);
Common.createCookie(response,"cookiePassw","",0);
Common.createCookie(response,"cookieCreatTime","",0);
session.invalidate();
//Common.createCookie(response,"test2","dddddddddddddddddd",(24*60*60));

%>