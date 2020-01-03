<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="../manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
	
String tablename="service_webcase";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1  ");
//得到参数
String title=Common.getFormatStr(request.getParameter("title"));
if(!title.equals("")){
	query.append(" and title like '%"+title+"%'");
}

String url=Common.getFormatStr(request.getParameter("url"));
if(!url.equals("")){
	query.append(" and url like '%"+url+"%'");
}

String find_date_start=Common.getFormatStr(request.getParameter("find_date_start"));
if(!find_date_start.equals("")){
	query.append(" and CONVERT(varchar(12) ,add_date, 23 )  >='"+find_date_start+"' ");
}

String find_date_end=Common.getFormatStr(request.getParameter("find_date_end"));
if(!find_date_end.equals("")){
	query.append(" and CONVERT(varchar(12) ,add_date, 23 ) <='"+find_date_end+"' ");
}

try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString()+" order by recommend desc,add_date desc, id desc", request,conn,1);
String bar = pagination.paginationPrint();  //读取分页提示栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>成功案例</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->
</style>
<script>
function setRec(id){
	var vv = $("#caseRec"+id).val();
	if(vv!=""){
		$.ajax({
		   type: "POST",
		   url: "recommendAjax.jsp", 
		   data: "rec="+vv+"&id="+id, 
		   cache:false,		   
		   success: function(msg){
		     if($.trim(msg)=="ok"){
			     alert("设置成功！");
			     $("#theform").submit();
		     }else if($.trim(msg)=="no"){
		     	alert("设置失败！");
		     	$("#theform").submit();
		     }else if($.trim(msg)=="fail"){
		     	alert("数据传输错误，请再次尝试！");
		     }
		   }
		});
	}
}
function check(id){
	var vv = $("#caseRec"+id).val();
	if(isNaN(vv)){
		alert("非法字符");
		$("#caseRec"+id).val("");
	}
}
function clearForm2(){
	clearForm();
	$("#theform").submit();
}

</script>
</head>
<body>
<form action="" method="get" name="theform" id="theform">
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="1%" class="title_bar">&nbsp;</td>
        <td width="88%" class="p94b" colspan="2" align="center" nowrap="nowrap">标题：
              <input name="title" type="text" id="title" size="15" value="<%=title%>" />&nbsp;
			  网址：<input name="url" type="text" id="url" size="15" value="<%=url%>" />&nbsp;
			   起止时间：
	      <input name="find_date_start" type="text" id="find_date_start" size="10" value="<%=find_date_start%>" onfocus="calendar(event)"/>
          ~
          <input name="find_date_end" type="text" id="find_date_end" size="10" value="<%=find_date_end%>" onfocus="calendar(event)"/>
              <input type="submit" name="Submit" value="查询" />
			  <input type="button" name="Submit2" value="清空" onclick="clearForm2()" />      </td>
        <td width="18%" align="right" class="title_bar">&nbsp;</td>
      </tr>
    </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
              <input type="button" name="b_add" value="增加" onclick="openWin('case_opt.jsp','sell',750,650)"/>
           </td>
          </tr>
        </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="3%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="27%" bgcolor="e8f2ff"><strong>标题</strong></td>
			<td width="30%" bgcolor="e8f2ff"><strong>网址</strong></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><strong>发布日期</strong></div></td>
            <td width="7%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>是否显示</strong></span></div></td>
            <td width="7%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>推荐</strong></span></div></td>
            <td width="14%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
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
            <td height="30" align="center"><%=k%></td>
            <td><%=Common.getFormatStr(rs.getString("title"))%></td>
			<td><%=Common.getFormatStr(rs.getString("url"))%></td>
            <td align="center"><div align="center"><%=rs.getDate("add_date")%></div></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatStr(rs.getString("is_show")).equals("1")?"显示":"不显示"%></span></div></td>
            <td align="center"><div align="center" style="width:120px;"><span class="p92j"><input type="text" style="width:50px;ime-mode:Disabled;" onkeyup='check(<%=Common.getFormatStr(rs.getString("id"))%>);' name="caseRec" id='caseRec<%=Common.getFormatStr(rs.getString("id"))%>' value='<%=Common.getFormatStr(rs.getString("recommend"))%>' />&nbsp;<input type="button" value="设定" onclick="setRec(<%=Common.getFormatStr(rs.getString("id"))%>);" /></span></div></td>
            <td align="center"><div align="center"><span class="p92j"><a href="#" onclick="openWin('case_opt.jsp?myvalue=<%=rs.getString("id")%>','sell',650,600)">修改</a>&nbsp;&nbsp; <a href="javascript:deleteData('<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="http://www.21-sun.com/service/wangzhanjianshe/caseShow.jsp?id=<%=Common.getFormatStr(rs.getString("id"))%>" target="_blank">查看位置</a></span></div></td>
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
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
}
%>
