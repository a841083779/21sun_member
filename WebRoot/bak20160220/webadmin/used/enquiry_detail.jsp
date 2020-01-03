<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%
//=====页面属性====
String pagename="sell_opt.jsp";
String mypy="message_new";
String titlename="询价详情";
PoolManager pool4 = new PoolManager(4);
Connection conn =null;
//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));
try{//====标题的名称====
	conn = pool4.getConnection();
	ResultSet rs = DataManager.getOneData(conn,mypy,"id",myvalue);
	String detail = "";
	if(rs.next()){
		detail = rs.getString("detail");
	}
	if(null!=rs){
		rs.close();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=titlename%></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/calendar.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
    <tr>
      <td height="22" class="list_cell_bg">
      		<textarea rows="20" cols="60" name="zd_detail" readonly="readonly" id="zd_detail"><%=detail==null?"":detail %></textarea>
      </td>
    </tr>
</table>
</body>
</html>
<%
}catch(Exception e){
	e.printStackTrace();
}finally{
	pool4.freeConnection(conn);
}
%>
