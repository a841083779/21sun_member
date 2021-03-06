<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(9);
	Connection conn =null;	
	String tablename="fittings_business_info";
	//flag 1:配套合作;2:代理招商;3:求购信息;4:供应信息
	String flag=Common.getFormatInt(request.getParameter("flag"));
	if(flag.equals("0")){
		flag = "4";
	}
	Pagination pagination = new Pagination();
	//设置每页显示条数
	pagination.setCountOfPage(15);
	//分页中当前记录
	String offset=Common.getFormatStr(request.getParameter("offset"));
	if(offset.equals("")){
		offset="0";
	}
	
	StringBuffer query =new StringBuffer("select id,no,title,update_date,view_count,collection_count,is_show from "+tablename+" where mem_no = '"+(String)adminInfo.get("mem_no")+"' and flag = '"+flag+"'  order by update_date desc");
	try{
		conn = pool.getConnection();
		//SQL查询	
		ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1);
		String bar = pagination.paginationPrint();  //读取分页提示栏
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
<script language="javascript" type="text/javascript">
	function ajaxMethod(flag,id){//flag，1：更新 2：暂停 3：显示
		$.ajax({
			url:"tool.jsp?id="+id+"&flag="+flag+"&tableName=<%=tablename%>",
			type:"post",
			success:function(msg){
				if(flag==1){
					alert("更新成功，更新日期为:<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>");
					window.location.reload();
				}else if(flag==2){
					alert("暂停成功！");
					window.location.reload();
				}else if(flag==3){
					alert("发布成功！");
					window.location.reload();
				}
			}
			}); 
	}
	function batchAjaxMethod(flag){
		var allId = document.getElementsByName("checkdel");
		var id = "";
		var flagName = "操作";
		if(flag==1){
			flagName = "更新";
		}else if(flag==2){
			flagName = "暂停发布";
		}else if(flag==3){
			flagName = "重新发布";
		}
		for(var i=0;allId!=null && i<allId.length;i++){
			if(allId[i].checked){
				id += allId[i].value+",,";
			}
		}
		if(id==""){
			alert("请先选择您要"+flagName+"的信息");
		}else if(confirm("确认"+flagName+"您选择的信息吗?")){
			$.ajax({
				url:"tool.jsp?id="+id+"&flag="+flag+"&tableName=<%=tablename%>",
				type:"post",
				success:function(msg){
					window.location.reload();
				}
			}); 
		}
	}
</script>
</head>
<body>
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">管理我的配套件供应信息</span></div>
  <div class="loginlist_right2"><strong>"更新"</strong>操作将会使您的信息靠前显示;<strong>"暂停发布"</strong>功能将会使该条信息在前台暂不显示</div>
  <div class="loginlist_right1"><span class="title_bar">
    <input name="add_b" type="button" class="form_button" id="add_b" value="" style="width:78px;height:25px;border:none;background:url(../images/bottom03.gif) left top no-repeat;cursor: pointer;" onclick="window.location.href='supply_opt.jsp'" />
	&nbsp;&nbsp;<strong><a href="javascript:batchAjaxMethod('1');">批量更新</a></strong>&nbsp;&nbsp;<strong><a href="javascript:batchAjaxMethod('2');">批量暂停</a></strong>&nbsp;&nbsp;<strong><a href="javascript:batchAjaxMethod('3');">批量发布</a></strong>
    </span>
    <table width="100%" border="0" class="list">
      <tr>
        <th width="5%"><input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();"/></th>
        <th width="31%">标题(点击预览)</th>
        <th width="10%"><div align="center">浏览量</div></th>
        <th width="10%"><div align="center">收藏量</div></th>
        <th width="12%"><div align="center">更新日期</div></th>
		<th width="12%"><div align="center">发布状态</div></th>
        <th width="20%"><div align="center">操作</div></th>
      </tr>
      <%
		 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
		 while (rs!=null && rs.next()){
		 	k=k+1;
	  %>
      <tr>
        <td><input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.encryptionByDES(rs.getString("id"))%>" /></td>
        <td><a href="<%=fittingsUrl+"/business/detail_for_"+Common.getFormatStr(rs.getString("id"))+".htm"%>" class="blue14" target="_blank" title="<%=Common.getFormatStr(rs.getString("title"))%>"><%=Common.substringByte(rs.getString("title"),30)%></a></td>
        <td><div align="center"><a href="javascript:openDivWin('浏览量统计','/fittings/view_count_info.jsp?no=<%=Common.getFormatStr(rs.getString("no"))%>',700,610)"><%=Common.getFormatStr(rs.getString("view_count")).equals("")?"0":Common.getFormatStr(rs.getString("view_count"))%></a></div></td>
        <td><div align="center"><a href="javascript:openDivWin('收藏量统计','/fittings/collection_count_info.jsp?no=<%=Common.getFormatStr(rs.getString("no"))%>',700,610)"><%=Common.getFormatStr(rs.getString("collection_count")).equals("")?"0":Common.getFormatStr(rs.getString("collection_count"))%></a></div></td>
        <td><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("update_date"))%></div></td>
		<td><div align="center"><%=Common.getFormatStr(rs.getString("is_show")).equals("1")?"发布中":"<font color='red'>暂停中</span>"%></div></td>
        <td><div align="center"><a href="javascript:ajaxMethod('1','<%=Common.encryptionByDES(rs.getString("id"))%>');">更新</a>&nbsp;&nbsp;<a href="javascript:ajaxMethod('<%=Common.getFormatStr(rs.getString("is_show")).equals("1")?"2":"3"%>','<%=Common.encryptionByDES(rs.getString("id"))%>');"><%=Common.getFormatStr(rs.getString("is_show")).equals("0")?"重新发布":"暂停发布"%></a>&nbsp;&nbsp;<a href="supply_opt.jsp?myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>">修改</a><a href="javascript:otherDeleteData('../fittings/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');"><!--删除--></a></div></td>
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
