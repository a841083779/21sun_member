<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
	
String tablename="member_favorites";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1  ");
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}

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
</head>
<body>
<form action="" method="get" name="theform" id="theform">
  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15"></td>
    </tr>
  </table>
  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="3%" class="p982"><img src="../images/bibi11.gif" width="19" height="19" /></td>
      <td width="83%" class="p982">我的收藏</td>
      <td width="14%" class="p982">&nbsp;</td>
    </tr>
  </table>
  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="15"></td>
    </tr>
  </table>
  <table width="99%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td colspan="3"><table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="1%" class="title_bar">&nbsp;</td>
                  <td width="23%" class="p94b">相关搜索：</td>
                  <td width="65%" align="center" nowrap> 标题：
                    <input name="title" type="text" id="title" size="15" value="<%=title%>">
               
                    <input type="submit" name="Submit" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom06.gif) left top no-repeat;cursor: pointer;" >
                    <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onClick="javascript:clearForm()">

                  </td>
                  <td width="18%" align="right" class="title_bar">&nbsp;</td>
                </tr>
                <tr>
                  <td class="title_bar">&nbsp;</td>
                  <td class="p94b">&nbsp;</td>
                  <td align="center" nowrap>&nbsp;</td>
                  <td align="right" class="title_bar">&nbsp;</td>
                </tr>
              </table>
              <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="15"></td>
                </tr>
              </table>
              <table width="98%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="7%" height="30" bgcolor="e8f2ff"><strong>ID</strong></td>
                  <td width="60%" bgcolor="e8f2ff"><strong>标题</strong></td>
                  <td width="18%" align="center" bgcolor="e8f2ff"><strong>收藏类别</strong></td>
                  <td width="15%" align="center" bgcolor="e8f2ff">&nbsp;</td>
                </tr>
                <tr>
                  <td height="6" colspan="4"></td>
                </tr>
<%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;

%>					
                <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
                  <td height="30"><%=k%></td>
                  <td><a href="<%=Common.getFormatStr(rs.getString("url"))%>" target="_blank"><%=Common.getFormatStr(rs.getString("title"))%></a></td>
                  <td align="center"><%=Common.getFormatStr(rs.getString("flag"))%></td>
                  <td align="center"><span class="p92j"><a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;</span></td>
                </tr>
                
<%
}
%>
<tr >
                  <td height="30" colspan="4"'><a href="#" onclick="pageSumit('0');">首页</a> <a href="#" onclick="pageSumit('<%=pagination.getPrev()%>');">上一页</a> <a href="#" onclick="pageSumit('<%=pagination.getNext()%>');" >下一页</a> <a  href="#" onclick="pageSumit('<%=pagination.getLast()%>');" >末页</a>
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
              </table>
            </td>
            <td></td>
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
