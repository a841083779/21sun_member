<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
pool = new PoolManager(9);
Connection conn =null;
String tablename="fittings_data_basic_sub";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1  ");
//得到参数
String find_mem_no=Common.getFormatStr(request.getParameter("find_mem_no"));
if(!find_mem_no.equals("")){
	query.append(" and mem_no ='"+find_mem_no+"'");
}
//得到参数
String find_comp_name=Common.getFormatStr(request.getParameter("find_comp_name"));
if(!find_comp_name.equals("")){
	query.append(" and comp_name like'%"+find_comp_name+"%'");
}

int intYearStart = Integer.parseInt(Common.getFormatInt(request.getParameter("yearStart")));
int intMonthStart = Integer.parseInt(Common.getFormatInt(request.getParameter("monthStart")));
int intYearEnd = Integer.parseInt(Common.getFormatInt(request.getParameter("yearEnd")));
int intMonthEnd = Integer.parseInt(Common.getFormatInt(request.getParameter("monthEnd")));
if(intYearStart!=0){
	query.append(" and year >="+intYearStart+" ");
}
if(intMonthStart!=0){
	query.append(" and month >="+intMonthStart+" ");
}
if(intYearEnd!=0){
	query.append(" and year <="+intYearEnd+" ");
}
if(intMonthEnd!=0){
	query.append(" and month <="+intMonthEnd+" ");
}

try{
	conn = pool.getConnection();
	//SQL查询	
	ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
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
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function setFlag(flag){
		if(confirm("确定这样操作吗？")){
			theform.action = "tool.jsp?flag="+flag;
			theform.target = "hiddenFrame";
			theform.method = "post";
			theform.submit();
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
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td width="11%" class="p94b">&nbsp;</td>
            <td width="77%" align="center" nowrap="nowrap"><span class="title1">会员编号：
              <input name="find_mem_no" type="text" id="find_mem_no" value="<%=find_mem_no%>" size="15" maxlength="15" />
              </span>
			  <span class="title1">企业名称：
              <input name="find_comp_name" type="text" id="find_comp_name" value="<%=find_comp_name%>" size="15" maxlength="15" />
              </span>
              年月从
              <select id="yearStart" name="yearStart">
				<option value="">-请选择年份-</option>
				<%
					for(int i=2005;i<=2014;i++){
				%>
				<option value="<%=i%>" <%if(i==intYearStart){%> selected="selected"<%}%>><%=i%>年</option>
				<%
					}
				%>
			</select>
			<select id="monthStart" name="monthStart">
				<option value="">-请选择月份-</option>
				<%
					for(int i=1;i<=12;i++){
				%>
				<option value="<%=i%>" <%if(i==intMonthStart){%> selected="selected"<%}%>><%=i%>月</option>
				<%
					}
				%>
			</select>
              ~
              <select id="yearEnd" name="yearEnd">
				<option value="">-请选择年份-</option>
				<%
					for(int i=2005;i<=2014;i++){
				%>
				<option value="<%=i%>" <%if(i==intYearEnd){%> selected="selected"<%}%>><%=i%>年</option>
				<%
					}
				%>
			</select>
			<select id="monthEnd" name="monthEnd">
				<option value="">-请选择月份-</option>
				<%
					for(int i=1;i<=12;i++){
				%>
				<option value="<%=i%>" <%if(i==intMonthEnd){%> selected="selected"<%}%>><%=i%>月</option>
				<%
					}
				%>
			</select>
              <input type="submit" name="Submit" value="搜索"  />
              <input type="button" name="Submit2" value="清空"  onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="1%" height="30" align="center" bgcolor="e8f2ff"><!--<input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />-->
            </td>
            <td width="10%" bgcolor="e8f2ff"><strong>年月</strong></td>
            <td width="20%" bgcolor="e8f2ff"><strong>配件类型</strong></td>
            <td width="12%" bgcolor="e8f2ff"><strong>国内销量</strong></td>
            <td width="10%" bgcolor="e8f2ff"><strong>出口量</strong></td>
			<td width="20%" bgcolor="e8f2ff"><strong>配套厂家</strong></td>
			<td width="14%" bgcolor="e8f2ff"><strong>销售代理商数量</strong></td>
			<td width="14%" bgcolor="e8f2ff"><strong>企业名称(帐号)</strong></td>
          </tr>
          <tr>
            <td height="6" colspan="5"></td>
          </tr>
          <%
			 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
			 while (rs!=null && rs.next()){
			   k=k+1;
		  %>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center">
				<!--<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />-->
            </td>
            <td><%=Common.getFormatStr(rs.getString("year"))%>年<%=Common.getFormatStr(rs.getString("month"))%>月</td>
            <td><%=Common.getFormatStr(rs.getString("part_type"))%></td>
            <td><%=Common.getFormatStr(rs.getString("sale_china"))%></td>
			<td><%=Common.getFormatStr(rs.getString("sale_abroad"))%></td>
			<td><%=Common.getFormatStr(rs.getString("fittings_company"))%></td>
			<td><%=Common.getFormatStr(rs.getString("fittings_agent_count"))%></td>
			<td><a href="../member/member_opt.jsp?mem_no=<%=Common.getFormatStr(rs.getString("mem_no"))%>" target="_blank"><%=Common.getFormatStr(rs.getString("comp_name"))%>(<%=Common.getFormatStr(rs.getString("mem_no"))%>)</a></td>
          </tr>
        <%
			}
		%>
          <tr >
            <td height="30" colspan="5"><%=bar%></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
<iframe name="hiddenFrame" style="display:none"></iframe>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
