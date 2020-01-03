<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(9);
	Connection conn =null;	
	String tablename="fittings_data_basic";
		
	StringBuffer query =new StringBuffer("select id,no,fittings_machine_sort,fittings_machine_model,part_sort,fittings_company,fittings_agent_count from "+tablename+" where mem_no = '"+(String)adminInfo.get("mem_no")+"' order by add_date asc");
	try{
		conn = pool.getConnection();
		//SQL查询	
		ResultSet rs = DataManager.executeQuery(conn,query.toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/divopenwin/lhgdialog.js"></script>
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">管理我的配套件基本信息</span></div>
  <div class="loginlist_right1"><span class="title_bar">
    <input name="add_b" type="button" class="form_button" id="add_b" value="" style="width:78px;height:25px;border:none;background:url(../images/bottom03.gif) left top no-repeat;cursor: pointer;" onclick="window.location.href='baseinfo_opt.jsp'" />
	&nbsp;&nbsp;<strong style="cursor:pointer"> <a href="/fittings/submitdata_list.jsp">>>返回数据提交</a></strong>
    </span>
    <table width="100%" border="0" class="list">
      <tr>
        <th width="12%">配套整机类别</th>
        <th width="12%">配套机型</th>
        <th width="12%">配件类型</th>
        <th width="32%">配套厂家</th>
        <th width="16%">销售代理商数量</th>
        <th width="16%"><div align="center">操作</div></th>
      </tr>
      <%
		 while (rs!=null && rs.next()){
	  %>
      <tr>
        <td><%=Common.getFormatStr(rs.getString("fittings_machine_sort"))%></td>
        <td><%=Common.getFormatStr(rs.getString("fittings_machine_model"))%></td>
        <td><%=Common.getFormatStr(rs.getString("part_sort"))%></td>
        <td><%=Common.getFormatStr(rs.getString("fittings_company"))%></td>
        <td><div align="center"><%=Common.getFormatStr(rs.getString("fittings_agent_count"))%></div></td>
        <td><div align="center"><a href="baseinfo_opt.jsp?myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>">修改</a>&nbsp;&nbsp;<a href="javascript:otherDeleteData('../fittings/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a></div></td>
      </tr>
      <%
}
%>
    </table>
  </div>
</div>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
