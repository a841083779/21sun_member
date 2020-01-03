<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登陆</title><br />
<script>
function openSystem(url){
	window.opener=null;
   //var l = (screen.width - w) / 2; 
  // var t = (screen.height - h) / 2; 
   var l = 0; 
   var t = 0;    
  // alert('width=' + (screen.width) + ', height=' + (screen.height-20) );
   var s = 'width=' + (screen.width) + ', height=' + (screen.height-60) + ', top=' + t + ', left=' + l; 
   s += ', toolbar=no, scrollbars=no, menubar=no, location=no, resizable=no,status=no'; 
   window.open(url, "system", s);
   window.close();
}
</script>
</head>

<body>
<table width="98%" height="98%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center" valign="middle"><a href="#" onclick="openSystem('manage.jsp');">登陆</a></td>
  </tr>
</table>
</body>
</html>
