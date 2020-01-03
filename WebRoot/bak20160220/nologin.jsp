<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%

Common.createCookie(response,"cookieMemNo","",0);
Common.createCookie(response,"cookiePassw","",0);
Common.createCookie(response,"cookieCreatTime","",0);
session.invalidate();

//response.sendRedirect("/");
	%><html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>退出</title>

</head>
<body>
<!--
<script src="http://part.21-sun.com/sso/sso_exit.jsp"  type="text/javascript"></script>
<script src="http://market.21-sun.com/sso/sso_exit.jsp"  type="text/javascript"></script>
<script src="http://used.21-sun.com/sso/sso_exit.jsp"  type="text/javascript"></script>
<script src="http://rent.21-sun.com/sso/sso_exit.jsp"  type="text/javascript"></script>
<script src="http://member.21-sun.com/sso/sso_exit.jsp"  type="text/javascript"></script>
-->
<script type="text/javascript">
 window.location.href='/';
</script>
</body>
</html>
