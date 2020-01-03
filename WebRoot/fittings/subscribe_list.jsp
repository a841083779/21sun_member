<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(9);
	Connection conn =null;	
	String tablename="fittings_subscribe";

	Pagination pagination = new Pagination();
	
	StringBuffer query =new StringBuffer("select id,mem_no,keyword,info_type,part_sort,province,city,email,is_show from "+tablename+" where mem_no = '"+(String)adminInfo.get("mem_no")+"'  order by id asc");
	try{
		conn = pool.getConnection();
		//SQL查询	
		ResultSet rs = DataManager.executeQuery(conn,query.toString());
		
		String[][] tempInfo = DataManager.fetchFieldValue(pool, tablename,"count(*)", " mem_no='"+usern+"' ");
		String pubCount   = "0";
		if(tempInfo!=null) {
		  pubCount=Common.getFormatInt(tempInfo[0][0]);
		}
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
					alert("退订成功！");
					window.location.reload();
				}else if(flag==3){
					alert("订阅成功！");
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
			flagName = "退订";
		}else if(flag==3){
			flagName = "订阅";
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
  <div class="loginlist_right2"><span class="mainyh">管理我的订阅器</span></div>
  <div class="loginlist_right2"><strong>"创建订阅器"</strong>后可及时收到系统发送的符合订阅条件的求购信息的邮件;共可创建<strong><font color="#FF0000">5</font></strong>个订阅器，您已经创建了<strong><font color="#FF0000"><%=pubCount%></font></strong>个;<br /><strong>"退订"</strong>操作将会使您的订阅器失效;<strong>"订阅"</strong>功能将会使该订阅器重新生效</div>
  <div class="loginlist_right1"><span class="title_bar">
    <input name="add_b" type="button" class="form_button" id="add_b" value="" style="width:78px;height:25px;border:none;background:url(../images/cjdyq.gif) left top no-repeat;cursor: pointer;" onclick="if('<%=pubCount%>'>=5){alert('很抱歉，您已创建了<%=pubCount%>个订阅器，已经达到最大数！');}else{window.location.href='subscribe_opt.jsp'}" />
	&nbsp;&nbsp;
    </span>
    <table width="100%" border="0" class="list">
      <tr>
        <th width="5%" align="center">序号</th>
        <th width="63%">订阅条件</th>
		<th width="12%"><div align="center">订阅状态</div></th>
        <th width="20%"><div align="center">操作</div></th>
      </tr>
      <%
		 int k = 0;
		 while (rs!=null && rs.next()){
		 	k++;
	  %>
      <tr>
        <td align="center"><%=k%></td>
        <td><%=Common.getFormatStr(rs.getString("keyword"))%></td>
		<td><div align="center"><%=Common.getFormatStr(rs.getString("is_show")).equals("1")?"已订阅":"<font color='red'>已退订</span>"%></div></td>
        <td><div align="center"><a href="javascript:ajaxMethod('<%=Common.getFormatStr(rs.getString("is_show")).equals("1")?"2":"3"%>','<%=Common.encryptionByDES(rs.getString("id"))%>');"><%=Common.getFormatStr(rs.getString("is_show")).equals("0")?"订阅":"退订"%></a>&nbsp;&nbsp;<a href="subscribe_opt.jsp?myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>">修改</a><a href="javascript:otherDeleteData('../fittings/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');"><!--删除--></a></div></td>
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
