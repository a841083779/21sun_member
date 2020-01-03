<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%><%
	PoolManager poolManager = new PoolManager(4);
	Connection connection = null;
	Pagination pagination = new Pagination();
	pagination.setCountOfPage(20);
	ResultSet rs = null;
	String er_shou_domain = "http://localhost:9000";
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String flag = Common.getFormatStr(request.getParameter("flag"));
	try{
		connection = poolManager.getConnection();
		Map categoryMap = new HashMap();
		String query = "";
		query = " select id,category_name from used_category ";
		rs = DataManager.executeQuery(connection,query);
		while(null!=rs&&rs.next()){
			categoryMap.put(rs.getString("id"),rs.getString("category_name"));
		}
		query = " select * from used_message where flag = '"+flag+"' and rev_user = '"+memberInfo.get("mem_no")+"' ";
		String title =  Common.getFormatStr(request.getParameter("title"));
		if(!"".equals(title)){
			query += " and detail like '%"+title+"%' ";
		}
		String infoid = Common.getFormatStr(request.getParameter("infoid"));
		if(!"".equals(infoid)){
			query += " and infoid = '"+infoid+"' ";
		}
		query += " order by is_read asc ";
		rs = pagination.getQueryResult(query,request,connection);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>设备询价</title>
		<link href="/style/style.css" rel="stylesheet" type="text/css" />
		<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
		<script src="../scripts/jquery-1.4.1.min.js"></script>
	</head>
	<body>
	<div class="loginlist_right2">
		<%
			if("1".equals(flag)){
				%>
		<span class="mainyh">设备询价</span>
		<span class="mainyh" style="font-size: 16px;"><a href="message_list.jsp?flag=3">出售留言</a></span>
		<span class="mainyh" style="font-size: 16px;"><a href="message_list.jsp?flag=4">报价信息</a></span>
				<%
			}
			if("3".equals(flag)){
				%>
				<span class="mainyh" style="font-size: 16px;"><a href="message_list.jsp?flag=1">设备询价</a></span>
				<span class="mainyh">出售留言</span>
				<span class="mainyh" style="font-size: 16px;"><a href="message_list.jsp?flag=4">报价信息</a></span>
				<%
			}
			if("4".equals(flag)){
				%>
				<span class="mainyh" style="font-size: 16px;"><a href="message_list.jsp?flag=1">设备询价</a></span>
				<span class="mainyh" style="font-size: 16px;"><a href="message_list.jsp?flag=3">出售留言</a></span>
				<span class="mainyh"><a>报价信息</a></span>
				<%
			}
		%>
		
	</div>
	<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0" class="list">
          <tr>
            <td valign="top" style="padding-left: 20px; border: none;">
            <form action="" method="get" name="theform" id="theform">
              <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="15">
	                  <span style="font-size: 16px; font-weight: bold;">标题：</span><input type="text" name="title" style="height: 20px; width: 200px;border:1px solid #ccc;" value="<%=title %>" />
					  <input type="submit" value="" style="width: 52px; height: 19px; border: none; background: url(../images/bottom06.gif) left top no-repeat; cursor: pointer;" />
					  <input type="hidden" name="flag" value="<%=flag %>" />
					  <%
					  	if(!"".equals(infoid)){
					  		%>
					  	<input type="hidden" name="infoid" value="<%=infoid %>" />
					  		<%
					  	}
					  %>
                  </td>
                </tr>
              </table>		
              </form>
				<table width="100%" border="0" class="list">
					<tr>
						<th width="40%">
							<strong>标题<span style="color:blue;">（点击阅读）</span></strong>
						</th>
						<th width="15%">
							<strong>询价人</strong>
						</th>
						<th width="12%">
							<strong>联系方式</strong>
						</th>
						<th width="10%">
							<strong>是否阅读</strong>
						</th>
						<th width="13%">
							<strong>发送时间</strong>
						</th>
						<th width="10%">
							<strong>操作</strong>
						</th>
					</tr>
					<%
						String infoURL = "";
						String infoFlag = "";
						while(null!=rs&&rs.next()){
							infoFlag = Common.getFormatStr(rs.getString("flag"));
							if("1".equals(infoFlag)){
								infoURL = "/equipment/equipmentdetail_for_"+Common.getFormatStr(rs.getString("infoid"))+".htm";
							}else if("3".equals(infoFlag)){
								infoURL = "/sell/selldetail_for_"+Common.getFormatStr(rs.getString("infoid"))+".htm";
							}else if("4".equals(infoFlag)){
								infoURL = "/buy/buydetail_for_"+Common.getFormatStr(rs.getString("infoid"))+".htm";
							}
							infoURL  = er_shou_domain + infoURL;
							%>
					<tr>
						<td>
							<div style="width: 260px; height: 23px; overflow: hidden;">
								<a title='<%=Common.getFormatStr(rs.getString("detail")) %>' onclick="showMessage('<%=Common.getFormatStr(rs.getString("uuid")) %>');" href="javascript:void(0);"><%=Common.getFormatStr(rs.getString("detail")) %></a>
							</div>
						</td>
						<td><%=Common.getFormatStr(rs.getString("mem_name")) %></td>
						<td><%=Common.getFormatStr(rs.getString("mem_contact")) %></td>
						<td style="text-align: center;"><%
								String isRead = Common.getFormatStr(rs.getString("is_read"));
								if("1".equals(isRead)){
									isRead = "已读";
								}else{
									isRead = "<a title='"+Common.getFormatStr(rs.getString("detail"))+"' style=\"color:red;font-weight:bold;\" onclick=\"showMessage('"+Common.getFormatStr(rs.getString("uuid"))+"');\" href=\"javascript:void(0);\">未读</a>";
								}
								out.print(isRead);
							%>
						</td>
						<td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pub_date")) %></td>
						<td>
							<a href="<%=infoURL %>" target="_blank">关联信息</a>
						</td>
					</tr>
							<%	
						}
					%>
				</table>
				<table width="100%" border="0" class="list">
					<tr>
						<td align="left">
							<%=pagination.paginationPrint() %>
						</td>
					</tr>
				</table>
				</td>  
			</tr>
		</table>
	</body>
</html>
<script type="text/javascript">
function showMessage(uuid){
	var url = "message_opt.jsp?uuid="+uuid+"&flag=<%=flag %>";
	window.showModalDialog(url,uuid,"dialogHeight=340px;dialogWidth=400px;");
}
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		poolManager.freeConnection(connection);
	}
%>