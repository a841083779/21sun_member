<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%>
<%
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script>
function submitYN(){
	var passw = document.getElementById("passw");
	var passw2 = document.getElementById("passw2");
	if(passw.value.length<4 || passw.value.length>18){
		alert("密码长度为4-18位之间，并且中间不能含有空格。");
		return false;
	}else if(passw.value!=passw2.value){
		alert("两次输入的密码不正确。");
		return false;
	}
	document.theform.submit();
}
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">个人密码修改</span></div>
  <div class="loginlist_right1">
    <table width="95%" border="0">
      <tr>
        <td style="padding-left:40px;"><b>友情提示：</b>请尽量采用字母＋数字＋标点符号的方式设置密码，提高密码安全性。</td>
      </tr>
    </table>
    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" class="tablezhuce">
        <form action="user_passw_opt_action.jsp" method="post" name="theform" id="theform">
        <tr>
          <td  nowrap="nowrap"  class="right"><span class="grayb">用&nbsp;&nbsp;户&nbsp;&nbsp;名：</span></td>
          <td ><%=memberInfo.get("mem_no")%></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">密　　码：</span></td> 
          <td height="22" ><input name="passw" type="password" id="passw" size="50" maxlength="40" value=""></td>
        </tr>
        <tr>
          <td height="22"  nowrap="nowrap" class="right"><span class="grayb">确认密码：</span></td>
          <td height="22" ><input name="passw2" type="password" id="passw2" size="50" maxlength="40" value=""></td>
        </tr>
       
        <tr>
          <td height="22" align="center" bgcolor="#FFFFFF" >&nbsp;</td>
          <td height="22" align="center" bgcolor="#FFFFFF" ><input type="button" id="submitId" name="Submit" value="保 存" class="tijiao" style="cursor:pointer"  onClick="submitYN()"/></td>
        </tr>
      </form>
    </table>
  </div>
</div>

</body>
</html>