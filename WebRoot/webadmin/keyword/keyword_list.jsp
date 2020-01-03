<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="../manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
	
String tablename="keyword_search";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 ");
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function setFlag(flag,tableName){
		var arr = document.getElementsByName("checkdel");
		var state = 0;
		for(var i=0;arr!=null && arr.length>0 && i<arr.length;i++){
			if(arr[i]!=null && arr[i].checked){
				state = 1;
				break;
			}
		}
		if(state == 0){
			alert("请先选择您要删除的信息！");
			return false;
		}
		
		if(confirm("确定要删除选中的信息吗？")){
			theform.action = "tool.jsp?flag="+flag+"&tableName="+tableName;
			theform.target = "hiddenFrame";
			theform.method = "post";
			theform.submit();
		}
	}
</script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style></head>
<body>
<form action="" method="get" name="theform" id="theform">
  <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td width="23%" class="p94b">&nbsp;</td>
            <td width="65%" align="center" nowrap="nowrap"> 关键词：
              <input name="title" type="text" id="title" size="15" value="<%=title%>" />
                <input type="submit" name="Submit" value="搜索"  />
                <input type="button" name="Submit2" value="清空"  onclick="javascript:clearForm()" />
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
          <table width="100%"  border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td height="15">
				<input type="button" id="detele" name="hot" value="批量删除" onclick="setFlag(0,'keyword_search');" style="cursor:pointer"/>
				<input type="button" name="b_add" value="增加" onclick="openWin('keyword_opt.jsp','sell',650,600)" style="cursor:pointer"/>
				</td>
            </tr>
			<!--
			<tr style="padding-top:10px">
				<td>
					<input type="button" id="hot" name="hot" value="设为热点" onclick="setFlag(1);"/>
					<input type="button" id="sell" name="sell" value="最新供应" onclick="setFlag(2);"/>
					<input type="button" id="buy" name="buy" value="最新求购" onclick="setFlag(3);"/>
				</td>
			</tr>
			-->
          </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
			  <td width="5%" height="30" align="center" bgcolor="e8f2ff">
			  	<input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
			  </td>
              <td width="5%" height="30" align="center" bgcolor="e8f2ff"><strong>序号</strong></td>
              <td width="34%" bgcolor="e8f2ff"><strong>关键词</strong></td>
			  <td width="12%" bgcolor="e8f2ff"><strong>增加日期</strong></td>
			  <td width="20%" bgcolor="e8f2ff"><strong>增加IP</strong></td>
			  <td width="9%" bgcolor="e8f2ff"><strong>点击量</strong></td>
              <td width="20%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
            </tr>
            <tr>
              <td height="6" colspan="5"></td>
            </tr>
            <%
			 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
			 while (rs!=null && rs.next()){
			   k=k+1;
			%>
            <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
			  <td height="30" align="center">
			  	<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />
			  </td>
              <td height="30" align="center"><%=k%></td>
              <td><a href="#" onclick="openWin('keyword_opt.jsp?myvalue=<%=rs.getString("id")%>','sell',650,600)"><%=Common.getFormatStr(rs.getString("title"))%></a></td>
			  <td><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></td>
			  <td><a href="http://ip138.com/ips.asp?ip=<%=Common.getFormatStr(rs.getString("add_ip"))%>" target="_blank"><%=Common.getFormatStr(rs.getString("add_ip"))%></a></td>
			  <td><%=Common.getFormatStr(rs.getString("view_count"))%></td>
              <td align="center"><div align="center"><span class="p92j"><a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('keyword_opt.jsp?myvalue=<%=rs.getString("id")%>','sell',650,600)">修改</a> &nbsp;&nbsp; <a href="javascript:window.location.href='keyword_title_list.jsp?parentId=<%=rs.getString("id")%>&parentKeyword='+encodeURIComponent('<%=rs.getString("title")%>');">相关信息</a></span></div></td>
            </tr>
            <%
}
%>
            <tr >
              <td height="30" colspan="5"><%=bar%></td>
            </tr>
        </table></td>
    </tr>
  </table>
</form>
<iframe name="hiddenFrame" style="display:none"></iframe>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
