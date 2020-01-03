<%@ page language="java" import="javax.servlet.http.Cookie,com.jerehnet.util.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*" pageEncoding="UTF-8"%><%
	HttpClient httpClient = new HttpClient();
	PostMethod postMethod = new PostMethod();
	Cookie [] cookies = request.getCookies();
	String cookieStr = "";
	String result = "";
	if (null != cookies) {
		for (Cookie cookie : cookies) {
			cookieStr += cookie.getName() + "=" + cookie.getValue() + ";";
		}
	}
	if (!"".equals(cookieStr)) {
		postMethod.setRequestHeader("cookie", cookieStr);
	}
	String f = Common.getFormatStr(request.getParameter("f"));
	if("used".equals(f)){
		response.sendRedirect("http://www.21-used.com/tools/http_login.jsp?usern=info&password=jereh123");
		return;
	}else if(f.indexOf("job_")!=-1){
		response.sendRedirect("http://www.21-cmjob.com/tools/http_login.jsp?f="+f+"&usern=qygjc2011&passw=qygjc2011");
		return;
	}else if("qikan".equals(f)){
		response.sendRedirect("http://news.21-sun.com/qikan/http_login.jsp");
		return;
	}else if("spec".equals(f)){
		response.sendRedirect("http://spec.21-sun.com/webadmin/21specialcolumnslogin_simple.jsp?websiteFlag=1&usern=qygjc2011&passw=qygjc2011");
		return;
	}
%>