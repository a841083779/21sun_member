<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="../manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}

Connection conn =null;
	
//String tablename="member_info";
String tablename="admin_user";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" ");

query = query.append(" where 1=1 ");

//得到参数
String find_usern=Common.getFormatStr(request.getParameter("find_usern"));
if(!find_usern.equals("")){
	query.append(" and (usern like '%"+find_usern+"%' or realname like '%"+find_usern+"%' ) ");
}



try{
conn = pool.getConnection();
//SQL查询
ResultSet rs = pagination.getQueryResult(query.toString()+" order by id ", request,conn,1);
String bar = pagination.paginationPrint();  //读取分页提示栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理员管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>

<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style></head>
<body><%//=query.toString()+" order by id desc"%>
<form action="" method="get" name="theform" id="theform">
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="1%" class="title_bar">&nbsp;</td>
        <td width="81%" class="p94b"> 管理员名称：
          <input name="find_usern" type="text" id="find_usern" size="20" value="<%=find_usern%>" /></td>
        <td width="18%" class="p94b"><input type="submit" name="Submit" value="搜索" />
          <input type="button" name="Submit2" value="清除" onclick="javascript:clearForm()" /></td>
      </tr>
    </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
             <input type="button" name="b_add" value="增加" onclick="openWin('manager_opt.jsp','sell',450,300)"/>
           </td>
          </tr>
        </table>
       <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="4%" height="30" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="10%" nowrap="nowrap" bgcolor="e8f2ff"><strong>会员名</strong></td>
            <td width="11%" nowrap="nowrap" bgcolor="e8f2ff"><strong>密码</strong></td>
            <td width="19%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>注册日期</strong></td>
            <td width="5%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>状态</strong></td>
            <td width="16%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>最后登录时间</strong></td>
            <td width="13%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          
			<%
				int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
				while (rs!=null && rs.next()){
					k=k+1;
					
			%>
            <tr <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center" nowrap="nowrap"><%=k%></td>
            <td nowrap="nowrap">&nbsp;<a href="#" onclick="openWin('member_opt.jsp?myvalue=<%=rs.getString("id")%>','',750,600)"><%=Common.getFormatStr(rs.getString("realname"))%> ( <%=Common.getFormatStr(rs.getString("usern"))%> )</a></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("passw"))%></td>
			          
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></td>

           
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("state")).equals("1")?"有效":"<font color='red'>×</font>"%></td>
            <td nowrap="nowrap">&nbsp;<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("last_date"))%></td>
            <td align="center" nowrap="nowrap"><div align="center"><span class="p92j"><a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a>&nbsp;&nbsp; <a href="#" onclick="openWin('manager_opt.jsp?myvalue=<%=rs.getString("id")%>','',450,300)">修改</a></span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="10"><%=bar%></td>
          </tr>
      </table></td>
  </tr>
</table>
</form>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
