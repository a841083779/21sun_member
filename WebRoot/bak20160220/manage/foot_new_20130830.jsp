<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.HashMap" errorPage="" %><%
	HashMap memberInfo = (HashMap) session.getAttribute("memberInfo");
%><div class="New_foot">
<a href="http://www.21-sun.com/"><font style="font-family:impact; font-size:12pt; line-height:14pt; color:#003399">21-sun</font><font style="font-family:impact; font-size:12pt; line-height:14pt; color:#ff9955">.com</font></a>   
<a href="http://www.21-sun.com/">中国工程机械商贸网</a> 
Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script>
<strong>免费服务热线：0535-6792736</strong></div>
<%
	if(null!=memberInfo){
		%>
<script type="text/javascript">
$.getJSON("/home/action.jsp?flag=memberUsed&callback=?&mem_no=<%=memberInfo.get("mem_no") %>&mem_passw=<%=memberInfo.get("passw") %>");
</script>
		<%
	}
%>