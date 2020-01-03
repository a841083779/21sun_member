<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="/webadmin/manage/config.jsp"%>
<%
String catalog = Common.getFormatStr(request.getParameter("catalog"));

//===调租赁库====
if(pool == null){
	pool = new PoolManager();
}
Connection conn =null;

//=====页面属性====
String tablename="stock_blog";
String pageSubName="blog_opt.jsp?catalog="+catalog;

//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(10);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
 
StringBuffer query =new StringBuffer("select * from "+tablename+" where catalog=").append(catalog);

//作者
String find_author=Common.getFormatStr(request.getParameter("find_author"));
if(!find_author.equals("")){
	query.append(" and author like '%"+find_author+"%'");
}
/*标题*/ 
String find_title=Common.getFormatStr(request.getParameter("find_title"));
if(!find_title.equals("")){
	query.append(" and title like '%"+find_title+"%'");
}
/*内容*/
String find_content=Common.getFormatStr(request.getParameter("find_content"));
if(!find_content.equals("")){
	query.append(" and content like '%"+find_content+"%'");
}
/*内容*/
String find_date_s=Common.getFormatStr(request.getParameter("find_date_s"));
if(!find_date_s.equals("")){
	query.append(" and pub_date>= '"+find_date_s+"'");
}
/*内容*/
String find_date_e=Common.getFormatStr(request.getParameter("find_date_e"));
if(!find_date_e.equals("")){
	query.append(" and pub_date <= dateadd(day,1,'"+find_date_e+"')");
}
query.append(" order by pub_date desc");

System.out.println(query);
try{  

conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1);
String bar = pagination.pagesPrint(10); //读取分页提栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="/webadmin/style/style.css" rel="stylesheet" type="text/css" />
<script src="/webadmin/scripts/jquery-1.4.1.min.js"></script>
<script  src="/webadmin/scripts/common.js"  type="text/javascript"></script>
<script  src="/webadmin/scripts/calendar.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function batchDelete(){
		if(confirm("确定这样操作吗？")){
			document.theform.action = "tool.jsp";
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
select {/*解决样式冲突*/
	float:none;
}
-->

</style>
</head>
<body>
<form action="" method="get" name="theform" id="theform">
<input type="hidden" name="catalog" value="<%=catalog %>"/>
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td width="23%" class="p94b">&nbsp;</td>
            <td width="65%" align="center" nowrap="nowrap">
            作者：<input name="find_author" type="text" id="find_author" value="<%=find_author%>" size="10" />
                标题：<input name="find_title" type="text" id="find_title" value="<%=find_title%>"/>
			  内容：<input name="find_content" type="text" id="find_content" value="<%=find_content%>"/>
			  发布时间：<input name="find_date_s" type="text" id="find_date_s" value="<%=find_date_s%>" size="10" onfocus="calendar(event)"/>~<input name="find_date_e" type="text" id="find_date_e" value="<%=find_date_e%>" size="10" onfocus="calendar(event)"/>
			  <input type="submit" name="Submit" value="查询" />
			  <input type="button" name="Submit2" value="清空" onclick="javascript:clearForm()" />
              
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
			    <input type="button" id="hot" name="hot" value="批量删除" onclick="batchDelete();"/>
				<input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',800,600)"/>						  
		    </td>
			  
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
		    <td width="2%" height="30" align="center" bgcolor="e8f2ff">
			  <input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
			</td>
            <td width="2%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="30%" align="center" bgcolor="e8f2ff"><strong>标题</strong></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><strong>作者</strong></td>
            <td width="18%" align="center" bgcolor="e8f2ff"><div align="center"><strong>发布时间</strong></div></td>
            
            <td width="" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="6"></td>
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
            <td><%=Common.getFormatStr(rs.getString("title"))%></td>
            <td align="center"><%=Common.getFormatStr(rs.getString("author"))%></td>
            <td align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pub_date"))%></td>			
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>&myvalue=<%=rs.getString("id")%>','win',800,600)">修改</a></span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="6"><%=bar%></td>
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
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
