<%@page contentType="text/html;charset=utf-8" import="com.jerehnet.cmbol.database.*,java.sql.*,java.util.*,com.jerehnet.util.*" %><%
	PoolManager poolManager = new PoolManager(4);
	Pagination pagination = new Pagination();
	pagination.setCountOfPage(15);
	Connection connection = null;
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	ResultSet rs = null;
	try{
		connection = poolManager.getConnection();
		Map brandMap = new HashMap();
		Map categoryMap = new HashMap();
		String query = "";
		query = " select id,category_name from used_category ";
		rs = DataManager.executeQuery(connection,query);
		while(null!=rs&&rs.next()){
			categoryMap.put(rs.getString("id"),rs.getString("category_name"));
		}
		if(null!=rs){
			rs.close();
		}
		query = " select * from used_sell ";
		query += " where mem_no = '"+memberInfo.get("mem_no")+"' ";
		String title = Common.getFormatStr(request.getParameter("title"));
		if(!"".equals(title)){
			query += " and title like '%"+title+"%' ";
		}
		query += " order by pub_date desc , id desc ";
		String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag"));
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理供应信息</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
</head>
<body>
  <div class="loginlist_right">
    <div class="loginlist_right2"><span class="mainyh">管理二手供应信息</span> </div>
    <div class="loginlist_right1">
    <form action="" method="get">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>	
						<span style="font-size: 14px; font-weight: bold;">出售意向：</span><input type="text" name="title" style="height: 20px; width: 200px;" value="<%=title %>" />
						<input type="submit" style="background-image: url('/images/mem_btnbg_1.gif'); border:none;margin: 0;padding: 0; width: 60px; height: 24px;font-weight:bold;cursor: pointer;color: #000;" value="查 询" />
						<input type="button" id="upt_b" style="background-image: url('/images/mem_btnbg_1.gif'); border:none;margin: 0;padding: 0; width: 60px; height: 24px;font-weight:bold;cursor: pointer;color: #000;" value="批量更新" />
					</td>					
				</tr>
			</table> 
	</form>
		
      <table width="100%" border="0" class="list" style="margin-top: 5px;">
        <tr>		  
		  <th width="2%" align="center"><input type="checkbox" id="checkall" name="checkall" onclick="checkAll(this);" /></th>
		  <th width="42%"><div align="center">出售意向<span style="color:blue;">（点击查看）</span></div></th> 
		  <th width="10%"><div align="center">设备类型</div></th>
          <th width="10%" ><div align="center">所在地区</div></th>
          <th width="10%"><div align="center">发布日期</div></th>
		  <th width="13%"><div align="center">查看留言</div></th>
          <th width="13%" ><div align="center">操作</div></th>
        </tr>
		<%
		rs = pagination.getQueryResult(query,request,connection);
			while(null!=rs&&rs.next()){
				%>
        <tr>
			<td height="30" align="center">
	       		<input type="checkbox" class="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("uuid")) %>" />
	       	</td>
			<td>
			<div style="text-align: left;">
				<a href="sell_opt.jsp?uuid=<%=Common.getFormatStr(rs.getString("uuid")) %>"><%=Common.getFormatStr(rs.getString("title")) %></a>
					<%
						if(!"1007".equals(mem_flag)&&!"1008".equals(mem_flag)&&!"1014".equals(mem_flag)&&Common.getFormatStr(rs.getString("is_pub")).equals("0")){
							%>
							<span style="color:red;">(待审核)</span>
							<%
						}
					%>
			</div>
			</td>
			<td><div align="center"><%=Common.getFormatStr(categoryMap.get(rs.getString("category_id"))) %></div></td>
			<td><div align="center"><%=Common.getFormatStr(rs.getString("province"))+Common.getFormatStr(rs.getString("city")) %></div></td>
			<td><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pub_date")) %></div></td>
			<td><div align="center">(<b><%=Common.getFormatStr(rs.getString("order_count")) %></b>)【<a href="javascript:void(0);" onclick="seeMessage('<%=Common.getFormatStr(rs.getString("id")) %>');"><font color='green'>查看</font></a>】</div></td>
			<td style="text-align: center;">
				<a href="sell_opt.jsp?uuid=<%=Common.getFormatStr(rs.getString("uuid")) %>">修改</a>
				<a href="javascript:void(0);" onclick="doOneUpdate('<%=Common.getFormatStr(rs.getString("uuid")) %>');">更新</a>
			</td>
        </tr>
				<%
			}
		if(null!=rs){
			rs.close();
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
    </div>
  </div>
</body>
</html>
<script type="text/javascript">
function seeMessage(infoid){
	var url = "message_list.jsp?infoid="+infoid+"&flag=3";
	window.location.href = url;
}
function checkAll(o){
	if(o.checked){
		jQuery(".checkdel").attr("checked","checked");
	}else{
		jQuery(".checkdel").removeAttr("checked");
	}
}
function doOneUpdate(uuid){
	jQuery.post("tools/update_pub_date.jsp",{'flag':'sell_one','uuid':uuid},function(data){
		if(jQuery.trim(data)=='ok'){
			alert("更新成功！");
		}else{
			alert("系统错误，请稍候再试！");
		}
	});
}
function doUpdate(){
	var uuidStr = "";
	var checked = jQuery(".checkdel:checked");
	if(checked.length<=0){
		alert("请选择需要更新的数据！");
		return;
	}
	jQuery.each(checked,function(index,data){
		uuidStr += this.value+",";
	})
	if(uuidStr.indexOf(",")!=-1){
		uuidStr = uuidStr.substring(0,uuidStr.length-1);
	}
	jQuery.post("tools/update_pub_date.jsp",{'flag':'sell','uuid':uuidStr},function(data){
		if(jQuery.trim(data)=='ok'){
			alert("更新成功！");
			jQuery(".checkdel").removeAttr("checked");
		}else{
			alert("系统错误，请稍候再试！");
		}
	});
}
jQuery("#upt_b").click(function(){
	doUpdate();
});
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		poolManager.freeConnection(connection);
	}
%>