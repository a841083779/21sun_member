<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%pool = new PoolManager(1);

Connection conn =null;
	
String tablename="webypage";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(18);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1   and mid= '").append(usern).append("' ");
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and corporation like '%"+title+"%'");
}


//System.out.println(query);
try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.paginationPrint();  //读取分页提示栏
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">管理企业名录</span></div>
  <div class="loginlist_right1"><span class="title_bar">
    <input name="add_b" type="button" class="form_button" id="add_b" value="" style="width:78px;height:25px;border:none;background:url(../images/bottom03.gif) left top no-repeat;cursor: pointer;" onclick="window.location.href='company_opt.jsp'" />
    </span>
    <table width="100%" border="0" class="list">
      <tr>
        <th width="4%">ID</th>
        <th>公司名称</th>
        <th width="15%">发布日期</th>
        <th width="10%">联系电话</th>
        <th width="10%">传真</th>
        <th width="15%">　操作</th>
      </tr>
<%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;

%>		  
      <tr>
        <td><%=k%></td>
        <td><a href="company_opt.jsp?id=<%= Common.getFormatStr(rs.getString("id")) %>" class="blue14"><%=Common.getFormatStr(rs.getString("corporation"))%></a></td>
        <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("regts"))%></td>
        <td>　<%=Common.getFormatInt(rs.getString("telephone"))%></td>
        <td>　<%=Common.getFormatInt(rs.getString("fax"))%></td>
        <td><a href="javascript:otherDeleteData('../join/opt_delete.jsp','<%=Common.encryptionByDES(Common.getFormatStr(rs.getString("id")))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; 
        <a href="company_opt.jsp?id=<%= Common.getFormatStr(rs.getString("id")) %>">修改</a></td>
      </tr>
<%
}
%>
    </table>
	 <table width="100%" border="0" class="list">
	   
	   <tr>
	     <td align="left"><%out.println(pagination.pagesPrint(8));%></td>
       </tr>
    </table>
  </div></div>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
