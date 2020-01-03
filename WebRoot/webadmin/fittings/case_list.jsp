<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="../manage/config.jsp"%><%
pool = new PoolManager(9);
Connection conn =null;
String tablename="fittings_member_info_case";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
//服务案例
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 ");
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}
 String find_mem_no=Common.getFormatStr(request.getParameter("find_mem_no"));
if(!find_mem_no.equals("")){
	query.append(" and mem_no like '%"+find_mem_no+"%'");
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
			theform.action = "tool.jsp?flag="+flag+"&tableName=<%=tablename%>";
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
</style></head>
<body>
<form action="" method="get" name="theform" id="theform">
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td width="23%" class="p94b">&nbsp;</td>
            <td width="65%" align="center" nowrap="nowrap"> <span class="title1">会员编号：
                <input name="find_mem_no" type="text" id="find_mem_no" value="<%=find_mem_no%>" size="15" maxlength="15" />
            </span>标题：
              <input name="title" type="text" id="title" size="15" value="<%=title%>" />
                <input type="submit" name="Submit" value="搜索"  />
                <input type="button" name="Submit2" value="清空"  onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
          <table width="100%"  border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td height="15"><input type="button" name="b_add" value="增加" onclick="openWin('case_opt.jsp','sell',650,600)"/>
				</td>
            </tr>
			<tr style="padding-top:10px">
				<td>
					<input type="button" id="hot" name="hot" value="批量删除" onclick="setFlag(0);"/>
				</td>
			</tr>
          </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
            <tr>
			  <td width="1%" height="30" align="center" bgcolor="e8f2ff">
			  	<input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
			  </td>
              <td width="5%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
			  <td width="30%" bgcolor="e8f2ff"><strong>标题</strong></td>
			  <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>会员帐号</strong></span></div></td>
              <td width="16%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
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
			  	<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />
			  </td>
              <td height="30" align="center"><%=k%></td>
			  <td><a href="#" onclick="openWin('case_opt.jsp?myvalue=<%=rs.getString("id")%>','sell',650,600)"><%=Common.getFormatStr(rs.getString("title"))%></a></td>
			  <td><a href="../member/member_opt.jsp?mem_no=<%=Common.getFormatStr(rs.getString("mem_no"))%>" target="_blank"><%=Common.getFormatStr(rs.getString("mem_no"))%></a></td>
              <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../fittings/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('case_opt.jsp?myvalue=<%=rs.getString("id")%>','sell',650,600)">修改</a></span></div></td>
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
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
