<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" %><%
	response.setHeader("Pragma","No-cache"); 
	response.setHeader("Cache-Control","no-cache"); 
	response.setDateHeader("Expires", 0);
	String parentReferer = request.getHeader("Referer");
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String mem_no = "";
	String mem_name = "";
	String comp_name = "";
	String per_phone = "";
	String email = "";
	if(null!=memberInfo){
		mem_no = Common.getFormatStr(memberInfo.get("mem_no"));
		mem_name = Common.getFormatStr(memberInfo.get("mem_name"));
		comp_name = Common.getFormatStr(memberInfo.get("comp_name"));
		per_phone = Common.getFormatStr(memberInfo.get("per_phone"));
		email = Common.getFormatStr(memberInfo.get("per_email"));
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>注册</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script src="/scripts/jquery-1.4.1.min.js"  type="text/javascript"></script>
<script src="/scripts/jquery.form.js" type="text/javascript"></script>
<style>
html { overflow:hidden;}
</style>
</head>
<body style="overflow:hidden;">
<!--注册-->
<div class="C_layer registNew" style="width:100%;">
  <div class="C_title" style="margin:0;padding:0; display: none;">
    <h2><b>高级会员申请</b></h2>
  </div>
  <div class="C_content">
    <div class="registTable">
      <form action="/interface/login_and_regist/apply_action.jsp" method="post" name="theform" id="theform">
        <table width="98%" cellspacing="0" cellpadding="0" border="0">
          <tbody>
            <tr>
              <th width="18%"><font>*</font> 您的姓名：</th>
              <td width="82%"><input type="text" class="ri" id="mem_name" name=mem_name value="<%=mem_name %>" /></td>
            </tr>
            <tr>
              <th width="18%"><font>*</font> 公司名称：</th>
              <td width="82%"><input type="text" class="ri" id="comp_name" name="comp_name" value="<%=comp_name %>" /></td>
            </tr>
            <tr>
              <th width="18%"><font>*</font> 联系方式：</th>
              <td width="82%"><input type="text" class="ri" id="telephone" name="telephone" value="<%=per_phone %>" /></td>
            </tr>
            <tr>
              <th width="18%"><font>*</font> 联系邮箱：</th>
              <td width="82%"><input type="text" class="ri" id="email" name="email" value="<%=email %>" /></td>
            </tr>
            <tr>
              <th width="18%"><font>*</font> 申请说明：</th>
              <td width="82%">
              	<textarea class="ri" name="content" id="content" style="height:80px;"></textarea>
              </td>
            </tr>
            <tr>
              <th height="30">&nbsp;</th>
              <td><input type="button" style="background:url('/images/denglu5.gif');width:88px;height:34px;border:none;margin:0;padding:0;cursor:pointer;font-size:16px;font-weight:bold;" value="提 交" onclick="doSub();" id="regid" name="regid"></td>
            </tr>
          </tbody>
        </table>
        <input type="hidden" name="mem_no" value="<%=mem_no %>" />
        <input type="hidden" name="mem_name" value="<%=mem_name %>" />
        <input type="hidden" name="apply_mem_flag" value=<%=Common.getFormatStr(request.getParameter("apply_mem_flag")) %> />
         <input type="hidden" name="catalog_no" value=<%=Common.getFormatStr(request.getParameter("catalog_no")) %> />
      </form>
    </div>
  </div>
</div>
<div style="display:none;">
<form id="refParent" action="<%=parentReferer %>" target="_parent" method="post"><input id="refParentBtn" type="submit" /></form>
</div>
</body>
</html>
<script type="text/javascript">
	function doSub(){
		if(!va()){
			return;
		}
		jQuery("#theform").ajaxSubmit({
			type : "POST",
			success : function(rs){
				alert("您的申请已成功发送，请耐心等待回复，谢谢！");
				jQuery("#refParentBtn").click();		
			}
		});
	}
	function va(){
		var mem_name = jQuery("#mem_name").val();
		if(''==mem_name){
			alert("请输入您的姓名！");
			return false;
		}
		var comp_name = jQuery("#comp_name").val();
		if(''==comp_name){
			alert("请输入您的公司名称！");
			return false;
		}
		var telephone = jQuery("#telephone").val();
		if(''==telephone){
			alert("请输入您的联系方式");
			return false;
		}
		var email = jQuery("#email").val();
		if(''==email){
			alert("请填写您的邮箱！");
			return false;
		}
		var content = jQuery("#content").val();
		if(''==content){
			alert("请填写申请说明！");
			return false;
		}
		return true;
	}
</script>