<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<% 
  // 判断用户是否已经登陆
  Map memberInfo = null ;
  memberInfo = (HashMap) session.getAttribute("memberInfo") ; ;
  String sessionMemNo = "" ;
  if(null != memberInfo)
  {
	  sessionMemNo  =((String)memberInfo.get("mem_no"));  // 获得session 中的登陆名
  }
	String exitUrl = "/exit.jsp";
	//如果是二手退出
	if("/manage/used.jsp".equals(request.getServletPath())){
		exitUrl = "/exit.jsp?f=used";
	}
%> 
<div class="New_topbg">
  <div class="contain1002">
    <div class="New_topLinks"><%=sessionMemNo.equals("")?"<a href='/member_login.jsp'>帐号登录</a>":"Hi, "+sessionMemNo+" ！&nbsp;<a href='"+exitUrl+"'>退出" %></a> &nbsp;&nbsp;&nbsp;客户热线：0535-6792736 &nbsp;&nbsp; <a href="http://wpa.qq.com/msgrd?V=1&Uin=1955635340&Site=中国工程机械商贸网&Menu=yes" target="_blank" title="在线咨询">QQ：1955635340</a>&nbsp;&nbsp; 产品咨询热线：4006-521-526 &nbsp;&nbsp; <a href="http://www.21-sun.com/">返回商贸网首页</a></div>
    <ul class="tlRight">
<!--  
      <li class="guide sws"><span>我的商务室</span>
        <ul>
          <li><a href="http://market.21-sun.com">供求市场</a></li>
          <li><a href="http://www.21-sun.com/supply">供 应 商</a></li>
          <li><a href="http://data.21-sun.com">数据分析</a></li>
          <li><a href="http://www.21-sun.com/bidding">招 投 标</a></li>
          <li><a href="http://www.21-cmjob.com">招聘求职</a></li>
          <li><a href="http://news.21-sun.com">行业动态</a></li>
          <li><a href="http://product.21-sun.com">整机市场</a></li>
          <li><a href="http://stock.21-sun.com">行业股市</a></li>
          <li><a href="http://www.21-sun.com/part">配件市场</a></li>
          <li><a href="http://bbs.21-sun.com">铁臂论坛</a></li>
          <li><a href="http://www.21-rent.com">租赁调剂</a></li>
          <li><a href="http://blog.21-sun.com">铁臂博客</a></li>
        </ul>
      </li>
      <li class="tl"><a href="#">询价单</a></li>
      
-->
      <li class="tl"><a href="http://aboutus.21-sun.com/contact/" target="_blank">客服中心</a></li>
      <li class="guide"><span>网站导航</span>
        <ul>
          <li><a href="http://market.21-sun.com" target="_blank">供求市场</a></li>
          <li><a href="http://www.21-sun.com/supply" target="_blank">供 应 商</a></li>
          <li><a href="http://www.cmbol.com/" target="_blank">CMBOL</a></li>
          <li><a href="http://www.21-sun.com/bidding" target="_blank">招 投 标</a></li>
          <li><a href="http://www.21-cmjob.com" target="_blank">招聘求职</a></li>
          <li><a href="http://news.21-sun.com" target="_blank">行业动态</a></li>
          <li><a href="http://product.21-sun.com" target="_blank">整机市场</a></li>
          <li><a href="http://stock.21-sun.com" target="_blank">行业股市</a></li>
          <li><a href="http://www.21-sun.com/part" target="_blank">配件市场</a></li>
          <li><a href="http://www.21-sun.com/service/huiyuan/" target="_blank">会员服务</a></li>
          <li><a href="http://www.21-rent.com" target="_blank">租赁调剂</a></li>
          <li><a href="http://sowa.21-sun.com/" target="_blank">搜　　哇</a></li>
        </ul>
      </li>
    </ul>
  </div>
</div>