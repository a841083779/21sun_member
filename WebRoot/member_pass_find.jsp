<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@ include file ="include/config.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>找回密码 - 中国工程机械商贸网</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/tablestyle.css" rel="stylesheet" type="text/css" />
<link href="style/style_new.css" rel="stylesheet" type="text/css" />
<script src="scripts/jquery-1.4.1.min.js"  type="text/javascript"></script>
<script src="scripts/scripts.js" type="text/javascript"></script>
<script language="Javascript" type="text/javascript"  src="scripts/quick2.js" charset="utf-8"></script>
<script src="scripts/zhucheyanzheng.js"  type="text/javascript"></script>
<script language="javascript">
function KeyDown()
{
    if (event.keyCode == 13)
    {
        event.returnValue=false;
        event.cancel = true;
        document.theform.regid.click();
    }
}
function setFocus()
{
	document.getElementById('mem_no').focus();
}
function showPwd()
{
	if($("#showPwdFlag").attr("checked")==true)
	{
		 $("#passw").hide();
		 $("#passw_show").show();
	}else{
		 $("#passw").show();
		 $("#passw_show").hide();
	}
	
}
function pwd_syc(val)
{
	$("#passw").val(val);
	$("#passw_show").val(val);
}
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
</script>
</head>
<body onload="setFocus();">
<jsp:include page="manage/top_new.jsp" />
<div class="New_registTop contain950">
  <h1><a href="http://www.21-sun.com/" target="_blank"><img src="images/new_logo.gif" alt="中国工程机械商贸网" /></a></h1>
  <h2>找回密码</h2>
</div>
<div class="registForm">
  <div class="registBg">
    <div class="registTop">
      <h3>找回密码</h3>
      <span><a href="/" class="blue">登录</a></span>
    </div>
    <div class="registTable">
      <form id="theform" name="theform" method="post" action="member_pass_find_action.jsp"  onsubmit="return findYanzheng();" >
      <input type="hidden" id="zd_province" name="zd_province"  />
      <input type="hidden" id="zd_city" name="zd_city"  />
        <table width="98%" border="0" cellpadding="0" cellspacing="0">
       	 <tr>
            <th width="37%"><font>*</font> 用户名：</th>
            <td width="63%"><input type="text" name="mem_no" id="mem_no" class="ri" onblur="findformyanzheng('mem_no')" />
		    <div class="diu" id="mem_no_dui" style="display:none"></div>
            <div class="cuo" id="mem_no_cuo" style="display:none"></div>
            <div class="cuo1" id="mem_no_cuo_info" style="display:none"></div>
	        <div id="mem_no_show_info" style="display:none; clear:both;">4-18个字母、数字、"-"或"_"，不支持中文和特殊符号。</div>
            </td>
          </tr>
          <tr>
          	<th><font>*</font> 邮箱：</th>
          	<td colspan="2"><input name="per_email" type="text" class="ri" id="per_email" onfocus="this.className='regiHover'" onblur="findformyanzheng('per_email')"/>
            <div class="diu" id="per_email_dui" style="display:none"></div>
            <div class="cuo" id="per_email_cuo" style="display:none"></div>
            <div class="cuo1" id="per_email_cuo_info" style="display:none"></div></td>
          </tr>
          <tr>
            <th height="30"><font>*</font> 验证码：</th>
            <td colspan="2"><input type="text" name="rand" id="rand" class="ri" style="width:106px;" onkeyup="findformyanzheng('rand')"/>
           <div style="width:auto; float:left; padding-left:8px; padding-top:2px;"><img src="/auth/authImgServlet?now=<%=new java.util.Date()%>" name="authImg" align="absmiddle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/>看不清？<a href="javascript:void(0);" onClick="refresh();" style="color:#005aa0; text-decoration:underline;">换一张</a></div>
	    <div class="diu" id="rand_dui" style="display:none"></div>
        <div class="cuo" id="rand_cuo" style="display:none"></div>
        <div class="cuo1" id="rand_cuo_info" style="display:none"></div>
	    </td>
          </tr>
          <tr>
            <th height="30">&nbsp;</th>
            <td><input type="submit" name="regid" id="regid" value="找回密码" class="registBtn" /></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
  <div class="clear"></div>
</div>
<jsp:include page="manage/foot_new.jsp" />
</body>
</html>
