<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="/webadmin/manage/config.jsp"%>
<%
if(pool == null){
	pool = new PoolManager();
}
Connection conn =null;

//=====页面属性====
String tablename="stock_expert";
String pageSubName="expert_opt.jsp";

//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(10);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
 
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1");

//姓名
String find_name=Common.getFormatStr(request.getParameter("find_name"));
if(!find_name.equals("")){
	query.append(" and name like '%"+find_name+"%'");
}
/*名号*/ 
String find_honor=Common.getFormatStr(request.getParameter("find_honor"));
if(!find_honor.equals("")){
	query.append(" and honor like '%"+find_honor+"%'");
}
/*简介*/
String find_description=Common.getFormatStr(request.getParameter("find_description"));
if(!find_description.equals("")){
	query.append(" and description like '%"+find_description+"%'");
}

query.append(" order by sort_order desc");

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
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td width="23%" class="p94b">&nbsp;</td>
            <td width="65%" align="center" nowrap="nowrap">
            姓名：<input name="find_name" type="text" id="find_name" value="<%=find_name%>" size="10" />
                名号：<input name="find_honor" type="text" id="find_honor" value="<%=find_honor%>"/>
			  简介：<input name="find_description" type="text" id="find_description" value="<%=find_description%>"/>
			  
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
            <td width="12%" align="center" bgcolor="e8f2ff"><strong>姓名</strong></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><strong>名号</strong></td>
            <td width="50%" align="center" bgcolor="e8f2ff"><div align="center"><strong>简介</strong></div></td>
            
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
            <td><%=Common.getFormatStr(rs.getString("name"))%></td>
            <td align="center"><%=Common.getFormatStr(rs.getString("honor"))%></td>
            <td align="center"><%=Common.getFormatStr(rs.getString("description"))%></td>			
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','win',800,600)">修改</a></span></div></td>
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
