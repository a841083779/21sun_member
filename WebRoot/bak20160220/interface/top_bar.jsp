<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%
	Map memberInfoMap = (HashMap)session.getAttribute("memberInfo") ;
	System.out.println(memberInfoMap+"<<<") ;
	String callback = request.getParameter("callback");
	String htm = "";
	htm += "<link href='http://member.21-sun.com/style/top_login.css' rel='stylesheet' type='text/css' /><div class='New_topbar1' style='width:100%; height:31px; background:url(http://www.21-sun.com/newhomeimg/top01.gif) top repeat-x; clear:both; margin-bottom:10px;'>";
	htm += "<div style='width:950px;margin:0 auto;'>";
	if(null==memberInfoMap){ 
		htm += "<form id='sun21LoginForm' name='sun21LoginForm' action='http://member.21-sun.com/interface/action/login.jsp?isback=true' onkeydown='keySub(event)' method='post' target='_self'>";
		htm += "<ul style='width:455px;float:left;padding-top:4px;'>";
		htm += "<li style='float:left; height:20px;line-height:20px;color:#5A5A5A;'>用户名：<input style='width:80px;height:16px;border:1px solid #ccc;' type='text' maxlength='20' size='10' name='mem_no'></li>";
		htm += "<li style='float:left;margin-left:10px;height:20px;line-height:20px;color:#5A5A5A;'>密码：<input style='width:80px;height:16px;border:1px solid #ccc;' type='password' maxlength='20' size='10' name='password'></li>";
		htm += "<li style='float:left;margin:0 2px 0 2px;height:20px;line-height:20px;'><input type='button' name='btnlogin' onclick='doSun21Sub();' value='&nbsp;' style='width:39px; height:18px; border:none; cursor:pointer; background:url(http://www.21-sun.com/newhomeimg/bottom.gif) no-repeat; vertical-align:-2px; *margin-top:2px;' /></li>";
		htm += "<li style='float:left;height:20px;line-height:20px;color:#5A5A5A;'><a target='_blank' rel='nofollow' href='http://member.21-sun.com/member_reg.jsp'>&nbsp;&nbsp;注册</a></li>";
		htm += "<li class='bit_link' id='loginOther'><strong><a href='javascript:;' onclick='return false ;'>其它帐号登录<em></em></a><sub></sub></strong>";
		htm += "<ul id='ulSqure'>" ;
		htm += "<li><a onclick='javascript:oauthLogin(2);' href='javascript:void(0)' title='新浪微博帐号登录' class='sina' target='_self'>新浪微博</a></li>" ;
		htm += "<li><a onclick='oauthLogin(4)' href='javascript:void(0)' title='QQ帐号登录' class='qq' target='_self'>QQ帐号</a></li>" ;
		htm += "</ul>" ;
		htm +="</li>";
		htm += "</ul>";
	}else{
		htm += "<ul style='float:left;padding-top:4px;color:#5A5A5A;'>";
		htm += "<li><span style='margin-left:15px;height:20px;line-height:20px;'></span>您好，"+memberInfoMap.get("mem_no")+" ！ <a target='_blank' href='http://member.21-sun.com/' style='color:red;font-weight:bold;'>我的商务室</a> <a href='http://member.21-sun.com/exit.jsp?isback=true' target='_self'>退出</a></li>";
		htm += "</ul>";
	} 
	htm +="<ul style='width:490px;float:right;padding-top:4px;'>";
	htm +="<li style='float:right;height:20px;line-height:20px;margin-left:5px;'><a href='http://www.21-sun.com/weixin/' target='_blank'><img src='http://www.21-sun.com/weixin/images/weixin.jpg' width='74' height='20' /></a></li>";
	htm +="<li style='float:right;height:20px;line-height:20px;'><iframe width='63' scrolling='no' height='22' frameborder='0' src='http://widget.weibo.com/relationship/followbutton.php?language=zh_cn&amp;width=63&amp;height=24&amp;uid=1904756027&amp;style=1&amp;btn=red&amp;dpc=1' border='0' marginheight='0' marginwidth='0'></iframe></li>";
	htm +="<li style='float:right;margin:0 2px 0 2px;height:20px;line-height:20px;'>|</li>";
	htm +="<li style='float:right;height:20px;line-height:20px;'><a rel='nofollow' target='_blank' href='http://www.21-sun.com/app/'><img alt='手机21-sun' src='http://ad.21-sun.com/newhomeimg/phone.gif'> 手机21-sun</a></li>";
	htm +="<li style='float:right;margin:0 2px 0 2px;height:20px;line-height:20px;'>|</li>";
	htm +="<li style='float:right;height:20px;line-height:20px;'><a target='_blank' href='http://www.cmbol.com'>English</a></li>";
    htm +="<li style='float:right;margin:0 2px 0 2px;height:20px;line-height:20px;'>|</li>";
    htm +="<li style='float:right;height:20px;line-height:20px;'><a target='_blank' href='http://www.21-sun.com/service/'>企业服务</a></li>";
    htm +="<li style='float:right;margin:0 2px 0 2px;height:20px;line-height:20px;'>|</li>";
    htm +="<li style='float:right;height:20px;line-height:20px;'><a title='中国工程机械商贸网' target='_top' onclick='favorite();' href='javascript:void(0);' rel='nofollow'>加入收藏</a></li>";
    htm +="<li style='float:right;margin:0 2px 0 2px;height:20px;line-height:20px;'>|</li>";
    htm +="<li style='float:right;height:20px;line-height:20px;'><a rel='nofollow' href='javascript:void(0);' onclick='setHome(this);' name='homepage'>设为首页</a></li>";
    htm +="</ul>";
	htm += "<div style='clear:both;'></div>";
	htm += "</div>";
	htm += "<script language='javascript' type='text/javascript' src='http://www.21-sun.com/scripts/login.js'></script>";
	htm += "<script language='javascript' type='text/javascript' src='http://member.21-sun.com/scripts/other_login.js'></script>";
	out.print(callback+"({\"rs\":\""+htm+"\"})");
%>