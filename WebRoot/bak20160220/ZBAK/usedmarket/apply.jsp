<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>高级会员申请</title>
	<script src="/scripts/jquery-1.4.1.min.js"></script>
  </head>
  
  <body style="margin: 0;padding: 0;">
  <form action="tools/action_apply.jsp" name="theform" id="theform" method="post">
    <table cellpadding="5" cellspacing="5" style="margin-left: 15px;">
    	<tr>
    		<td style="font-size: 12px;">您的称呼？</td>
    		<td>
    			<input type="text" style="border: 1px solid #ccc;" name="name" dataType="Require" msg="请填写您的称呼！" />
    		</td>
    	</tr>
    	<tr>
    		<td style="font-size: 12px;">您的邮箱？</td>
    		<td><input type="text" style="border: 1px solid #ccc;" name="email" dataType="Require" msg="请填写您的邮箱！" /></td>
    	</tr>
    	<tr>
    		<td style="font-size: 12px;">联系方式？</td>
    		<td><input type="text" style="border: 1px solid #ccc;" name="contact" dataType="Require" msg="请填写您的联系方式！" /></td>
    	</tr>
    	<tr>
    		<td style="font-size: 12px;">申请说明？</td>
    		<td style="font-size: 12px;">
    			<textarea style="width: 200px; height: 80px; border:1px solid #ccc;" name="intro"></textarea>
    		</td>
    	</tr>
    </table>
    </form>
  </body>
</html>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/validator/wofoshan/validator.min.js"></script>
<script type="text/javascript">
	function doSub(){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery("#theform").ajaxSubmit({
				async : false ,
				success : function(d){
					if(jQuery.trim(d)=='ok'){
						alert("您的申请已经成功发送！");
					}
					parent.jBox.close();
				}
			});
		}
		return rs;
	}
</script>