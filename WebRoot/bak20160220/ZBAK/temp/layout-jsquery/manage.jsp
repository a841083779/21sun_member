<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>杰瑞配件协同管理系统</title>
<link rel="stylesheet" type="text/css" href="css/ui-lightness/jquery-ui-1.7.2.custom.css" />
<link rel="stylesheet" type="text/css" href="css/layout.css" />
<link rel="stylesheet" type="text/css" href="css/jQuery.niceTitle.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.divcorners.css" media="screen" />
<link rel="stylesheet" type="text/css" href="css/prettyCheckboxes.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.2.custom.min.js"></script>
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="js/jquery.layout.js"></script>
<script type="text/javascript" src="js/jQuery.niceTitle.js"></script>
<script type="text/javascript" src="js/jquery.blockUI.js"></script>
<script type="text/javascript" src="js/jquery.divcorners.min.js"></script>
<script type="text/javascript" src="js/jquery.pngFix.pack.js"></script>
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/prettyCheckboxes.js"></script>
<script type="text/javascript" src="js/jquery.livequery.js"></script>
<script type="text/javascript" src="js/layout.js"></script>
<script type="text/javascript" src="js/admin.js"></script>
</head>
<!--
说明：
由于将原来的jsp页面改为现在的html页面，因此注释掉了页面中的jsp代码，页面中的jsp代码的功能为：
<1>判断用户是否登录，未登录则构建Ajax登录框，否则不构建
<2>显示登录用户的相关信息，如：用户名、角色等

为了比较全面的展示整个后台管理框架，这里也将在静态页面中为大家模拟登录功能（由于静态页面无法动态获取用户登录后的信息，所以每次刷新页面都要求登录，本来想引入Cookie插件来保存登录信息，但觉得这是仅仅是模拟一下登录功能，也就不必这么麻烦了，刷新重新登录一下就是）
-->
<%
	String _username = "imleeo", _userrole = "imleeo", _userpassword = "imleeo";
	boolean islogin = true;
%>
<body>
<div class="ui-layout-west" align="center">
  <div class="header" >系统主菜单</div>
  <div style="width:100%;" align="center">
<iframe  src="/1.htm"  width="100%" height="400"  frameborder=No border=0 marginwidth=0 marginheight=0  scrolling=no align="middle" name="leftTree" id="leftTree" ></iframe>
</div>
<!--
<div style="width:100%;" align="center">
  <div class="menu">
    <ul>
      <li> <a href="javascript:void(0);" id="imTest" title="供这个例子使用的测试连接">我是测试链接</a> </li>
      <li> <a href="javascript:void(0);" title="新闻管理">新闻管理</a> </li>
      <li> <a href="javascript:void(0);" title="栏目设置" params="{url: 'newsColumns!findNewsColumns.action', title: '栏目设置', pageNo: 1, pageSize: 5, formID: 'columnsList-form'}">栏目设置</a> </li>
      <li> <a href="javascript:void(0);" title="专题设置" params="{url: 'newsTopics!findNewsTopics.action', title: '专题设置', pageNo: 1, pageSize: 5, formID: 'topicsList-form'}">专题设置</a> </li>
    </ul>
  </div>
  <div class="menu_top_line"></div>
  <div class="menu">
    <ul>
      <li> <a href="javascript:void(0);" title="影片管理" params="{url: 'film!searchFilm.action', title: '影片管理', pageNo: 1, pageSize: 5, formID: 'filmList-form'}">影片管理</a> </li>
      <li> <a href="javascript:void(0);" title="语种设置(增/删/改/查)" params="{url: 'language!setLanguage.action', title: '语种设置', pageNo: 1, pageSize: 5, formID: 'languageList-form'}">语种设置</a> </li>
    </ul>
  </div>
  <div class="menu_top_line"></div>
  <div class="menu">
    <ul>
      <li> <a href="javascript:void(0);" title="用户管理" params="{url: 'user!findUser.action', title: '用户管理', pageNo: 1, pageSize: 5, formID: 'userList-form'}">用户管理</a> </li>
      <li> <a href="javascript:void(0);" title="管理角色列表(增/删/改/查)和分配角色权限" params="{url: 'role!findRole.action', title: '角色管理', pageNo: 1, pageSize: 5, formID: 'roleList-form'}">角色管理</a> </li>
    </ul>
  </div>
  <div class="menu_top_line"></div>
  <div class="menu">
    <ul>
      <li> <a href="javascript:void(0);" title="发行公司管理(增/删/改/查)" params="{url: 'publisher!searchPublishers.action', title: '发行公司', pageNo: 1, pageSize: 5, formID: 'publisherList-form'}">发行公司</a> </li>
      <li> <a href="javascript:void(0);" title="数字院线(增/删/改/查)" params="{url: 'cinema!searchCinema.action', title: '发行公司', pageNo: 1, pageSize: 5, formID: 'cinemaList-form'}">数字院线</a> </li>
      <li> <a href="javascript:void(0);" title="订购排行">订购排行</a> </li>
    </ul>
  </div>
  <div class="menu_top_line"></div>
  <div class="menu">
    <ul>
      <li> <a href="javascript:void(0);" title="系统日志">系统日志</a> </li>
    </ul>
  </div>
  <div class="menu_top_line"></div>
