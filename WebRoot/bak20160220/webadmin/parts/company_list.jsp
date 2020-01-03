<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%@ include
	file="/manage/config.jsp"%>
<%
	pool = new PoolManager(7);

Connection conn =null;
	
String tablename="part_company_info";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 ");

String comp_name=Common.getFormatStr(request.getParameter("comp_name"));
if(!comp_name.equals("")){
	query.append(" and comp_name like '%"+comp_name+"%'");
}
String mem_no=Common.getFormatStr(request.getParameter("mem_no"));
if(!mem_no.equals("")){
	query.append(" and mem_no='"+mem_no+"'");
}
String mem_name=Common.getFormatStr(request.getParameter("mem_name"));
if(!mem_name.equals("")){
	query.append(" and mem_name='"+mem_name+"'");
}
String mem_flag=Common.getFormatStr(request.getParameter("mem_flag"));
if(!mem_flag.equals("")){
	query.append(" and mem_flag='"+mem_flag+"'");
}

try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.pagesPrint(10);  //读取分页提示栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>配件产品分类管理</title>
		<link href="../style/style.css" rel="stylesheet" type="text/css" />
		<script src="../scripts/jquery-1.4.1.min.js"></script>
		<script src="../scripts/common.js" type="text/javascript"></script>
		<script src="../scripts/calendar.js" type="text/javascript"></script>
		<script>
//ajax删除
function deleteData(id,tablename){
	if(confirm("您确认要删除吗？")){
	var url="opt_delete.jsp?mypy="+encodeURIComponent(tablename)+"&myvalue="+encodeURIComponent(id);
		$.ajax({
			   url: url,
			   type: 'POST',
			   dataType: 'html',
			   timeout: 1000,
		       error: function(){
                 alert('执行错误!');
               },
              success: function(html){document.location.reload();
               //$(".flexme1").flexReload();
			   //alert('删除成功!');
				//document.location.reload();
              }
           });
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
			<table width="100%" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td valign="top">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="1%" class="title_bar">
									&nbsp;
								</td>
								<td class="p94b">
									公司名称：
									<input name="comp_name" type="text" id="comp_name" size="15" value="<%=comp_name %>" />
									会员编号：
									<input name="mem_no" type="text" id="mem_no"
										size="10" value="<%=mem_no%>" onFocus="calendar(event)" />
									联系人：
									<input name="mem_name" type="text" id="mem_name"
										size="10" value="<%=mem_name%>" onFocus="calendar(event)" />
									会员类型：
									<select name="mem_flag" id="mem_flag">
										<option value="">请选择会员类型</option>
									<%
										PoolManager pool2=new PoolManager(1);
										Connection conn2=null;
										ResultSet rs2=null;
										String sql2="select * from [member_role] where role_num in (1003,-1,1010,1011)";
										try{
											conn2=pool2.getConnection();
											rs2=DataManager.executeQuery(conn2,sql2);
											while(rs2!=null&&rs2.next()){
												if(Common.getFormatStr(rs2.getInt("role_num")).equals(mem_flag)){
									%>
										<option value="<%=Common.getFormatStr(rs2.getString("role_num")) %>" selected="selected"><%=Common.getFormatStr(rs2.getString("role_name")) %></option>
									<%				
												}else{
									%>
										<option value="<%=Common.getFormatStr(rs2.getString("role_num")) %>"><%=Common.getFormatStr(rs2.getString("role_name")) %></option>
									<%				
												}
											}
										}catch(Exception e){
											e.printStackTrace();
										}finally{
											rs2=null;
											pool2.freeConnection(conn2);
										}
									%>
									</select>
									<input type="submit" name="Submit" value="查询" />
									<input type="button" name="b_clear" value="清空"
										onclick="javascript:clearForm()" />
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td height="15">
									<input type="button" name="b_add" value="增加"
										onclick="openWin('company_opt.jsp','region',650,600)" />
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="5%" height="30" align="center" bgcolor="e8f2ff">
									<strong>ID</strong>
								</td>
								<td width="10%" bgcolor="e8f2ff">
									<strong>会员编号</strong>
								</td>
								<td width="10%" align="center" bgcolor="e8f2ff">
									<div align="center">
										<strong>会员姓名</strong>
									</div>
								</td>
								<td width="10%" align="center" bgcolor="e8f2ff">
									<div align="center">
										<strong>联系电话</strong>
									</div>
								</td>
								<td width="30%" align="center" bgcolor="e8f2ff">
									<strong>公司名称</strong>
								</td>
								<td width="20%" align="center" bgcolor="e8f2ff">
									<strong>会员级别</strong>
								</td>
								<td width="15%" align="center" bgcolor="e8f2ff">
									<div align="center">
										<strong><span class="p92z">操作</span>
										</strong>
									</div>
								</td>
							</tr>
							<tr>
								<td height="6" colspan="11"></td>
							</tr>
							<%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;

%>
							<tr <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
								<td height="30" align="center"><%=k%></td>
								<td><%=Common.getFormatStr(rs.getString("mem_no"))%></td>
								<td align="center">
									<div align="center"><%=Common.getFormatStr(rs.getString("mem_name")) %></div>
								</td>
								<td align="center">
									<div align="center"><%=Common.getFormatStr(rs.getString("per_phone")) %></div>
								</td>
								<td align="left"><%=Common.getFormatStr(rs.getString("comp_name"))%></td>
								<td align="left"><%=Common.getFormatStr(rs.getString("mem_flag_name"))%></td>
								<td align="center">
									<div align="center">
										<span class="p92j"><a
											href="javascript:otherDeleteData('../parts/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a>
											&nbsp;&nbsp; <a href="#"
											onclick="openWin('company_opt.jsp?myvalue=<%=rs.getString("id")%>','region',650,600)">修改</a>
										</span>
									</div>
								</td>
							</tr>
							<%
}
%>
							<tr>
								<td height="30" colspan="11"><%=bar%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
