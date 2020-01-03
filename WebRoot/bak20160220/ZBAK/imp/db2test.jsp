<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%>

<%

PoolManager pool = new PoolManager(2);

Connection conn =null;
ResultSet rs = null;

ResultSet rs2 = null;

String sql ="";

try{

conn = pool.getConnection();
%>

分类：<br />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td nowrap="nowrap">&nbsp;id</td>
    <td nowrap="nowrap">&nbsp;title</td>
    <td nowrap="nowrap">&nbsp;pubts</td>
    <td nowrap="nowrap">&nbsp;flag</td>
  </tr>

<%

sql ="select id,title,pubts,flag from MARKET1 FETCH   FIRST   350   ROWS   ONLY";
rs = DataManager.executeQueryDB2(conn,sql);
while(rs.next()){


rs2 = DataManager.executeQueryDB2(conn,"select count(*) from MARKET01 where id1="+rs.getString("id")+"");

%>


  <tr>
    <td>&nbsp;<%=rs.getString("id")%></td>
    <td>&nbsp;<%=rs.getString("title")%>(<%if(rs2.next()){out.println(rs2.getInt(1));}%>)</td>
    <td>&nbsp;<%=rs.getString("pubts")%></td>
    <td>&nbsp;<%=rs.getString("flag")%></td>
  </tr>

<%
}
%>
</table>
<br />

关联表：<br />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td nowrap="nowrap">&nbsp;id0－信息表ID</td>
    <td nowrap="nowrap">&nbsp;id1－类别表ID</td>

  </tr>

<%

sql ="select id0,id1 from MARKET01 FETCH   FIRST   10   ROWS   ONLY";
rs = DataManager.executeQueryDB2(conn,sql);
while(rs.next()){

%>


  <tr>
    <td>&nbsp;<%=rs.getString("id0")%></td>
    <td>&nbsp;<%=rs.getString("id1")%></td>

  </tr>

<%
}
%>
</table>
<br />
<br />

信息：<br />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td nowrap="nowrap">&nbsp;<%=("id")%></td>
    <td nowrap="nowrap">&nbsp;<%=("clicked")%>点击量</td>
    <td nowrap="nowrap">&nbsp;<%=("eid")%></td>
    <td nowrap="nowrap">&nbsp;<%=("mid")%>会员编号</td>
    <td nowrap="nowrap">&nbsp;<%=("direction")%>供求分类</td>
    <td nowrap="nowrap">&nbsp;<%=("title")%>标题</td>
    <td nowrap="nowrap">&nbsp;<%=("catbrandid")%></td>
    <td nowrap="nowrap">&nbsp;<%=("catfunctionid")%></td>
    <td nowrap="nowrap">&nbsp;
    <%//=("detail")%></td>
    <td nowrap="nowrap">&nbsp;<%=("pubdate")%>发布日期</td>
    <td nowrap="nowrap">&nbsp;<%=("pubdays")%>有效时间</td>
    <td nowrap="nowrap">&nbsp;<%=("ispublished")%>是否发布</td>
    <td nowrap="nowrap">&nbsp;<%=("isfinished")%></td>
  </tr>

<%

sql ="select id,clicked,eid,mid,direction,title,catbrandid,catfunctionid,detail,pubdate,pubdays,ispublished,isfinished from WEBMARKET FETCH   FIRST   10   ROWS   ONLY";
rs = DataManager.executeQueryDB2(conn,sql);
while(rs.next()){

%>


  <tr>
    <td>&nbsp;<%=rs.getString("id")%></td>
    <td>&nbsp;<%=rs.getString("clicked")%></td>
    <td>&nbsp;<%=rs.getString("eid")%></td>
    <td>&nbsp;<%=rs.getString("mid")%></td>
    <td>&nbsp;<%=rs.getString("direction")%></td>
    <td>&nbsp;<%=rs.getString("title")%></td>
    <td>&nbsp;<%=rs.getString("catbrandid")%></td>
    <td>&nbsp;<%=rs.getString("catfunctionid")%></td>
    <td>&nbsp;<%//=rs.getString("detail")%></td>
    <td>&nbsp;<%=rs.getString("pubdate")%></td>
    <td>&nbsp;<%=rs.getString("pubdays")%></td>
    <td>&nbsp;<%=rs.getString("ispublished")%></td>
    <td>&nbsp;<%=rs.getString("isfinished")%></td>
  </tr>

<%
}
%>
</table>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}


%>

