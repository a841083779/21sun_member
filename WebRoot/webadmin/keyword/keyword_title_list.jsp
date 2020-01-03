<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
	
String tablename="keyword_search_title";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

String parentId = Common.getFormatStr(request.getParameter("parentId"));
String parentKeyword = Common.getFormatStr(request.getParameter("parentKeyword"));
//out.println(parentId+parentKeyword);
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 and is_show = 1 and valid_date > getDate() and keyword_id = '"+parentId+"' ");
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}
String company=Common.getFormatStr(request.getParameter("company"));
if(!company.equals("")){
	query.append(" and company like '%"+company+"%'");
}
//System.out.println(query);
try{
conn = pool.getConnection();
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
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function setFlag(flag){
		if(confirm("确定这样设置吗？")){
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
            <td width="23%" class="p94b">&nbsp;</td>
            <td width="65%" align="center" nowrap="nowrap"> 标　　题：
              <input name="title" type="text" id="title" size="15" value="<%=title%>" />
              公司名称：
              <input name="company" type="text" id="company" size="15" value="<%=company%>" />
              <input type="submit" name="Submit" value="搜索"  />
              <input type="button" name="Submit2" value="清空"  onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15"><input type="button" name="b_add" value="增加" onclick="openWin('keyword_title_opt.jsp?parentId=<%=parentId%>&parentKeyword='+encodeURIComponent('<%=parentKeyword%>'),'sell',650,600)"/>
              <a href="keyword_list.jsp">返回关键词列表</a>
              <!--<a href="../拷贝于 market/to_html.jsp" target="_blank">更新首页静态页数据</a>-->
            </td>
          </tr>
          <!--
			<tr style="padding-top:10px">
				<td>
					<input type="button" id="hot" name="hot" value="设为热点" onclick="setFlag(1);"/>
					<input type="button" id="sell" name="sell" value="最新供应" onclick="setFlag(2);"/>
					<input type="button" id="buy" name="buy" value="最新求购" onclick="setFlag(3);"/>
				</td>
			</tr>
			-->
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="1%" height="30" align="center" bgcolor="e8f2ff"><input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
            </td>
            <td width="5%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="22%" bgcolor="e8f2ff"><strong>标题</strong></td>
            <td width="6%" bgcolor="e8f2ff"><strong>类型</strong></td>
            <td width="9%" bgcolor="e8f2ff"><strong>点击量</strong></td>
            <td width="18%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>所属公司</strong></span></div></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>有效期至</strong></span></div></td>
            <td width="10%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否显示</strong></span></div></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="5"></td>
          </tr>
          <%  String typeStr = "";	
              String type ="";
			 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
			 while (rs!=null && rs.next()){
			   k=k+1;
			   type = Common.getFormatStr(rs.getString("type"));			   
			   if(!type.equals("")){
			      typeStr = type.replace("1","供求").replace("2","二手").replace("3","租赁").replace("4","配件");
			   }	   
			%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />
            </td>
            <td height="30" align="center"><%=k%></td>
            <td><a href="#" onclick="openWin('keyword_title_opt.jsp?myvalue=<%=rs.getString("id")%>','sell',650,600)"><%=Common.getFormatStr(rs.getString("title"))%></a></td>
            <td><%=typeStr%></td>
            <td><%=Common.getFormatStr(rs.getString("view_count"))%></td>
            <td align="left"><div align="left"><%=Common.getFormatStr(rs.getString("company"))%></div></td>
            <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("valid_date"))%></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_show")).equals("1")?"显示":"不显示"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('keyword_title_opt.jsp?myvalue=<%=rs.getString("id")%>','sell',650,600)">修改</a></span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="5"><a href="#" onclick="pageSumit('0');">首页</a> <a href="#" onclick="pageSumit('<%=pagination.getPrev()%>');">上一页</a> <a href="#" onclick="pageSumit('<%=pagination.getNext()%>');" >下一页</a> <a  href="#" onclick="pageSumit('<%=pagination.getLast()%>');" >末页</a>
              <select name="offset" onchange="theform.submit();">
                <%
	String pages[]=pagination.getPages();
	for(int i=0;i<pages.length;i++){
		out.print("<option value='"+pages[i]+"' "+((offset.equals(pages[i]))?"selected":"")+">"+(i+1)+"</option>");
	}
	%>
              </select>
              页 <%=pagination.getCurrenPages()%>/<%=pagination.getTotalPages()%>页  总计<%=pagination.getTotal()%>条 </td>
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
