<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"
	%><%
//1:表示调用107上的SQLserver数据库,2:表示调用115上的db2数据库
	PoolManager pool = new PoolManager(1);
//
String isSubmit = Common.getFormatStr(request.getParameter("Submit"));
if(!isSubmit.equals("")){
  //====判断验证码是否正确====
  String randSession = (String) session.getAttribute("rand");
  String rand = request.getParameter("rand");
	ManageAction mAction = new ManageAction();
	int result = mAction.adminLogon(pool,request);
	if(result>0){
%>
<script>
	//alert("登陆成功！");
	window.location.href="manage/main.jsp";
</script>
<%		
	}else{
%>
<script>
	alert("登陆失败！");
	history.back();
</script>
<%		
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0">
<script src="scripts/jquery-1.4.1.min.js"  type="text/javascript" charset="utf-8"></script> 
<script>
function onsubmitYN(){
	if($("#usern")==""){
		alert("请填写登陆用户名!");
		$("#usern").focus();
		return false;
	}else if($("#passw").value==""){
		alert("请填写登录密码!");
		$("#passw").focus();
		return false;
	}
	else
	return true;
}
function refresh(){
	document.getElementById("authImg").src='/webadmin/authImgServlet?now=' + new Date();
}
</script>
<title></title>
<style type="text/css">
<!--
body {
	background-image: url(images/login/bg.gif);
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style>


<link href="style/style.css"  rel="stylesheet" type="text/css">
</head>

<body onLoad="window.document.theform.usern.focus();">

<form action="" method="post" name="theform" onSubmit="return onsubmitYN();" target="_top">

<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <table width="470" height="264" border="0" align="center" cellpadding="0" cellspacing="0" background="images/tu.gif">
        <tr>
          <td colspan="3" width="470" height="74">&nbsp;</td>
        </tr>
        <tr>
          <td width="11"><img border="0" src="images/left.gif" width="11" height="190"></td>
          <td width="306"><table border="0" cellpadding="0" cellspacing="0" width="100%" id="table1" height="190">
              <tr>
                <td bgcolor="#FFFFFF"><table width="80%"  border="0" align="right" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="11%">&nbsp;</td>
                    <td width="89%"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="23%" height="30" class="LoginText">用户名：</td>
                          <td height="30" colspan="2"><input name="usern" type="text" class="LoginInput" id="usern" size="20" maxlength="20" tabindex="1"></td>
                        </tr>
                        <tr>
                          <td height="30" class="LoginText">密　码：</td>
                          <td height="30" colspan="2"><input name="passw" type="password" class="LoginInput" id="passw" size="20" maxlength="30" tabindex="2"></td>
                        </tr>
                        <tr>
                          <td height="46">&nbsp;</td>
                          <td height="46"><input type="submit" name="Submit" value="登 陆"></td>
                          <td height="46">&nbsp;</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td height="26"><font class="LoginText"><font color="#FF0000" > </font> </font></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="23"><img border="0" src="images/down.gif" width="307" height="23"></td>
              </tr>
          </table></td>
          <td width="153"><img border="0" src="images/right.gif" width="153" height="190"></td>
        </tr>
      </table></td>
  </tr>
</table>

</form>

</body>
</html>
