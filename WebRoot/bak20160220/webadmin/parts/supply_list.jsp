<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.util.Map.Entry"
	%><%@ include file ="/manage/config.jsp"%><%

	pool = new PoolManager(7);

Connection conn =null;
	
String tablename="supply";
String mem_flag="";
HashMap<String,String> memFlaghp = new HashMap<String,String>();

memFlaghp.put("-1","普通会员");
memFlaghp.put("1001","VIP会员");
memFlaghp.put("1002","B类会员");
memFlaghp.put("1003","A类会员");
memFlaghp.put("1004","证券咨询类会员");
memFlaghp.put("1005","租赁通(3500)");
memFlaghp.put("1006","人才网会员");
memFlaghp.put("1007","普通二手会员");
memFlaghp.put("1008","高级二手会员");
memFlaghp.put("1009","租赁站长");
memFlaghp.put("1010","配件网备备通");

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}




StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1  ");  //得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}

 String find_mem_no=Common.getFormatStr(request.getParameter("find_mem_no"));
if(!find_mem_no.equals("")){
	query.append(" and mem_no ='"+find_mem_no+"'");
}
String find_date_start=Common.getFormatStr(request.getParameter("find_date_start"));
if(!find_date_start.equals("")){
	query.append(" and CONVERT(varchar(12) ,pubdate, 23 ) >='"+find_date_start+"' ");
}
String find_date_end=Common.getFormatStr(request.getParameter("find_date_end"));
if(!find_date_end.equals("")){
	query.append(" and CONVERT(varchar(12) ,pubdate, 23 )<='"+find_date_end+"' ");
}

String find_comp_name = Common.getFormatStr(request.getParameter("find_comp_name"));
if(!find_comp_name.equals("")){
	query.append(" and comp_name like '%"+find_comp_name+"%'");
}

String find_mem_flag=Common.getFormatStr(request.getParameter("find_mem_flag"));
if(!find_mem_flag.equals("")){
	query.append(" and mem_flag ='"+find_mem_flag+"'");
}
query.append(" order by pubdate desc");
try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1);
String bar = pagination.pagesPrint(10);  //读取分页提示栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function setFlag(flag){
		if(confirm("确定这样操作吗？")){
			theform.action = "tool.jsp?flag="+flag;
			theform.target = "hiddenFrame";
			theform.method = "post";
			theform.submit();
		}
	}
</script>
<script>
//ajax删除
function deleteData(id,tablename){
	if(confirm("您确认要删除吗？")){
	var url="opt_delete.jsp?mypy="+encodeURIComponent(tablename)+"&myvalue="+encodeURIComponent(id);
		$.ajax({
			   url: url,
			   type: 'POST',
			   dataType: 'html',
			   timeout: 1000,
		       error: function(){
                 alert('执行错误!');
               },
              success: function(html){document.location.reload();
               //$(".flexme1").flexReload();
			   //alert('删除成功!');
				//document.location.reload();
              }
           });
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
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
       
        <td width="65%" align="center" nowrap="nowrap"> <span class="title1">公司名称：<input name="find_comp_name" type="text" id="find_comp_name" value="<%=find_comp_name%>" size="15" maxlength="15" />会员编号：
            <input name="find_mem_no" type="text" id="find_mem_no" value="<%=find_mem_no%>" size="15" maxlength="15" />
			会员级别：<select name="find_mem_flag" id="find_mem_flag" ><option value="">请选择会员级别</option><% for(Entry<String, String> e :  memFlaghp.entrySet()){%><option value="<%=e.getKey()%>" <%=Common.getFormatStr(e.getKey()).equals(find_mem_flag)?"selected":""%>><%=e.getValue()%></option><% } %></select>
        </span>标题：<input name="title" type="text" id="title" size="15" value="<%=title%>" />         
		  <input type="submit" name="Submit" value="查询" />
		  <input type="button" name="Submit2" value="清空" onclick="javascript:clearForm()" /></td>
        <td width="18%" align="right" class="title_bar">&nbsp;</td>
      </tr>
	  <tr><td colspan="2">
	  	 
           起止时间
	      <input name="find_date_start" type="text" id="find_date_start" size="15" value="<%=find_date_start%>" onfocus="calendar(event)"/>
          ~
          <input name="find_date_end" type="text" id="find_date_end" size="15" value="<%=find_date_end%>" onfocus="calendar(event)"/>
	  </td></tr>
    </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
			   <input type="button" id="hot" name="hot" value="批量删除" onclick="setFlag(1);"/>
              <input type="button" name="b_add" value="增加" onclick="openWin('supply_opt.jsp','sell',650,600)"/>
            </a></td>
          </tr>
        </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
		    <td width="1%" height="30" align="center" bgcolor="e8f2ff">
			  <input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
			</td>
            <td width="3%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="22%" bgcolor="e8f2ff"><strong>配件标题</strong></td>
            <td width="21%" align="center" bgcolor="e8f2ff"><div align="center"><strong>公司名称</strong></div></td>
            <td width="20%" align="center" bgcolor="e8f2ff"><strong>发布人</strong></td>
            <td width="10%" align="center" bgcolor="e8f2ff"><strong>日期</strong></td>
            <td width="8%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否显示</strong></span></div></td>
            <td width="16%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="7"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
   mem_flag = Common.getFormatStr(rs.getString("mem_flag"));
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
		    <td height="30" align="center">
				<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" />
			</td>
            <td height="30" align="center"><%=k%></td>
            <td title="<%=Common.getFormatStr(rs.getString("id"))%>"><a href="#" onclick="openWin('supply_opt.jsp?myvalue=<%=rs.getString("id")%>','',650,600)"><%=Common.getFormatStr(rs.getString("title"))%></a><font color='#FF0000'><%if(!mem_flag.equals("-1")){out.print(Common.getFormatStr(memFlaghp.get(mem_flag)));}%></font></td>
            <td align="center"><div align="center"><%=Common.getFormatStr(rs.getString("comp_name"))%></div></td>
            <td align="center"><a href="#" onclick="openWin('../member/member_opt.jsp?mem_no=<%=Common.getFormatStr(rs.getString("mem_no"))%>','',750,600)"><%=Common.getFormatStr(rs.getString("mem_no"))+"/"+Common.getFormatStr(rs.getString("mem_name"))%></a></td>
            <td align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pubdate"))%></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_pub")).equals("1")?"显示":"不显示"%></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../parts/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('supply_opt.jsp?myvalue=<%=rs.getString("id")%>','',650,600)">修改</a></span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="7"><%=bar%></td>
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
