<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%><%
   pool = new PoolManager(7);
   Connection conn =null;
   String find_differ="";
	 
String tablename="supply_partstore";
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(18);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 and mem_no= '").append(usern).append("' ");
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}

query.append(" order by pubdate desc,id desc");

try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1);
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
			    if(flag=='0')
				{theform.action = "tool.jsp?flag="+flag;}
				else if(flag=='1')
				{theform.action = "tool_pause.jsp?flag="+flag;}
				
				theform.target = "hiddenFrame";
				theform.method = "post";
				document.theform.submit();
	    	}
	   }else{
		  if(flag=='0')
		  alert("请选择要更新的信息！");
		  else if(flag=='1')
		  alert("请选择要暂停的信息！");
	   }	
	}
</script>
</head>
<body><form action="" method="get" name="theform" id="theform">
<div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">管理配件仓库信息</span></div>
  <div class="loginlist_right2"><strong>"更新"</strong>操作将会使您的信息靠前显示;</div>
  <div class="loginlist_right1">
  <div style="width:100%;height:29px;padding:5px 0px;">
  <a href="javascript:setFlag('0');" style="width:80px;float:left" title="批量更新信息的发布时间，以便让信息在前面显示"><img src="../images/plgx.gif" border="0"/></a>
  <a href="javascript:setFlag('1');" style="width:80px;float:left" title="批量暂停信息，以便让信息不显示"><img src="../images/plzt.gif" border="0"/></a>
  <span class="title_bar">
    <input name="add_b" type="button" class="form_button" id="add_b" value="" style="width:78px;height:29px;border:none;background:url(../images/bottom03.gif) left top no-repeat;cursor: pointer;" onclick="window.location.href='parts_store_opt.jsp'" />
  </span>
  </div>

    <table width="100%" border="0" class="list">
      <tr>
	    <th width="2%" align="center"><input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" /></td>
        <th width="2%">ID</th>
        <th width="15%">品牌</th>
        <th width="9%">编号</th>
        <th width="10%">名称</th>
        <th width="9%">价格</th>
        <th width="10%">数量</th>
        <th width="12%">所在地</th>
        <th width="10%">发布时间</th>
        <th width="11%">有效期</th>
        <th width="10%"><div align="center">操作</div></th>
      </tr>
<%
 int k=0;
 String pubdays_temp="";
 while (rs!=null && rs.next()){
   k=k+1;
   pubdays_temp = Common.getFormatStr(rs.getString("pubdays"));
%>		  
      <tr>
	  	<td height="30" align="center">
	    <input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" /></td>
        <td><%=k%></td>
        <td><%=Common.getFormatStr(rs.getString("brandname"))%></td>
        <td><%=Common.getFormatStr(rs.getString("parts_no"))%></td>
        <td><%=Common.getFormatStr(rs.getString("parts_name"))%></td>
        <td><%=Common.getFormatStr(rs.getString("price"))%></td>
        <td><%=Common.getFormatStr(rs.getString("amount"))%></td>
        <td><%=Common.getFormatStr(rs.getString("province"))%>-<%=Common.getFormatStr(rs.getString("city"))%></td>
        <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></td>
		<td><%if(pubdays_temp.equals("7")){out.print("一个周");}else if(pubdays_temp.equals("30")){out.print("一个月");}else if(pubdays_temp.equals("90")){out.print("三个月");}else if(pubdays_temp.equals("180")){out.print("半年");}else if(pubdays_temp.equals("360")){out.print("长期");}%><%if(Common.getFormatInt(rs.getString("is_pub")).equals("2"))out.print("<font color='red'>(已暂停)</font>");%></td>
        <td><div align="center"><!--<a href="javascript:otherDeleteData('../parts/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');"> 删除</a>-->  <a href="parts_store_opt.jsp?myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>">修改</a>&nbsp;&nbsp;<a href="update_pubdate.jsp?mypy=<%=Common.encryptionByDES(tablename)%>&myvalue=<%=Common.encryptionByDES(rs.getString("id"))%>&urlpath=parts_store_list.jsp">更新</a></div></td>
      </tr>
<%
}rs.close();
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
