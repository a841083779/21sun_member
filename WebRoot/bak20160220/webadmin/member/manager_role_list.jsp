<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.net.* "
	%><%@ include file ="../manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
	
String tablename="manager_role";

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


try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString()+" order by role_num ", request,conn,1);
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
        <td width="23%" class="p94b">&nbsp;</td>
        <td width="65%" align="center" nowrap="nowrap"><input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />        </td>
        <td width="18%" align="right" class="title_bar">&nbsp;</td>
      </tr>
    </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
              <input type="button" name="b_add" value="增加" onclick="openWin('manager_role_opt.jsp','sell',450,300)"/>
            <a href="to_html.jsp" target="_blank"></a></td>
          </tr>
        </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="7%" height="26" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="22%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>会员编号</strong></td>
            <td width="24%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>角色名称</strong></td>
            <td width="24%" align="center" nowrap="nowrap" bgcolor="e8f2ff"><strong>操作</strong></td>
          </tr>
          
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;

%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center" nowrap="nowrap"><%=k%></td>
            <td align="center" nowrap="nowrap">&nbsp;<%=Common.getFormatStr(rs.getString("role_num"))%></td>
            <td align="center" nowrap="nowrap"><%=Common.getFormatStr(rs.getString("role_name"))%></td>
            <td align="center" nowrap="nowrap"><span class="p92j"><a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('manager_role_opt.jsp?myvalue=<%=rs.getString("id")%>','member',450,300)">修改</a> &nbsp;&nbsp; <a href="#" onclick="openWin('manager_role_purview_opt.jsp?role_num=<%=rs.getString("role_num")%>&name=<%=URLEncoder.encode(rs.getString("role_name"),"utf-8")%>','member',450,300)">设定权限</a></span></td>
          </tr>
          <%
}
%>
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
