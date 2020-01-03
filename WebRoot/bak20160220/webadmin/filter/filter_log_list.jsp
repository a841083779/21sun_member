<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<% 
if(pool==null){
	pool = new PoolManager();
}
Connection conn = pool.getConnection();
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(50);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
try{

//搜索条件形成
String searchStr=" where 1=1 ";


String mem_no = Common.getFormatStr(request.getParameter("mem_no"));
if(!"".equals(mem_no)){
	searchStr+=" and mem_no='"+mem_no+"'";
}
String tablename="comm_filter_records";
searchStr+=" order by id desc";
//SQL查询
String query = "select * from comm_filter_records "+searchStr; 
//Common.println(query);		
ResultSet rs = pagination.getQueryResult(query, request,conn);
String bar = pagination.paginationPrint();  //读取分页提示栏

//out.println(query);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script type="text/javascript">
</script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style>
</head>
<body >
<form action="" method="get" name="theform" id="theform">
  <table width="90%"  border="0" cellpadding="0" cellspacing="0" id="table7">
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div align="center">
    <table width="97%"  border="0" cellpadding="0" cellspacing="0">
      <tr height="12">
        <td bgcolor="#C6CEE3"><strong class="font_big">过滤记录</strong></td>
      </tr>
    </table>
  </div>
  <table width="100%"  border="0" cellspacing="0" cellpadding="0" id="table4">
    <tr>
      <td width="5" background="../images/admin/oper_table_left_bg.gif"><img src="../images/admin/oper_table_left_bg.gif" width="5" height="2"></td>
      <td background="../images/admin/oper_table_bg.gif"><div align="center">
          <table width="97%"  border="0" cellpadding="0" cellspacing="0" id="table5">
            <tr>
              <td width="12%" class="title_bar"><span class="title_bar">
                <!-- <input name="add_b" type="button" class="form_button" id="add_b" value="增加" onClick="openWin('keyword_add.jsp','add',500,400)"> -->
                </span></td>
              <td width="70%" align="center" class="title1">
               账号：
                <input name="mem_no" type="text" id="mem_no" value="<%=mem_no%>" size="10">
                <input type="submit" name="Submit" value="查询"></td>
              <td width="18%" align="right" class="title_bar">&nbsp;</td>
            </tr>
          </table>
        </div></td>
      <td width="5" background="../images/admin/oper_table_right_bg.gif">&nbsp;</td>
    </tr>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%" id="table3">
    <tr>
      <td height="15"><font color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
    </tr>
  </table>
  <div align="center">
    <table width="97%" border="0" cellpadding="4" cellspacing="1" class="table_border_bg" style="background-color: #717EA2" id="table2">
      <tr bgcolor="#e8f2ff">
        <td width="3%" align="center" nowrap class="title1" bgcolor="#e8f2ff"><strong class="list_border_bg">序号</strong></td>
        <td width="8%" nowrap class="title1" bgcolor="#e8f2ff"><strong class="list_border_bg">关键词</strong></td>
        <td width="8%" nowrap class="title1" bgcolor="#e8f2ff"><strong class="list_border_bg">会员号</strong></td>
        <td width="8%" nowrap class="title1" bgcolor="#e8f2ff"><strong class="list_border_bg">ip地址</strong></td>
        <td width="8%" nowrap class="title1" bgcolor="#e8f2ff"><strong class="list_border_bg">过滤时间</strong></td>
        <!-- <td width="9%" align="center" nowrap class="title1" bgcolor="#e8f2ff"><strong>操作</strong></td> -->
      </tr>
      <%
int j=0;				
 while (rs!=null && rs.next()){
 j++;
%>
      <tr  <%=j%2==0?"bgcolor='#E8EAF0'":"bgcolor='#FFFFFF'"%>>
        <td height="22" align="center" nowrap ><%=j%></td>
        <td height="22" nowrap ><%=Common.getFormatStr(rs.getString("keywords"))%></td>
        <td height="22" nowrap ><%=Common.getFormatStr(rs.getString("mem_no"))%></td>
        <td height="22" nowrap ><%=Common.getFormatStr(rs.getString("ip")) %></td>
        <td height="22" nowrap ><%=Common.getFormatStr(rs.getString("add_date")) %></td>
        <!-- <td align="center" nowrap ><a href="#" onClick="openWin('keyword_add.jsp?id=<%=Common.getFormatStr(rs.getString("id"))%>','modi',500,400)">修改</a>&nbsp;&nbsp; <a href="javascript:otherDeleteData('opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a></td> -->
      </tr>
      <%}%>
      <tr class="table_border_cell_bg" colspan="22">
        <td colspan="10" bgcolor="#FFFFFF" align=center><a href="#" onClick="pageSumit('0');">首页</a> <a href="#" onClick="pageSumit('<%=pagination.getPrev()%>');">上一页</a> <a href="#" onClick="pageSumit('<%=pagination.getNext()%>');" >下一页</a> <a  href="#" onClick="pageSumit('<%=pagination.getLast()%>');" >末页</a>
          <select name="offset" onChange="theform.submit();">
            <%
	String pages[]=pagination.getPages();
	for(int i=0;i<pages.length;i++){
		out.print("<option value='"+pages[i]+"' "+((offset.equals(pages[i]))?"selected":"")+">"+(i+1)+"</option>");
	}
	%>
          </select>
          页 <%=pagination.getCurrenPages()%>/<%=pagination.getTotalPages()%>页  总计<%=pagination.getTotal()%>条 </td>
      </tr>
    </table>
  </div>
</form>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
<script>
function updateLink(url,website_id,pool_tag){

	window.open (url+"?website_id="+website_id + "&pool_tag="+ pool_tag);
}
</script>