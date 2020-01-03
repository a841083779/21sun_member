<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@ include file ="/include/config.jsp"%>
<%
	String code = Common.getFormatStr(request.getParameter("code"));
	String codeCookie = Common.getFormatStr(Common.getCookies(request, "code"));
	if(code.equals("") || !code.equals(codeCookie)){
		%>
        	<script>
				alert("该链接已经失效，请重新获取修复密码邮件");
				window.location.href = "/member_pass_find.jsp";
			</script>
        <%	
	}
	if(pool==null){
		pool = new PoolManager();
	}
	Connection conn =null;
	PreparedStatement pstmt = null;	
	ResultSet rs = null;
	String sql = " select count(*) as count from member_info where mem_no = ? and per_email = ? ";
	try{
		conn = pool.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, Common.getFormatStr(request.getParameter("key")));
		pstmt.setString(2, Common.getFormatStr(request.getParameter("email")));
		rs = pstmt.executeQuery();
		if(rs != null && rs.next() && rs.getInt("count") <= 0){
			%>
            	<script>
					alert("帐号信息有误，请重新找回密码");
					window.location.href = "/member_pass_find.jsp";
				</script>
            <%
		}
	}catch(Exception e){e.printStackTrace();}
	finally{
		pool.freeConnection(conn);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>重置密码 - 中国工程机械商贸网</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<link href="/style/style_new.css" rel="stylesheet" type="text/css" />
<script src="/scripts/jquery-1.4.1.min.js"  type="text/javascript"></script>
<script src="/scripts/scripts.js" type="text/javascript"></script>
<script language="Javascript" type="text/javascript"  src="/scripts/quick2.js" charset="utf-8"></script>
<script src="/scripts/zhucheyanzheng.js"  type="text/javascript"></script>
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
<body>
<jsp:include page="/manage/top_new.jsp" />
<div class="New_registTop contain950">
  <h1><a href="http://www.21-sun.com/" target="_blank"><img src="/images/new_logo.gif" alt="中国工程机械商贸网" /></a></h1>
  <h2>设置新密码</h2>
</div>
<div class="registForm">
  <div class="registBg">
    <div class="registTop">
      <h3>设置新密码</h3>
      <span><a href="/" class="blue">登录</a></span>
    </div>
    <div class="registTable">
      <form id="theform" name="theform" method="post" action="pwd_set.jsp" onsubmit="return regYanzheng();">
      <input type="hidden" name="key" id="key" value="<%=Common.getFormatStr(request.getParameter("key"))%>" />
      <input type="hidden" name="email" id="email" value="<%=Common.getFormatStr(request.getParameter("email"))%>" />
      <input type="hidden" name="code" id="code" value="<%=code%>" />
        <table width="98%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <th><font>*</font> 密码：</th>
            <td colspan="2" >
            <div style="clear:both"><input type="password" name="passw" id="passw" class="ri" onfocus="showText('passw')" onblur="formyanzheng('passw')" onkeyup="pwStrength(this.value)"/>
            <input type="text" id="passw_show" class="regi" onblur="formyanzheng('passw')" onkeyup="pwStrength(this.value)" style="display:none"/>
	    	<div class="qr">
              <ul>
                <li id="strength_L" class="">弱</li>
                <li id="strength_M" class="">中</li>
                <li id="strength_H" class="">强</li>
              </ul>
            </div>
            <div class="diu" id="passw_dui" style="display:none"></div>
            <div class="cuo" id="passw_cuo" style="display:none"></div>
            <div class="cuo1" id="passw_cuo_info" style="display:none"></div>
            </div>
            <div style="width:100%; float:left;">
              <div id="passw_show_info" style="display:none; width:100%; float:left;">6-16位字符，推荐使用字母、数字、"-"或"_"的组合</div>
            </div>
            </td>
          </tr>
          <tr>
            <th><font>*</font> 确认密码：</th>
            <td><input type="password" name="passw2" id="passw2" class="ri" onfocus="this.className='regiHover'" onblur="formyanzheng('passw2')" />
		<div class="diu" id="passw2_dui" style="display:none"></div>
            <div class="cuo" id="passw2_cuo" style="display:none"></div>
            <div class="cuo1" id="passw2_cuo_info" style="display:none"></div>
            </td>
          </tr>
          <tr>
            <th height="30">&nbsp;</th>
            <td><input type="button" onclick="Yanzheng();" name="regid" id="regid" value="提交密码" class="registBtn" /></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
  <div class="clear"></div>
</div>
<jsp:include page="/manage/foot_new.jsp" />
</body>
<script>
function Yanzheng(){
	var isOK = 0;
	if(!formyz('passw')){
		isOK = isOK+1;
	}
	if(!formyz('passw2')){
		isOK = isOK+1;
	}
	if(isOK == 0){
		jQuery("#theform").submit();
	}
}

function formyz(name){
	var obj = document.getElementById(name);
	var objDui = document.getElementById(name+"_dui");
	var objCuo = document.getElementById(name+"_cuo");
	var objCuoInfo = document.getElementById(name+"_cuo_info");	
	var objShow =document.getElementById(name+'_show_info'); 
	//移除提示
	if(typeof(objShow) != "undefined" && objShow != null)
	{
		objShow.style.display='none';
	}
	var mess = "";
	if(name=="passw"){
		if(obj.value.length==0) {
		   mess = "请输入密码";
		   jQuery("#passw").focus();
		 }else if(obj.value.length<4 || obj.value.length>18 ) {
		   mess = "长度应为4-18位";
		 }else if (obj.value.indexOf(" ")!=-1){
		   mess = "密码里不能含有空格";
		 }
	}else if(name=="passw2"){
		if(obj.value.length==0) {
		   mess = "请输入确认密码";
		 }else if(obj.value !=  document.getElementById("passw").value) {
		   mess = "两次输入的密码不相同";
		 }
	}
	if(mess==""){
	    objDui.style.display='block';
		objCuo.style.display = 'none';
		objCuoInfo.style.display = 'none';
		//alert(obj);
		if(name!="is_accept"){
			obj.className='ri';
		}
		return true;
	}else{
		objCuo.style.display = 'block';
		objCuoInfo.style.display = 'block';
		objCuoInfo.innerText = mess;
		objDui.style.display='none';
		if(name!="is_accept"){
			obj.className='ri';
		}
		return false;
	}

}
</script>
</html>