</div>
-->
</div>
<!--
<div class="ui-layout-east">
  <div class="header">便捷工具箱</div>
  <div class="subhead pngfix"><img src="images/operating.png" /><span id="action_title"></span></div>
  <div class="content"> </div>
  <div class="footer">I'm a footer</div>
</div>
-->
<div class="ui-layout-north">
  <div class="content">
    <div id="head-top">
      <div id="logo"><img src="images/logo_test.gif" /></div>
      <div id="quick-menu" class="pngfix"> <img align="absbottom" vspace="5px" src="images/user.png" />欢迎： <a class="lightBlue" href="javascript:void(0);" id="userinfo"> <span id="name_span"> admin</span> </a>， <a class="lightBlue" href="javascript:void(0);" id="userpwd"> <span id="pwd_span">修改密码</span> </a>，
        用户角色：<span id="role_span"> 超级管理员</span>， <a class="lightBlue" href="javascript:void(0);" id="logout">退出</a> </div>
      <br class="clearfloat" />
    </div>
    <div id="head-toolbar">
      <div id="layout-toolbar">
        <ul class="toolbar">
          <li id="tbarToggleNorth" class="first"><span></span></li>
          <li id="tbarOpenSouth"><span></span></li>
          <li id="tbarCloseSouth"><span></span></li>
          <li id="tbarPinWest"><span></span></li>
          <li id="tbarPinEast" class="last"><span></span></li>
        </ul>
      </div>
      <div id="notice" class="pngfix"> <img align="absbottom" vspace="5px" src="images/notice.png" /> 最新公告： </div>
      <br class="clearfloat" />
    </div>
  </div>
</div>
<div class="ui-layout-south">
  <div class="content" style="text-align:center"> <!--<img src="images/logo_jereh.jpg" width="75" height="22" align="absmiddle" />-->　<font color="#FFFFFF">技术支持：</font><a href="http://21-sun.com/home/aboutus/about/" target="_blank" style="text-decoration:none"><font color="#FFFFFF">烟台杰瑞网络</font></a> <a href="http://www.21-sun.com" target="_blank" style="text-decoration:none"><font color="#FFFFFF">中国工程机械商贸网</font></a> </div>
</div>
<div class="ui-layout-center">
  <div class="header"> <img align="absbottom" vspace="5px" src="images/location.png" />当前位置：客户管理<span id="location"></span></div>
  <div class="ui-layout-content">
    <iframe  src="list.jsp"  width="98%" height="98%"  frameborder=No border=0 marginwidth=0 marginheight=0  scrolling=no name="leftTree" id="leftTree" ></iframe>
  </div>
</div>
</body>
</html>
