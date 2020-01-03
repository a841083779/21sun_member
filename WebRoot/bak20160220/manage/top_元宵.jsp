<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%> 
  <div class="top_g">中国工程机械商贸网旗下子站&nbsp; > &nbsp;<a href="http://www.21-cmjob.com/" target="_blank">工程机械人才网</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://www.21-part.com/" target="_blank">工程机械配件网</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://www.21-rent.com/" target="_blank">工程机械租赁网</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://www.21-used.com/" target="_blank">工程机械二手网</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://sowa.21-sun.com/" target="_blank">搜　　哇 
</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://www.21-sun.com/service/huiyuan/" target="_blank">会员服务</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://www.21peitao.com" target="_blank">配套网</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://www.21-sun.com/china/2010/sjw/index.htm" target="_blank">手机21-sun</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://www.cmbol.com/" target="_blank">中国工程机械外贸网</a></div>
  <div class="hometop" style="margin-top:0px; padding-top:10px; background:url(/images/logo_yx201401.jpg) no-repeat; height:90px;">
<div class="homelogo"><h1><a href="http://www.21-sun.com" target="_blank" style="display:block; width:128px; height:65px;"><img src="http://ad.21-sun.com/homenewads/21logo1.gif" width="128" height="65" alt="中国工程机械商贸网" style="visibility:hidden;" /></a></h1></div><style type="text/css"> .weizhi { margin-top:0px;}</style>
<div class="top1_2g" style="width:67px;"><img src="http://member.21-sun.com/images/my21.gif" style="visibility:hidden;" /></div>
<!--导航开始--> 
<%
	HttpClient httpClient = new HttpClient();
	GetMethod getMethod = new GetMethod("http://www.21-sun.com/include/top.htm");
	httpClient.executeMethod(getMethod);
	String outStr = new String(getMethod.getResponseBody(),"utf-8");
	out.print(outStr);
%>
</div>