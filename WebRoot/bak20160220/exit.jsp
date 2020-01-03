<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%
Common.createCookie(response,"cookieMemNo","",0);
Common.createCookie(response,"cookiePassw","",0);
Common.createCookie(response,"cookieCreatTime","",0);
Common.createCookie(response,"is_per_pub","",0);
session.invalidate();
String f = Common.getFormatStr(request.getParameter("f"));
String referer = Common.getFormatStr(request.getHeader("Referer"));
String isback= Common.getFormatStr(request.getParameter("isback"));
if("".equals(f)){
	f = "/member_login.jsp";
}else if("used".equals(f)){
	f = "/member_login.jsp?f="+f;
}
if("true".equals(isback)&&!"".equals(referer)){
	f = referer;
}
if(f.indexOf("?")!=-1){
	if(f.indexOf("exit=")==-1){
		//f += "&exit="+Common.getToday("yyyyMMddHHmmss");
	}
}else{
	if(f.indexOf("exit=")==-1){
		//f += "?exit="+Common.getToday("yyyyMMddHHmmss");
	}
}
//response.sendRedirect("/");
	%><html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>退出</title>
</head>
<body>
<script src="http://market.21-sun.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://www.21-used.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://www.21-rent.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://www.21-part.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://www.21part.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://www.21-cmjob.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://member.21-sun.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://data.21-sun.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://www.21peitao.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://zhidao.21-sun.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script src="http://spec.21-sun.com/sso/sso_exit.jsp" type="text/javascript"></script>
<script type="text/javascript">
window.location.href='<%=f %>';
</script>
</body>
</html>
