<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>system_info_bar</title>
<link href="../style/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="22" background="../images/admin/fw_system_info_bar_bg.gif"><table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="56%" class="font_system_info_bar_welcome"><div id="dateStr"></div></td>
        <td width="44%" align="right" class="font_system_info_bar_total">[<a href="/" target="_blank" >网站首页</a>]<!-- [<a href="#" target="mainFrame">修改密码</a>]--> [<a href="../exit.jsp" target="_top">退出</a>] </td>
      </tr>
    </table></td>
  </tr>
</table>
<SCRIPT language=JavaScript type=text/javascript>
var day="";
var month="";
var ampm="";
var ampmhour="";
var myweekday="";
var year="";
mydate=new Date();
myweekday=mydate.getDay();
mymonth=mydate.getMonth()+1;
myday= mydate.getDate();
myyear= mydate.getYear();
year=(myyear > 200) ? myyear : 1900 + myyear;
if(myweekday == 0)
weekday=" 星期日 ";
else if(myweekday == 1)
weekday=" 星期一 ";
else if(myweekday == 2)
weekday=" 星期二 ";
else if(myweekday == 3)
weekday=" 星期三 ";
else if(myweekday == 4)
weekday=" 星期四 ";
else if(myweekday == 5)
weekday=" 星期五 ";
else if(myweekday == 6)
weekday=" 星期六 ";
document.getElementById("dateStr").innerHTML="欢迎您使用杰配网管理平台&nbsp;&nbsp;&nbsp;&nbsp;"+year+"年"+mymonth+"月"+myday+"日 "+weekday;
</SCRIPT>
</body>
</html>
