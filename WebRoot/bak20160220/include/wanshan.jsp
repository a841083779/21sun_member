<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%
	HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>完善资料，开通店铺</title>
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
<form name="theform" id="theform" style="padding-top:5px;" action="/tools/ajax.jsp?flag=updMem" >
  <table border="0" cellspacing="0" cellpadding="0" width="520" class="postTable">
    <tr>
      <th width="88"><font>*</font>主营产品：</th>
      <td width="432"><input type="text" id="zd_main_product" name="zd_main_product" class="ri" value="<%=Common.getFormatStr(memberInfo.get("main_product"))%>" datatype="*" errormsg="请输入主营产品！" maxlength="100" /></td>
    </tr>
    <tr>
      <th style="padding:0px;"></th>
      <td style="padding:0px;">请至少输入一项贵公司主营产品，如：发动机，液压泵，底盘件</td>
    </tr>
    <tr>
      <th><font>*</font>详细地址：</th>
      <td><input type="text" class="ri" id="zd_comp_address" name="zd_comp_address" value="<%=Common.getFormatStr(memberInfo.get("comp_address")) %>" datatype="*" errormsg="请输入详细地址！" maxlength="100"/></td>
    </tr>
    <tr>
      <th style="padding:0px;"></th>
      <td style="padding:0px;">如：山东烟台莱山区同和路26号</td>
    </tr>
    <tr>
      <th></th>
      <td>
      <input class="radio" type="radio" id="zd_is_shop" name="zd_is_shop" value="1" checked="checked" />开通店铺
      </td>
    </tr>    
    <tr>
    	<td align="center" colspan="2"><input type="submit" id="" name="" class="btn" value="提交" /></td>
    </tr>
  </table>
  <input type="hidden" id="mem_no" name="mem_no" value="<%=Common.getFormatStr(memberInfo.get("mem_no")) %>" />
  <input type="hidden" id="passw" name="passw" value="<%=Common.getFormatStr(memberInfo.get("passw")) %>" />
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
							parent.showStep3();
							parent.$.jBox.close();
						}else{
							parent.showStep3();	
							parent.$.jBox.close();
						}
					}
				});
			});
</script>