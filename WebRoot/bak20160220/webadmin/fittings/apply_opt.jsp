<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include
	file="../manage/config.jsp"%>
<%
	pool = new PoolManager(1);

	String apply_id = Common.getFormatStr(request.getParameter("apply_id"));
	String querySql = "select * from vi_member_info where apply_id=" + apply_id;
	Connection conn = null;
	ResultSet rs = null;
	try {
		conn = pool.getConnection();
		rs = DataManager.executeQuery(conn, querySql);
		if (rs != null && rs.next()) {
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>企业库申请修改</title>
		<link href="../style/style.css" rel="stylesheet" type="text/css" />
		<script src="../scripts/jquery-1.4.1.min.js"></script>
		<script type="text/javascript" src="/scripts/Validator.js"></script>
		<script type="text/javascript">
//为多选框赋值
function submityn(){
		var myFlag = Validator.Validate(document.getElementById("theform"),1);
		if(myFlag){
			var apply_id=$("#apply_id").val();
			var mem_no=$("#mem_no").val();
			var mem_name=$.trim($("#linkMan").val());
			var comp_name=$.trim($("#comName").val());
			var comp_address=$.trim($("#linkAddress").val());
			var per_phone=$.trim($("#phone").val());
			var per_email=$.trim($("#email").val());
			var content=$.trim($("#comDesc").val());
			var zhuying=$.trim($("#comzhuying").val());
			var province=$.trim($("#province").val());
			var city=$.trim($("#city").val());
			var status=0;
			if(document.getElementById("status_1").checked){
				status=1;
			}
			$.ajax({
				type:"post",
				url:"/webadmin/fittings/apply_tools.jsp",
				data:{action:"update",apply_id:apply_id,mem_no:mem_no,mem_name:mem_name,comp_name:comp_name,comp_address:comp_address,per_phone:per_phone,per_email:per_email,content:content,zhuying:zhuying,status:status,province:province,city:city},
				success:function(result){
					var msg=$.trim(result);
					if(msg=="1"){
						alert("修改成功");
						opener.location.reload();
					}else{
						alert("修改失败，请稍后重试");
					}
				}
			});
		}
}

</script>
	</head>
	<body>
		<table width="95%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td height="15">
					<span class="p982"><span class="pblue1"></span><font
						color="#FF0000">*</font><span class="pblue1">号为必填项</span>
					</span>
				</td>
			</tr>
		</table>
		<table width="95%" border="0" align="center" cellpadding="0"
			cellspacing="1" class="list_border_bg">
			<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
			<tr>
				<td align="right" nowrap class="list_left_title">
					公司名称：
				</td>
				<td class="list_cell_bg">
					<font color="#FF0000">*</font>
					<input name="comName" type="text" id="comName" size="60"
						maxlength="40" value="<%=Common.getFormatStr(rs.getString("comp_name")) %>" dataType="Require" msg="请输入公司名称" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					公司简介：
				</td>
				<td height="22" class="list_cell_bg">
					<font color="#FFFFFF">*</font>
					<textarea name="comDesc" id="comDesc"
						style="width: 500px; height: 350px;" dataType="Require" msg="请输入公司描述">
						<%=Common.getFormatStr(rs.getString("comp_intro")) %>
						</textarea>
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					主营业务：
				</td>
				<td height="22" class="list_cell_bg">
					<font color="#FFFFFF">*</font>
					<input type="text" id="comzhuying" name="comzhuying" size="60"
						maxlength="40" value="<%=Common.getFormatStr(rs.getString("comp_mainbusiness")) %>" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					公司地址：
				</td>
				<td height="22" class="list_cell_bg">
					<font color="#FF0000">*</font>
					<input type="text" id="linkAddress" name="linkAddress" size="60"
						maxlength="40" value="<%=Common.getFormatStr(rs.getString("comp_address")) %>" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					联系人：
				</td>
				<td height="22" class="list_cell_bg">
					<font color="#FF0000">*</font>
					<input type="text" id="linkMan" name="linkMan" size="20"
						maxlength="20" value="<%=Common.getFormatStr(rs.getString("mem_name")) %>" dataType="Require" msg="请输入联系人" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					所在地：
				</td>
				<td height="22" class="list_cell_bg">
					<font color="#FF0000">*</font>
					<input type="text" id="province" name="province" size="10" maxlength="10" value="<%=Common.getFormatStr(rs.getString("per_province")) %>" dataType="Require" msg="请输入省份" />省
					<input type="text" id="city" name="city" size="10" maxlength="10" value="<%=Common.getFormatStr(rs.getString("per_city")) %>" />市
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					联系电话：
				</td>
				<td height="22" class="list_cell_bg">
					<font color="#FF0000">*</font>
					<input type="text" id="phone" name="phone" size="20" maxlength="20" value="<%=Common.getFormatStr(rs.getString("per_phone")) %>" dataType="Custom" regexp="^(((\(\d{3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7})|(((\(\d{3}\))|(\d{3}\-))?1\d{10})" msg="请输入正确的电话" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					邮箱：
				</td>
				<td height="22" class="list_cell_bg">
					<font color="#FF0000">*</font>
					<input type="text" id="email" name="email" size="20" maxlength="20" value="<%=Common.getFormatStr(rs.getString("per_email")) %>" dataType="Email" require="false" msg="请输入正确的邮箱" />
				</td>
			</tr>
			<tr>
				<td height="22" align="right" nowrap class="list_left_title">
					是否审核：
				</td>
				<td height="22" class="list_cell_bg">
					<font color="#FF0000">*</font>
					<input type="radio" id="status_1" name="status" value="1" />
					<label for="status_1">
						已审核
					</label>
					&nbsp;&nbsp;
					<input type="radio" id="status_0" name="status" value="0" />
					<label for="status_0">
						未审核
					</label>
					<script type="text/javascript">
						$("#status_<%=Common.getFormatStr(rs.getString("status")) %>").attr("checked","true");
					</script>
				</td>
			</tr>
			<tr>
				<td height="30px" class="list_left_title" align="left" colspan="2">
					<div align="left">
						<input type="button" name="Submit" value="保存"
							onClick=submityn();>
						<input name="apply_id" type="hidden" id="apply_id" value="<%=apply_id %>" />
						<input type="hidden" id="mem_no" name="mem_no" value="<%=Common.getFormatStr(rs.getString("mem_no")) %>" />
					</div>
				</td>
			</tr>
			</form>
		</table>
		<table width="98%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td height="10"></td>
			</tr>
		</table>
	</body>
</html>
<%
	}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(conn);
	}
%>
