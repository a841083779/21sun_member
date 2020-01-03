<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"	%>
<%
String addflag= Common.getFormatInt(request.getParameter("addflag"));   //操作标识
String serverPath = request.getServletPath();
%>
<div class="subTop contain950">
  <h1><a href="http://www.21-sun.com/" target="_blank"><img src="../images/new_logo.gif" alt="中国工程机械商贸网" /></a></h1>
  <div class="menu">
    <ul>
      <li <%if("0".equals(addflag)&&serverPath.indexOf("/manage/used.jsp")==-1){%>class="selected"<%}%>><a href="/manage/memberhome.jsp">首 页</a></li>
      <li <%if("61".equals(addflag)){%>class="selected"<%}%>><a href="/manage/membermain.jsp?addflag=61">供 求</a></li>
      <li <%if("64".equals(addflag)){%>class="selected"<%}%>><a href="/manage/membermain.jsp?addflag=64">配 件</a></li>
      <li <%if(serverPath.indexOf("/manage/used.jsp")!=-1){%>class="selected"<%}%>><a href="/home/used/">二 手</a></li>
      <li <%if("63".equals(addflag)){%>class="selected"<%}%>><a href="/manage/membermain.jsp?addflag=63">租 赁</a></li>
    </ul>
  </div>
</div>