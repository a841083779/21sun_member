<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%
	Map memberInfoMap = (HashMap)session.getAttribute("memberInfo") ;
	String callback = request.getParameter("callback");
	String htm = "";
	htm += "<div style='width:100%; height:31px; background:url(http://www.21-sun.com/newhomeimg/top01.gif) top repeat-x; clear:both; margin-bottom:10px;'>";
	htm += "<div style='width:950px;margin:0 auto;padding-top:4px;'>";
	if(null==memberInfoMap){
		htm += "<form id='sun21LoginForm' name='sun21LoginForm' action='http://member.21-sun.com/interface/action/login.jsp?isback=true' onkeydown='keySub(event)' method='post'>";
		htm += "<ul style='width:380px;float:left;'>";
		htm += "<li style='float:left;'><span>用户名：</span><input style='width:80px;height:18px;border:1px solid #ccc;' type='text' maxlength='20' size='10' name='mem_no'></li>";
		htm += "<li style='float:left;margin-left:10px;'><span>密码：</span><input style='width:80px;height:18px;border:1px solid #ccc;' type='password' maxlength='20' size='10' name='password'></li>";
		htm += "<li style='float:left;margin:0 5px 0 5px;'><input type='button' name='btnlogin' onclick='doSun21Sub();' value='&nbsp;' style='width:39px; height:18px; border:none; cursor:pointer; background:url(http://www.21-sun.com/newhomeimg/bottom.gif) no-repeat; vertical-align:middle;vertical-align:3px;' /></li>";
		htm += "<li style='float:left;'><a target='_blank' rel='nofollow' href='http://member.21-sun.com/member_reg.jsp'>免费注册</a></li>";
		htm += "</ul>";
	}else{
		htm += "<ul style='float:left;'>";
		htm += "<li><span style='margin-left:15px;'></span>您好，"+memberInfoMap.get("mem_no")+" ！ <a target='_blank' href='http://member.21-sun.com/' style='color:red;font-weight:bold;'>我的商务室</a> <a href='http://member.21-sun.com/exit.jsp?isback=true'>退出</a></li>";
		htm += "</ul>";
	}
	htm +="<ul style='width:560px;float:right;'>";
	htm +="<li style='float:right;'><iframe width='63' scrolling='no' height='22' frameborder='0' src='http://widget.weibo.com/relationship/followbutton.php?language=zh_cn&amp;width=63&amp;height=24&amp;uid=1904756027&amp;style=1&amp;btn=red&amp;dpc=1' border='0' marginheight='0' marginwidth='0'></iframe></li>";
	htm +="<li style='float:right;margin:0 5px 0 5px'>|</li>";
	htm +="<li style='float:right;'><a rel='nofollow' target='_blank' href='http://www.21-sun.com/app/'><img alt='手机21-sun' src='http://ad.21-sun.com/newhomeimg/phone.gif'> 手机21-sun</a></li>";
	htm +="<li style='float:right;margin:0 5px 0 5px'>|</li>";
	htm +="<li style='float:right;'><a target='_blank' href='http://www.cmbol.com'>English</a></li>";
    htm +="<li style='float:right;margin:0 5px 0 5px'>|</li>";
    htm +="<li style='float:right;'><a target='_blank' href='http://www.21-sun.com/service/'>企业服务</a></li>";
    htm +="<li style='float:right;margin:0 5px 0 5px'>|</li>";
    htm +="<li style='float:right;'><a target='_blank' href='http://aboutus.21-sun.net/map.htm'>网站导航</a></li>";
    htm +="<li style='float:right;margin:0 5px 0 5px'>|</li>";
    htm +="<li style='float:right;'><a title='中国工程机械商贸网' target='_top' onclick='favorite();' href='javascript:void(0);' rel='nofollow'>加入收藏</a></li>";
    htm +="<li style='float:right;margin:0 5px 0 5px'>|</li>";
    htm +="<li style='float:right;'><a rel='nofollow' href='javascript:void(0);' onclick='setHome(this);' name='homepage'>设为首页</a></li>";
    htm +="</ul>";
	htm += "<div style='clear:both;'></div>";
	htm += "</div>";
	htm += "<script language='javascript' type='text/javascript' src='http://www.21-sun.com/scripts/login.js'></script>";
	out.print(callback+"({\"rs\":\""+htm+"\"})");
%>