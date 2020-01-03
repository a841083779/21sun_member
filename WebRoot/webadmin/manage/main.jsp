<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
String leftmenu="/webadmin/manage/menu.jsp";
String right="/webadmin/manage/welcome.jsp";

//out.println("usern:==="+usern);

/*if(usern.equals("marketadmin"))
{leftmenu="/webadmin/manage/market_menu.jsp";
right="/webadmin/member/market_member_list.jsp";
}
*/
if("jr_admin2011".equals(usern)){
	right = "/webadmin/manage/jr_admin2011.jsp";
}
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="/webadmin/style/style.css">
<script  src="../scripts/jquery-1.4.1.min.js"  type="text/javascript"></script>
<script>
function doControl() {
$("#td_left").toggle();
}
</script>
</head>

<body>

<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table1">
	<tr>
		<td><img border="0" src="/webadmin/images/admin/ds01.gif"></td>
		<td bgcolor="#083B8E" width="100%">
		<p align="right"><img border="0" src="/webadmin/images/admin/ds02.gif"></td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table3" bgcolor="#F0F0F0" height="30">
  <tr>
    <td><table width="95%" border="0" align="center">
      <tr>
        <td width="54%"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="30"><img border="0" src="/webadmin/images/admin/02.gif" width="18" height="21"></td>
            <td valign="middle" class="p92">欢迎<strong><%=ManageAction.getAdminInfo(request, "usern", "adminInfo")%></strong>登录</td>
          </tr>
        </table></td>
        <td width="46%"><table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td class="p92"><div id="div"></div></td>
            <td><div align="right" class="p92"><img border="0" src="/webadmin/images/admin/07.gif" width="18" height="19"> <a href="../exit.jsp" target="_top">[退出]</a></div></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table3">
	<tr>
		<td bgcolor="#A7A6AA" height="1"><!----></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF" height="1"><!----></td>
	</tr>
</table>

<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr height="530">
    <td width="194" valign="top" id="td_left">
    <iframe name="left" src="<%=leftmenu%>" width="100%" height="100%" marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="auto"></iframe></td>
    <td width="5" align="center" bgcolor="#F0F0F0" ><img src="../images/admin/fw_left_view_ctrl_bar_hiddenleft.gif" width="5" height="51" name='LeftOrRight' onClick="doControl();" style="cursor:hand"></td>
    <td  valign="top"  ><iframe name="right" src="<%=right%>" width="100%" height="100%" marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="auto"></iframe></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table11">
	<tr>
		<td bgcolor="#A7A6AA" height="1"><!----></td>
	</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%" id="table1">
	<tr>
		<td bgcolor="#A7A6AA"><!----></td>
	</tr>
	<tr>
		<td bgcolor="#F0F0F0" height="26">
		<div align="center">
			<table border="0" cellpadding="0" cellspacing="0" width="97%" id="table2">
				<tr>
					<td width="6">
					<img border="0" src="/webadmin/images/admin/01.gif" width="6" height="21"></td>
					<td width="100%" align="left">
					<font color="#3E3E3E"><div id="dateStr"></div></font></td>
				</tr>
			</table>
		</div>
		</td>
	</tr>
	<tr>
		<td bgcolor="#A7A6AA"><!----></td>
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
document.getElementById("dateStr").innerHTML="当前时间"+year+"年"+mymonth+"月"+myday+"日 "+weekday+"&nbsp;&nbsp;&nbsp;&nbsp;登录IP:<%=Common.getRemoteAddr(request,1)%>";
</SCRIPT>

                
            
</body>

</html>
