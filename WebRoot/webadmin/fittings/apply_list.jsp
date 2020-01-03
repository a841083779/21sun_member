<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%@ include
	file="../manage/config.jsp"%>
<%
	pool = new PoolManager(1);
	Connection conn = null;
	String tablename = "vi_member_info";

	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(30);
	//分页中当前记录
	String offset = Common.getFormatStr(request.getParameter("offset"));
	if (offset.equals("")) {
		offset = "0";
	}

	StringBuffer query = new StringBuffer("select * from " + tablename + " where apply_date is not null and apply_catalog='fittings_complib' ");
	//得到参数
	String comp_name = Common.getFormatStr(request.getParameter("comp_name"));
	if (!comp_name.equals("")) {
		query.append(" and comp_name like '%" + comp_name + "%'");
	}
	String find_mem_no = Common.getFormatStr(request.getParameter("find_mem_no"));
	if (!find_mem_no.equals("")) {
		query.append(" and mem_no like '%" + find_mem_no + "%'");
	}
	try {
		conn = pool.getConnection();
		//SQL查询	
		ResultSet rs = pagination.getQueryResult(query.toString(), request, conn, 2);
		//String bar = pagination.paginationPrint();  //读取分页提示栏
		String bar = pagination.pagesPrint(10); //读取分页提栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<link href="../style/style.css" rel="stylesheet" type="text/css" />
		<script src="../scripts/jquery-1.4.1.min.js"></script>
		<script src="../scripts/common.js" type="text/javascript"></script>
		<script src="../scripts/calendar.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
	function setFlag(flag){
		if(confirm("确定这样操作吗？")){
			document.theform.action = "apply_tools.jsp?action=batch&flag="+flag+"&tableName=member_applyonline";
			document.theform.target = "hiddenFrame";
			document.theform.method = "post";
			document.theform.submit();
		}
	}
	
	function deleteApply(id){
		if(confirm("确认要删除吗？")){
			document.theform.action="apply_tools.jsp?action=del&apply_id="+id+"&tableName=member_applyonline";
			document.theform.target = "hiddenFrame";
			document.theform.method = "post";
			document.theform.submit();
		}
	}
</script>
		<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style>
	</head>
	<body>
		<form action="" method="get" name="theform" id="theform">
			<table width="95%" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td valign="top">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="1%" class="title_bar">
									&nbsp;
								</td>
								<td width="23%" class="p94b">
									&nbsp;
								</td>
								<td width="65%" align="center" nowrap="nowrap">
									<span class="title1">会员编号： <input name="find_mem_no"
											type="text" id="find_mem_no" value="<%=find_mem_no%>"
											size="15" maxlength="15" /> </span>企业名称：
									<input name="comp_name" type="text" id="comp_name" size="15"
										value="<%=comp_name%>" />
									<input type="submit" name="Submit" value="搜索" />
									<input type="button" name="Submit2" value="清空"
										onclick="javascript:clearForm()" />
								</td>
								<td width="18%" align="right" class="title_bar">
									&nbsp;
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td height="15">
									<input type="button" name="b_add" value="增加"
										onclick="openWin('agent_opt.jsp','sell',650,600)" />
								</td>
							</tr>
							<tr style="padding-top: 10px">
								<td>
									<input type="button" id="hot" name="hot" value="批量删除"
										onclick="setFlag(0);" />
									<input type="button" id="rec_c" name="rec_c" value="批量审核"
										onclick="setFlag(1);" />
									<input type="button" id="rec_c" name="rec_c" value="取消审核"
										onclick="setFlag(2);" />
								</td>
							</tr>
						</table>
						<table width="98%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="1%" height="30" align="center" bgcolor="e8f2ff">
									<input type="checkbox" id="checkall" name="checkall"
										onclick="CheckAll();" />
								</td>
								<td width="5%" height="30" align="center" bgcolor="e8f2ff">
									<strong>ID</strong>
								</td>
								<td width="12%" align="center" bgcolor="e8f2ff">
									<div align="center">
										<span class="p92z"><strong>发布人帐号</strong>
										</span>
									</div>
								</td>
								<td width="30%" bgcolor="e8f2ff">
									<strong>公司名称</strong>
								</td>
								<td width="10%" bgcolor="e8f2ff">
									<strong>联系人</strong>
								</td>
								<td width="10%" bgcolor="e8f2ff">
									<strong>申请时间</strong>
								</td>
								<td width="9%" align="center" bgcolor="e8f2ff">
									<div align="center">
										<span class="p92z"><strong>状态</strong>
										</span>
									</div>
								</td>
								<td width="16%" align="center" bgcolor="e8f2ff">
									<div align="center">
										<span class="p92z"><strong>操作</strong>
										</span>
									</div>
								</td>
							</tr>
							<tr>
								<td height="6" colspan="5"></td>
							</tr>
							<%
								int k = pagination.getCurrenPages() * pagination.getCountOfPage() - pagination.getCountOfPage();
									while (rs != null && rs.next()) {
										k = k + 1;
							%>
							<tr <%=(k % 2) == 1 ? "bgcolor='#F9F9F9'" : ""%>>
								<td height="30" align="center">
									<input type="checkbox" id="checkdel" name="checkdel"
										value="<%=Common.getFormatStr(rs.getString("apply_id"))%>" />
								</td>
								<td height="30" align="center"><%=k%></td>
								<td>
									<%=Common.getFormatStr(rs.getString("mem_no"))%>
								</td>
								<td title="点击预览">
									<a href="http://www.21peitao.com/enterprise/detail.jsp?mem_no=<%=Common.encryptionByDES(Common.getFormatStr(rs.getString("mem_no"))) %>" target="_blank">
										<%=Common.getFormatStr(rs.getString("comp_name")) %>
									</a>
								</td>
								<td><%=Common.getFormatStr(rs.getString("mem_name")) %></td>
								<td><%=Common.getFormatDate("yyyy-MM-dd", rs.getDate("apply_date"))%></td>
								<td align="center">
									<div align="center">
										<span class="p92j"><%=Common.getFormatStr(rs.getString("status")).equals("1") ? "发布中" : "待审核"%></span>
									</div>
								</td>
								
								
								<td align="center">
									<div align="center">
										<span class="p92j">
										<a href="#"
											onclick="openWin('apply_opt.jsp?apply_id=<%=Common.getFormatStr(rs.getString("apply_id")) %>','sell',650,600)">修改</a>&nbsp;&nbsp; 
										<a href="#" onclick="deleteApply(<%=Common.getFormatStr(rs.getString("apply_id")) %>)">删除</a>
										</span>
									</div>
								</td>
							</tr>
							<%
								}
							%>
							<tr>
								<td height="30" colspan="5"><%=bar%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<iframe name="hiddenFrame" style="display: none"></iframe>
	</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(conn);
	}
%>