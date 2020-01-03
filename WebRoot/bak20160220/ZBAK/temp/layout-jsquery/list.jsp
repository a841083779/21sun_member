<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>杰瑞配件协同管理系统</title>
<link rel="stylesheet" type="text/css" href="css/layout.css" />
<link rel="stylesheet" type="text/css" href="css/prettyCheckboxes.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.pngFix.pack.js"></script>
<script type="text/javascript" src="js/prettyCheckboxes.js"></script>
<script type="text/javascript" src="js/jquery.livequery.js"></script>
<script type="text/javascript" src="js/admin.js"></script>
<script>
function openWin(url,w,h){
	window.opener=null;
   var l = (screen.width - w) / 2; 
   var t = (screen.height - h) / 2; 
  // var l = 0; screen.width
   //var t = 0; screen.height
  // alert('width=' + (screen.width) + ', height=' + (screen.height-20) );
   var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
   s += ', toolbar=no, scrollbars=no, menubar=no, location=no, resizable=no,status=no'; 
   window.open(url, "win", s);
}
</script>
<style type="text/css">
<!--
body {
	margin-left: 8px;
	margin-right: 8px;
}
-->
</style></head>
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
<table border="0" cellspacing="0" cellpadding="0" class="stripeMe sample">
  <thead>
    <tr>
      <th colspan="8" > <a href="javascript:void(0);" onclick="openWin('form.jsp',500,400);" class="black"><img align="absmiddle" src="images/add.gif" />&nbsp;新增</a>&nbsp;&nbsp; <a href="javascript:void(0);" onclick="showAlert();" class="black"><img align="absmiddle" src="images/delete.gif" />&nbsp;删除</a>&nbsp;&nbsp; <a href="javascript:void(0);" onclick="showAlert();" class="black"><img align="absmiddle" src="images/search.gif" />&nbsp;搜索</a>&nbsp; </th>
    </tr>
    <tr>
      <th><input name="checkbox" type="checkbox" id="checkbox_all" onclick="checkAllPrettyCheckboxes(this,$('#filmList-body'));" />
          <label for="checkbox_all" tabindex="0"></label></th>
      <th>序号</th>
      <th>影片名称</th>
      <th>影片类型</th>
      <th>影片性质</th>
      <th>订购状态</th>
      <th>更新时间</th>
      <th>操作</th>
    </tr>
  </thead>
  <tbody id="filmList-body">
    <%
for(int i=1;i<17;i++){
%>
    <tr>
      <td style="padding-left:7px"><input type="checkbox" id='checkbox_<%=i%>' name="checkboxes" value='<%=i%>' />
          <label for='checkbox_<%=i%>' tabindex='<%=i%>'></label>
      </td>
      <td align="center"><%=i%></td>
      <td>《IT北瓜》</td>
      <td>程序员</td>
      <td>自由版权</td>
      <td>欢迎订购</td>
      <td>2009-10-27 23:02:58</td>
      <td><a href="javascript:void(0);" onclick='showAlert();' class="lightBlack"><img align="absbottom" src="images/edit.gif" />编辑</a>&nbsp;&nbsp; <a href="javascript:void(0);" onclick='showAlert();' class="lightBlack"><img align="absbottom" src="images/delete.gif" />删除</a>&nbsp;&nbsp; <a href="javascript:void(0);" onclick='showAlert();' class="lightBlack"><img align="absbottom" src="images/add.gif" />上传</a>&nbsp;&nbsp; </td>
    </tr>
    <%}%>
  </tbody>
</table>
</body>
</html>
