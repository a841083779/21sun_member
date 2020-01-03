<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%
	HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>申请成为A类会员</title>
<link href="/plugin/validator/rjboy/validform.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/plugin/validator/rjboy/Validform_v5.3.1.js"></script>
<style type="text/css">
.postTable th,.postTable td { font-size:12px; font-weight:normal; vertical-align:top; padding:7px 0px 0px; line-height:22px;}
.postTable input.radio { vertical-align:-2px;}
.postTable th { text-align:right; font-weight:bold;}
.postTable th font { color:red;}
.postTable td { color:#777;}
.postTable td input.ri { width:230px; height:14px; line-height:14px; padding:3px; border:#ccc 1px solid; font-family:Verdana;}
.postTable td input.btn { width:60px; height:20px; cursor:pointer; color:#fff; background-color:#ff6600; border:none;}
</style>
</head>
<body>
<form name="theform" id="theform" style="padding-top:5px;" action="/market/member_apply.jsp" >
  <table border="0" cellspacing="0" cellpadding="0" width="520" class="postTable">
    <tr>
      <th width="88"><font>*</font>联系人：</th>
      <td width="432"><input type="text" id="zd_mem_name" name="zd_mem_name" class="ri" value="<%=Common.getFormatStr(memberInfo.get("mem_name"))%>" datatype="*" errormsg="不能为空！" maxlength="30" /></td>
    </tr>
    <tr>
      <th width="88"><font>*</font>联系电话：</th>
      <td width="432"><input type="text" id="zd_telephone" name="zd_telephone" class="ri" value="<%=Common.getFormatStr(memberInfo.get("per_phone"))%>" datatype="*" errormsg="不能为空！" maxlength="30" /></td>
    </tr>
    <tr>
      <th width="88"><font>*</font>Email：</th>
      <td width="432"><input type="text" id="zd_email" name="zd_email" class="ri" value="<%=Common.getFormatStr(memberInfo.get("per_email"))%>" datatype="*" errormsg="不能为空！" maxlength="30" /></td>
    </tr>
    <tr>
      <th width="88"><font>*</font>优惠券号码：</th>
      <td width="432"><input type="text" id="zd_youhui_num" name="zd_youhui_num" class="ri" maxlength="6" value="<%=Common.getFormatStr(memberInfo.get("randNum"))%>" /></td>
    </tr>
    <tr>
      <th width="88">留言：</th>
      <td width="432"> <textarea name="zd_content" id="zd_content" cols="45" rows="3"></textarea></td>
    </tr>
    <tr>
    	<td align="center" colspan="2"><input type="submit" id="" name="" class="btn" value="提交" /></td>
    </tr>
  </table>
  <input type="hidden" id="zd_mem_no" name="zd_mem_no" value="<%=Common.getFormatStr(memberInfo.get("mem_no")) %>" />
  <input name="zd_comp_name" type="hidden" id="zd_comp_name" value="<%=Common.getFormatStr(memberInfo.get("comp_name"))%>" />
</form>
</body>
</html>
<script language="javascript" type="text/javascript">
	$(function(){
				$("#theform").Validform({
					tiptype:4,
					ajaxPost:true,
					callback:function(result){
						if($.trim(result)=="1"){
							alert('申请已提交成功,我们将尽快与您取得联系，先发布产品信息吧!');
							parent.$.jBox.close();
						}else{
							alert('申请已提交成功,我们将尽快与您取得联系，先发布产品信息吧!');
							parent.$.jBox.close();
						}	
					}
				});
			});
</script>