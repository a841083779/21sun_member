<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
	
String tablename="exhibition_industry";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
String sow_id = Common.getFormatStr(request.getParameter("show_id"));
String show_id_d =  Common.getFormatStr(request.getParameter("show_id_d"));
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1  ");
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and txtTitle like '%"+title+"%'");
}
String zd_txtPosition= Common.getFormatStr(request.getParameter("zd_txtPosition"));
if(zd_txtPosition!=null&&!zd_txtPosition.equals(""))
{
	query.append(" and  txtPosition = " + zd_txtPosition + " ");
	
}
try{
conn = pool.getConnection();
if(!sow_id.equals("")){
	String upsql = "update "+tablename+" set showid=1 where id='"+sow_id+"'";
	int rec = DataManager.dataOperation(conn,upsql);
}
if(!show_id_d.equals("")){
	String upsql = "update "+tablename+" set showid=0 where id='"+show_id_d+"'";
	int rec = DataManager.dataOperation(conn,upsql);
}
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.paginationPrint();  //读取分页提示栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="scripts/jquery-1.4.1.min.js"></script>
<script  src="scripts/common.js"  type="text/javascript"></script>
<script type="text/javascript">
function show(id){
	document.getElementById('show_id').value=id;
	document.forms[0].submit();
}
function showd(id){
	document.getElementById('show_id_d').value=id;
	document.forms[0].submit();
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
  <input type=hidden name="show_id" id="show_id" value=""/>
  <input type=hidden name="show_id_d" id="show_id_d" value=""/>
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
    
    <td valign="top">
    <table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="1%" class="title_bar">&nbsp;</td>
        <td width="23%" class="p94b">&nbsp;</td>
        <td width="65%" align="center" nowrap="nowrap"> 标题：
          <input name="title" type="text" id="title" size="15" value="<%=title%>" />
          类型：<select name="zd_txtPosition" id="zd_txtPosition">
			 	<option value="">全部类型</option>
         		<option value="1" <%if(zd_txtPosition.equals("1"))out.print("selected");%>>首页展会推荐</option>
          		<option value="2" <%if(zd_txtPosition.equals("2"))out.print("selected");%>>首页重点展会推荐</option>
          		<option value="3" <%if(zd_txtPosition.equals("3"))out.print("selected");%>>列表页展会推荐</option>
        	</select>
          <input type="submit" name="Submit" value="查询" />
          <input type="button" name="Submit2" value="清空"  onclick="javascript:clearForm()" />
        </td>
        <td width="18%" align="right" class="title_bar">&nbsp;</td>
      </tr>
    </table>
    <table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="15"><input type="button" name="b_add" value="增加" onclick="openWin('exhibition_opt.jsp','sell',650,600)"/>
        </td>
      </tr>
    </table>
    <table width="98%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="5%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
        <td  bgcolor="e8f2ff" align="left"><strong>展会名称</strong></td>
        <td  bgcolor="e8f2ff" align="center">
        <strong>参展时间</strong>
      </td>
      
      <td width="6%" bgcolor="e8f2ff" align="center">
      <strong>是否发布</strong>
      </td>
      <td width="6%" bgcolor="e8f2ff" align="center">
      <strong>推荐</strong>
      </td>      
      <td width="14%"  bgcolor="e8f2ff" align="center">
      <strong>操作</strong>
      </td>
      
      </tr>
      
      <tr>
        <td height="6" colspan="5"><!----></td>
      </tr>
      <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
   String txtPosition = Common.getFormatStr(rs.getString("txtPosition"));
   String txtPositionStr = "";
   if(txtPosition.equals("1")){
	   txtPositionStr = "<font color='blue'>首页展会推荐</font>";
	}else if(txtPosition.equals("2")){
		txtPositionStr = "<font color='red'>首页重点展会推荐</font>";
	}else if(txtPosition.equals("3")){
		txtPositionStr = "<font color='black'>列表页展会推荐</font>";
	}
%>
      <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
        <td height="30" align="center"><%=k%></td>
        <td align="left"><%=Common.getFormatStr(rs.getString("txtTitle"))%> </td>
        <td align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("bgtim"))%>--<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("endtim"))%> </td>
        <td align="center"><%=Common.getFormatStr(rs.getString("showid")).equals("0")?"未发布":"<font color='blue'>发布</font>"%> </td>
        <td align="center"><%=txtPositionStr %> </td>
        <td align="center"><a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('exhibition_opt.jsp?myvalue=<%=rs.getString("id")%>','sell',650,600)">修改</a>
          <%if("0".equals(Common.getFormatStr(rs.getString("showid")))){ %>
          <a href="#" onclick="show('<%=rs.getString("id")%>')">发布</a>
          <%} if("1".equals(Common.getFormatStr(rs.getString("showid")))){ %>
          <a href="#" onclick="showd('<%=rs.getString("id")%>')">取消发布</a>
          <%} %>
        </td>
      </tr>
      <%
}
%>
      <tr >
        <td height="30" colspan="15" align=center><%=bar%></td>
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
