<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" %><%
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0);
	String parentReferer = request.getHeader("Referer");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>登录</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script src="/scripts/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/scripts/jquery.form.js" type="text/javascript"></script>
</head>
<body style="overflow:hidden;">
<form name="theform" id="theform" action="/interface/login_and_regist/login_action.jsp" method="post">
<!--登录-->
<div class="C_layer">
  <div class="C_title" style="display: none;">
    <h2><b>会员登录</b></h2>
    <!-- 
    <a href="javascript:void(0);" class="close" title="关闭"></a> -->
  </div>
  <div class="C_content">
    <div class="C_tip" style="visibility:hidden;margin-top: 5px;"><em></em>只有会员才能查看，请登录。</div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="C_loginForm">
      <tr>
        <th>用户名</th>
        <td>
        <div style="position:relative;">
          <input type="text" name="mem_no" id="mem_no" class="C_login_input_username login" />
          <span style="font-size:12px; color:#ABABAB; position:absolute; left:7px; top:5px;" id="username_txt" onclick="jQuery('#mem_no').focus();"><!-- 用户名 --></span>
        </div>
        </td>
      </tr>
      <tr>
        <th>密　码</th>
        <td>
         <div style="position:relative;">
        	<input type="password" name="password" id="password" class="C_login_input_password login" />
        	<span style="font-size:12px; color:#ABABAB; position:absolute; left:7px; top:5px;" id="username_password" onclick="jQuery('#password').focus();"><!-- 密码 --></span>
         </div>
        </td>
      </tr>
      <tr>
        <th>验证码</th>
        <td>
        <div class="l mr10" style="width:107px;position:relative;">
	        <input maxlength="4" type="text" name="rand" id="rand" class="C_login_input_verifycode login" />
	        <span style="font-size:12px; color:#ABABAB; position:absolute; left:7px; top:5px;" id="username_rand" onclick="jQuery('#rand').focus();"><!-- 验证码 --></span>
        </div>
        <div class="C_reg_p_img_verifycode">
			<img style="width:60px;height:20px;vertical-align:-12px;" title="如果您看不清，请在图片上单击，可以更换验证码！" id="authImg" class="pass_reg_verifycode" src="/auth/authImgServlet" />
			<span onclick="refresh();" id="pass_reg_change_verifycode_0" class="pass_reg_change_verifycode" style="vertical-align:-6px;">看不清？</span>
		</div>
        </td>
      </tr>
      <tr>
        <th>&nbsp;</th>
        <td>
        <div class="C_login_p_btn">
          <input type="button" value="登录" onclick="doLogin();" class="C_login_input C_login_input_submit">
        </div>
        </td>
      </tr>
    </table>
    <div class="reg_line"></div>
    <div class="reg_holder">还没有21-SUN通行证？<a target="_blank" href="http://member.21-sun.com/member_reg.jsp">立即注册</a></div>
    
  </div>
</div>
</form>
<div style="display:none;">
	<form id="refParent" action="<%=parentReferer %>" target="_parent" method="post"><input id="refParentBtn" type="submit" /></form>
	<input type="hidden" id="ssoCount" value="0" />
</div>
</body>
</html>
<script type="text/javascript">
var logins = jQuery(".login");
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
logins.keyup(function(){
	var val = jQuery(this).val();
	if(val!=''){
		jQuery(this).next().hide();
	}else{
		jQuery(this).next().show();
	}
});
logins.focus(function(){
	logins.css("border","1px solid #ccc");
	jQuery(this).css("border","1px solid blue");
});
logins.blur(function(){
	logins.css("border","1px solid #ccc");
});
jQuery(function(){
	jQuery("#mem_no").focus();
});
jQuery("#mem_no").keydown(function(e){
	if(e.keyCode==13){
		jQuery("#password").focus();
	}
});
jQuery("#password").keydown(function(e){
	if(e.keyCode==13){
		jQuery("#rand").focus();
	}
});
jQuery("#rand").keydown(function(e){
	if(e.keyCode==13){
		doLogin();
	}
});
function doLogin(){
	if(!doVa()){
		return;
	}
	jQuery("#theform").ajaxSubmit({
		type : "POST",
		success : function(rs){
			if(jQuery.trim(rs)!=""){
				jQuery("#refParentBtn").click();
				//sso(jQuery.trim(rs));
				//setTimeout(function(){
					//jQuery("#refParentBtn").click();
				//},500);
			}else{
				alert("用户名或者密码不正确");
			}
			
		}
	});
}
function doVa(){
	var mem_no = jQuery("#mem_no");
	var password = jQuery("#password");
	var rand = jQuery("#rand");
	var tip = jQuery(".C_tip");
	if(mem_no.val()==''){
		tip.html("<em></em>请输入用户名！");
		tip.css('visibility','visible');
		tip.show();
		return false;
	}
	if(password.val()==''){
		tip.html("<em></em>请输入密码！");
		tip.css('visibility','visible');
		return false;
	}
	if(rand.val()==''){
		tip.html("<em></em>请输入验证码！");
		tip.css('visibility','visible');
		return false;
	}
	if(!randOK()){
		tip.html("<em></em>验证码输入错误！");
		tip.css('visibility','visible');
		refresh();
		return false;
	}
	tip.css('visibility','hidden');
	return true;
}
function randOK(){
	var randOK = false;
	jQuery.ajax({
		url : "/interface/login_and_regist/rand_action.jsp",
		async : false,
		data : {
			rand : jQuery("#rand").val()
		},
		success : function(rs){
			if(rs=='true'){
				randOK = true;
			}
		}
	});
	return randOK;
}
function sso(keyPar){
	$.getJSON("http://www.21-part.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://market.21-sun.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://www.21-rent.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://blog.21-sun.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://www.21part.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://www.21-cmjob.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://space.21-sun.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://member.21-sun.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://data.21-sun.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://www.21peitao.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://zhidao.21-sun.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
	$.getJSON("http://spec.21-sun.com/sso/sso.jsp?callback=?&key="+keyPar,function(){
		var ssoCount = parseInt($("#ssoCount").val(),10);
		ssoCount = ssoCount + 1;
		$("#ssoCount").val(ssoCount);
	});
}
</script>