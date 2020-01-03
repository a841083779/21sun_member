<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%><%

	pool = new PoolManager(3);

Connection conn =null;
	
String tablename="rent_subscribe";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(18);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1  and mem_no= '").append(usern).append("' ");
query.append(" and type='1'");

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
  <div class="loginlist_right2"><span class="mainyh">管理我的订阅</span></div>
  <div class="loginlist_right1"><div style="width:100%;height:25px"><a href="javascript:window.location.href='subscribe_opt.jsp?type=1'" style="width:80px;float:left" ><img src="../images/cjdy.gif" border="0"/></a>
  </div>
<table width="100%" border="0" class="list" style="margin-top:5px">
      <tr>
        <th width="3%">序</th>
        <th width="12%">商机订阅器</th>
        
        <th width="8%">省份</th>
		<th width="11%">城市</th>		
        <th width="11%">类别</th>
        <th width="10%">订阅时间</th>
        <th width="12%" align="center">操作</th>
      </tr>
<%
 	int k=0;
	
    String name_temp ="",province_temp="",city_temp="";
    while(rs!=null && rs.next()){
      k=k+1;
	 name_temp         = Common.getFormatStr(rs.getString("name"));
	 province_temp     = Common.getFormatStr(rs.getString("province"));
     city_temp         = Common.getFormatStr(rs.getString("city"));
   %>		  
      <tr>
        <td><%=k%></td>
        <td><a href="http://www.21-rent.com/rent/rentsearch.jsp?province=<%=java.net.URLEncoder.encode(province_temp,"utf-8")%>&city=<%=java.net.URLEncoder.encode(city_temp,"utf-8")%>" target="_blank"><%=name_temp%></a></td>
		<td><%=province_temp%></td>
       
        <td><%=city_temp%></td>
        <td><%=Common.getFormatStr(rs.getString("categoryname"))%></td>
        <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></td>
        <td><a href="javascript:otherDeleteData('../rent/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;<a href="subscribe_opt.jsp?myvalue=<%=Common.getFormatInt(rs.getString("id"))%>">修改</a></td>
      </tr>
<%
}
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