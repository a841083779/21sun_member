<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
//===调租赁库====
PoolManager pool3 = new PoolManager(1);
Connection conn =null;

//=====页面属性====
String tablename="zhidao_integral";
String pageSubName="point_opt.jsp";
//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}


String site_flag="8";


StringBuffer query =new StringBuffer("select * from "+tablename+" where (1=1)");
//得到参数
String findTitle=Common.getFormatStr(request.getParameter("findTitle"));
if(!findTitle.equals("")){
	query.append(" and men_no like '%"+findTitle+"%'");
}
try{
conn = pool3.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.pagesPrint(10); //读取分页提栏
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
            <td width="88%" align="center" nowrap="nowrap">
            <span class="title1">
              用户：
              <input name="findTitle" type="text" id="findTitle" value="<%=findTitle%>" />
              <input type="submit" name="Submit" value="查询" />
              <input type="button" name="Submit22" value="清空" onclick="javascript:clearForm()" />
              </span>
              <input type="button" name="Submit2" value="" style="width:52px;height:19px;border:none;background:url(../images/bottom07.gif) left top no-repeat;cursor: pointer;" onclick="javascript:clearForm()" />
              <input type="hidden" name="site_flag"  value="<%=site_flag%>"/></td>
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
            <td width="3%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="46%" bgcolor="e8f2ff"><strong>积分数量</strong></td>
            <td width="12%" bgcolor="e8f2ff"><strong>所属用户</strong></td>
            <td width="10%" bgcolor="e8f2ff"><strong>积分类型</strong></td>
            <td width="10%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>日期</strong></span></div></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="6"></td>
          </tr>
          <%
String temp_sort_flag="";
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="left"><span><%=k%></span></td>
            <td><%=Common.getFormatStr(rs.getString("num"))%></td>
            <td><%=Common.getFormatStr(rs.getString("men_no"))%></td>
            <%
            	if(rs.getString("type").equals("1")){
            		%><td>首次登录</td><%
            	}
            	if(rs.getString("type").equals("2")){
            		%><td>每日登录</td><%
            	}
            	if(rs.getString("type").equals("3")){
            		%><td>提出问题</td><%
            	}
            	if(rs.getString("type").equals("4")){
            		%><td>回答问题</td><%
            	}
            	if(rs.getString("type").equals("5")){
            		%><td>发站内信</td><%
            	}
            	if(rs.getString("type").equals("6")){
            		%><td>问题投票</td><%
            	}
            	if(rs.getString("type").equals("7")){
            		%><td>系统奖励</td><%
            	}
             %>
            
            <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../other/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','win',800,600)">修改</a></span></div></td>
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
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool3.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
