<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%
	PoolManager poolManager = new PoolManager(4);
	Connection connection = null;
	String uuid = Common.getFormatStr(request.getParameter("uuid"));
	String flag = Common.getFormatStr(request.getParameter("flag"));
	ResultSet message = null;
	try{
		connection = poolManager.getConnection();
		String sql = "";
		sql = " select * from used_message where uuid = '"+uuid+"' ";
		message = DataManager.executeQuery(connection,sql);
		DataManager.dataOperation(connection," update used_message set is_read = 1 where uuid = '"+uuid+"' ");
		String mem_name = "";
		String mem_contact = "";
		String pub_date = "";
		String detail = "";
		String address = "";
		if(null!=message&&message.next()){
			mem_name = Common.getFormatStr(message.getString("mem_name"));
			mem_contact = Common.getFormatStr(message.getString("mem_contact"));
			pub_date = Common.getFormatDate("yyyy-MM-dd",message.getDate("pub_date"));
			detail = Common.getFormatStr(message.getString("detail"));
			address = Common.getFormatStr(message.getString("province"))+Common.getFormatStr(message.getString("city"));
		}
		String leftTitle = "";
		if("3".equals(flag)){
			leftTitle = "留言";
		}else if("4".equals(flag)){
			leftTitle = "报价";
		}else{
			leftTitle = "询价";
		}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>留言信息查看回复</title>
	<link href="style/style.css" rel="stylesheet" type="text/css" />
	<link href="../style/tablestyle.css" rel="stylesheet" type="text/css" />
	<script src="../scripts/jquery-1.4.1.min.js"></script>
</head>
<body>
	<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2" class="biaoge" bgcolor="#3399FF">
           <tr>
             <td colspan="2" class="biaoge_title"><strong><%=leftTitle %>信息查看</strong></td>
           </tr>
           <tr>
             <td nowrap bgcolor="#FFFFFF" class="list_left_title" style="text-align: right;"><strong><%=leftTitle %>姓名：</strong> </td>
             <td bgcolor="#FFFFFF" class="list_cell_bg" width="80%">
		  	<%=mem_name %>
             </td>
           </tr>
           <tr>
             <td height="22" nowrap bgcolor="#FFFFFF" class="list_left_title" style="text-align: right;"><strong><%=leftTitle %>电话：</strong> </td>
             <td height="22" bgcolor="#FFFFFF" class="list_cell_bg" style="font-size: 16px; color:red;">
                 <%=mem_contact %>
		 	 </td>
           </tr>
           <tr>
             <td height="22" nowrap bgcolor="#FFFFFF" class="list_left_title" style="text-align: right;"><strong><%=leftTitle %>地址：</strong> </td>
             <td height="22" bgcolor="#FFFFFF" class="list_cell_bg">
		  		<%=address %>
             </td>
          </tr>
           <tr>
             <td height="22" nowrap bgcolor="#FFFFFF" class="list_left_title" style="text-align: right;"><strong><%=leftTitle %>时间：</strong> </td>
             <td height="22" bgcolor="#FFFFFF" class="list_cell_bg">
		  	<%=pub_date %>
             </td>
          </tr>
		<tr>
             <td height="22" nowrap bgcolor="#FFFFFF" class="list_left_title" style="text-align: right;"><strong><%=leftTitle %>内容：</strong> </td>
             <td height="22" bgcolor="#FFFFFF" class="list_cell_bg">
             	<textarea style="width: 300px; height: 100px;"><%=detail %></textarea>
             </td>
           </tr>
		<tr>
             <td height="22" nowrap bgcolor="#FFFFFF" class="list_left_title" colspan="2">
             	<div style="float: right; margin-right: 10px;">
             		<input name="reply" id="reply" class="tijiao" type="button" value="关闭" style="cursor:pointer;" onclick="window.close();" />
             	</div>
		  	</td>
        </tr>
	</table>
</body>
</html><%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		poolManager.freeConnection(connection);
	}
%>