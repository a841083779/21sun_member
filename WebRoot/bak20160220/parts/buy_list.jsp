<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%><%

	pool = new PoolManager(7);

Connection conn =null;
	
String tablename="buy";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(18);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 and mem_no= '").append(usern).append("' and DateDiff(d,pubdate+pubdays,pubdate)<=0 and isnull(is_pause,0) <>1 ");
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}
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
<script type="text/javascript" src="/scripts/divopenwin/lhgdialog.js"></script>
<script language="javascript" type="text/javascript">
	function setFlag(flag){
	  var checkdel = document.getElementsByName('checkdel');
	  var checkedFlag=false;
	  for(i=0;i<checkdel.length;i++){
	    if(checkdel[i].checked){
		  checkedFlag = true;
		}
	 }
	 if(checkedFlag){
			if(confirm("确定这样操作吗？")){
				theform.action = "tool.jsp?flag="+flag;
				theform.target = "hiddenFrame";
				theform.method = "post";
				document.theform.submit();
	    	}
	   }else{
		  alert("请选择要更新的信息！");
	   }	
	}
</script>
</head>
<body><form action="" method="get" name="theform" id="theform">
<div class="loginlist_right">
    <div class="loginlist_right2"><span class="mainyh" style="width:260px;float:left">管理我的配件求购(正发布)</span><a href="expire_buy_list.jsp" style="width:127px;height:27px;float:left;padding-top:5px"><img src="../images/yidaoqi.gif" /></a></div><div class="loginlist_right2"><strong>"更新"</strong>操作将会使您的信息靠前显示;<strong>"暂停发布"</strong>功能将会使该条信息在前台暂不显示</div>
<div class="loginlist_right1">
<div style="width:100%;height:29px;padding:5px 0px;"><a href="javascript:setFlag('0');" style="width:80px;float:left" title="批量更新信息的发布时间，以便让信息在前面显示"><img src="../images/plgx.gif" /></a>
  <span class="title_bar st1"><input name="add_b" type="button" class="form_button" id="add_b" value="" style="width:78px;height:29px;border:none;background:url(../images/bottom03.gif) left top no-repeat;cursor: pointer;" onclick="window.location.href='buy_opt.jsp'" /></span></div>
  <table width="100%" border="0" class="list" style="margin-top:5px">
      <tr>
	  	<th width="2%" align="center">
		   <input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
		</td>
        <th width="3%">ID</th>
        <th width="32%">信息标题</th>
        <th width="9%">浏览量</th>
		<th width="9%">收藏量</th>
		<th width="10%" style="text-align:center">留言量</th>
		<th width="11%" style="text-align:center">更新日期</th>		
        <th width="24%"><div align="center">操作</div></th>
      </tr>
<%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
%>		  
      <tr>
	  	<td height="30" align="center">
		<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />
		</td>
        <td><%=k%></td>
        <td><a href="buy_opt.jsp?myvalue=<%=Common.encryptionByDES(Common.getFormatStr(rs.getString("id")))%>" class="blue14"><%=Common.getFormatStr(rs.getString("title"))%></a></td>
      <td><%if(!Common.getFormatInt(rs.getString("clicked")).equals("0")){%><a href="javascript:openDivWin('浏览量统计','/parts/view_count_info.jsp?no=<%=Common.getFormatInt(rs.getString("id"))%>&viewFlag=1&siteFlag=buy',700,610)"><%=Common.getFormatInt(rs.getString("clicked"))%></a><%}else{%><%=Common.getFormatInt(rs.getString("clicked"))%><%}%></td>
        <td><%if(!Common.getFormatInt(rs.getString("collection_count")).equals("0")){%><a href="javascript:openDivWin('收藏量统计','/parts/view_count_info.jsp?no=<%=Common.getFormatInt(rs.getString("id"))%>&viewFlag=2&siteFlag=buy',700,610)"><%=Common.getFormatInt(rs.getString("collection_count"))%></a><%}else{%><%=Common.getFormatInt(rs.getString("collection_count"))%><%}%></td>
		<td>　<%=Common.getFormatInt(rs.getString("message_count"))%></td>
        <td style="text-align:center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></td>
        <td><div align="center" style="width:180px"><!--<a href="javascript:otherDeleteData('../parts/opt_delete.jsp','<%=Common.encryptionByDES(Common.getFormatStr(rs.getString("id")))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a>--> &nbsp;&nbsp;<a href="buy_opt.jsp?myvalue=<%=Common.encryptionByDES(Common.getFormatStr(rs.getString("id")))%>">修改</a>&nbsp;&nbsp;<a href="update_pubdate.jsp?mypy=<%=Common.encryptionByDES(tablename)%>&myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>&type=pause&urlpath=expire_buy_list.jsp">暂停</a>&nbsp;&nbsp;<a href="update_pubdate.jsp?mypy=<%=Common.encryptionByDES(tablename)%>&myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>&urlpath=buy_list.jsp">更新</a></div></td>
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
  <input name="tablename" id="tablename"  type="hidden" value="<%=Common.encryptionByDES(tablename)%>"/>
  </form>
  <iframe name="hiddenFrame" style="display:none"></iframe>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>