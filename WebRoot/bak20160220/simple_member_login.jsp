<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="include/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
String memNo = Common.getMemberInfo("mem_no", pool, request,"member_info", "mem_no","passw","memberInfo");
if(!(memNo.equals("-8888") || memNo.equals("-9999"))){
	out.print("<script>window.close();window.location.href='actiondetail.jsp';</script>");
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="../style/style01.css" rel="stylesheet" type="text/css" />
<script language="javascript">
function tjYanzheng(){
	if(theform.mem_no.value==""){
		alert("用户名不能为空！");
		theform.mem_no.focus();
		return false;
	}else if(theform.passw.value==""){
		alert("密码不能为空！");
		theform.passw.focus();
		return false;
	}else if(theform.rand.value==""){
		alert("验证码不能为空！");
		theform.rand.focus();
		return false;
	}
	document.theform.submit();
}

function KeyDown()
{
    if (event.keyCode == 13)
    {
        event.returnValue=false;
        event.cancel = true;
        tjYanzheng();
    }
}
</script>
</head>
<body>
<div class="center">
  <div class="center1">
    <div class="center1_1"><span class="mainyh">请登录21-SUN通行证</span><br />
      登录后您可以畅游中国工程机械商贸网旗下所有网站，无须再次登录！</div>
    <div class="center1_2">
      <form id="theform" name="theform" method="post" action="simple_member_login_action.jsp" onkeydown="KeyDown()" target="_parent">
        <table width="80%" border="0" align="center">
          <tr>
            <td width="20%"><span class="grayb">用户名：</span></td>
            <td width="51%"><label>
             <input name="mem_no" type="text" id="mem_no" style="width:140px" maxlength="50"/>
              </label></td>
            <td width="29%" rowspan="2"  valign="bottom"><img src="../images/login.gif" width="79" height="29" style="cursor:pointer" onclick="tjYanzheng();"/>&nbsp;</td>
          </tr>
          <tr>
            <td><span class="grayb">密　码：</span></td>
            <td><input name="passw" type="password" id="passw"  style="width:140px" maxlength="50"/></td>
          </tr>
		  <tr>
            <td><span class="grayb">验证码：</span></td>
            <td valign="middle"><input name="rand" type="text" id="rand" style="width:80px" maxlength="20"/>
            <img src="/auth/authImgServlet?now=<%=new java.util.Date()%>" name="authImg" align="middle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td height="40px"><!--<a href="#" class="blue14">忘记密码？</a>--> <a href="http://member.21-sun.com/member_reg.jsp" target="_blank" class="blue14">马上免费注册</a></td>
            <td>&nbsp;</td>
          </tr>
        </table>
      </form>    
    </div>
  </div>
</div>
</body><script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
//refresh();
</script>
</html>
