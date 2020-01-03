<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%><%
   pool = new PoolManager(7);
   Connection conn =null;
   String find_differ="";
	
String tablename="supply";
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(18);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
StringBuffer query =new StringBuffer("select id,title,clicked,collection_count,message_count,pubdate from "+tablename+" where 1=1 and mem_no= '").append(usern).append("' and  is_pause=1");
//StringBuffer query =new StringBuffer("select *,DateDiff(d,add_date,getdate())as differ from "+tablename+" where 1=1 and is_pub=1 and mem_no= '").append(usern).append("' ");
//得到参数
//out.print("query:===="+query.toString());
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}

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
  <div class="loginlist_right2"><span class="mainyh" style="width:260px;float:left">管理我的配件供应(已到期)</span><a href="supply_list.jsp" style="width:127px;height:27px;float:left;padding-top:5px"><img src="../images/zhengfabu2.gif" /></a></div><div class="loginlist_right2"><strong>"更新"</strong>操作将会使您的信息靠前显示;<strong>"暂停发布"</strong>功能将会使该条信息在前台暂不显示</div>
  <div class="loginlist_right1"><div style="width:100%;height:29px;padding:5px 0px;">
  <span class="title_bar st1"><input name="add_b" type="button" class="form_button" id="add_b" value="" style="width:78px;height:29px;border:none;background:url(../images/bottom03.gif) left top no-repeat;cursor: pointer;" onclick="window.location.href='supply_opt.jsp'" /></span></div>
    <table width="100%" border="0" class="list" style="margin-top:5px">
      <tr>		
        <th width="6%">ID</th>
        <th width="31%">标题</th>
        <th width="9%">浏览量</th>
        <th width="8%">收藏量</th>
        <th width="11%">新留言/累计</th>
        <th width="11%">更新日期</th>
        <th width="22%"><div align="center">操作</div></th>
      </tr>
<%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;   
%>		  
      <tr>
        <td><%=k%></td>
        <td><a href="supply_opt.jsp?myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>"><%=Common.getFormatStr(rs.getString("title"))%></a></td>
        <td><%=Common.getFormatInt(rs.getString("clicked"))%></td>
        <td><%=Common.getFormatInt(rs.getString("collection_count"))%></td>
        <td><%=Common.getFormatInt(rs.getString("message_count"))%></td>
        <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></td>
        <td><div align="center"><a href="javascript:otherDeleteData('../parts/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');"> 删除</a> &nbsp;&nbsp; <a href="supply_opt.jsp?myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>">修改</a>&nbsp;&nbsp;<a href="update_pubdate.jsp?mypy=<%=Common.encryptionByDES(tablename)%>&myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>&type=continue&urlpath=supply_list.jsp">重新发布</a></div></td>
      </tr>
<%
}rs.close();
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