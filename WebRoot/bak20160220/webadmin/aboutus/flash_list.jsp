<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;

//=====页面属性====
String tablename="aboutus_flash_news";
String pageSubName="flash_opt.jsp";
//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where  1=1 ");
//得到参数
String findTitle=Common.getFormatStr(request.getParameter("findTitle"));
if(!findTitle.equals("")){
	query.append(" and webname like '%"+findTitle+"%'");
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
            <td width="65%" align="center" nowrap="nowrap"><span class="title1">标题：
              <input name="findTitle" type="text" id="findTitle" value="<%=findTitle%>" />
             
              <input type="submit" name="Submit" value="查询" />
              <input type="button" name="Submit22" value="清空" onclick="javascript:clearForm()" />
              </span>
              <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15"><input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',800,600)"/>
              </a></td>
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="5%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="45%" bgcolor="e8f2ff"><strong>webname</strong></td>
			 <td width="14%" align="center" bgcolor="e8f2ff"><strong>website</strong></td>
            <td width="11%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>link</strong></span></div></td>
            <td width="11%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>图片</strong></span></div></td>
            <td width="14%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="5"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
   String img = Common.getFormatStr(rs.getString("filepath"));
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><%=k%></td>
            <td><%=Common.getFormatStr(rs.getString("webname"))%></td>
			 <td><%=Common.getFormatStr(rs.getString("website"))%></td>
            <td align="center"><div align="center"><%=Common.getFormatStr(rs.getString("link"))%></div></td>
            <td align="center"><div align="center"><img src="<%=img.indexOf("resource.21-sun.com")!=-1?img:"http://aboutus.21-sun.net"+img%>" height="90" width="90"/></div></td>
            <td align="center" nowrap="nowrap"><div align="center"><span class="p92j"><a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp;
             <a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','win',800,600)">修改</a></span></div>
             </td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="5"><%=bar%></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
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
