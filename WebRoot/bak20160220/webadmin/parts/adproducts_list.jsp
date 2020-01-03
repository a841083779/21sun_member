<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/manage/config.jsp"%><%

	pool = new PoolManager(7);

Connection conn =null;
	
String tablename="ad_products_category";

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
String ads_name=Common.getFormatStr(request.getParameter("ads_name"));
if(!ads_name.equals("")){
	query.append(" and ads_name like '%"+ads_name+"%'");
}

//广告发布日期
String find_pub_date=Common.getFormatStr(request.getParameter("find_pub_date"));
if(!find_pub_date.equals("")){
	query.append(" and pub_date >= '"+find_pub_date+"'");
}
//广告结束日期
String find_end_date=Common.getFormatStr(request.getParameter("find_end_date"));
if(!find_end_date.equals("")){
	query.append(" and end_date >= '"+find_end_date+"'");
}
//====广告类型
String find_ads_type=Common.getFormatStr(request.getParameter("find_ads_type"));
if(!find_ads_type.equals("")){
	query.append(" and ads_type ='"+find_ads_type+"'");
}

try{
conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.pagesPrint(10);  //读取分页提示栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>配件产品分类管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/calendar.js"  type="text/javascript"></script>
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
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="1%" class="title_bar">&nbsp;</td>
        <td class="p94b">图片广告名称：
          <input name="ads_name" type="text" id="ads_name" size="15" value="<%=ads_name%>" />
          广告时间：
          <input name="find_pub_date" type="text" id="find_pub_date" size="10" value="<%=find_pub_date%>" onFocus="calendar(event)"/>
          截止时间：
          <input name="find_end_date" type="text" id="find_end_date" size="10" value="<%=find_end_date%>" onFocus="calendar(event)"/>
          广告类型：
          <select name="find_ads_type" id="find_ads_type">
            <option value="">--广告类型--</option>
			<option value="1" <%if(find_ads_type.equals("1"))out.print("selected");%>>购买</option>
			<option value="2" <%if(find_ads_type.equals("2"))out.print("selected");%>>赠送</option>
			<option value="3" <%if(find_ads_type.equals("3"))out.print("selected");%>>临时</option>
          </select>
<input type="submit" name="Submit" value="查询" >
            <input type="button" name="b_clear" value="清空" onclick="javascript:clearForm()" />        </td>
        </tr>
    </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
              <input type="button" name="b_add" value="增加" onclick="openWin('adproducts_opt.jsp','region',650,600)"/>
            </a></td>
          </tr>
        </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="1%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="10%" bgcolor="e8f2ff"><strong>产品分类</strong></td>
            <td width="20%" align="center" bgcolor="e8f2ff"><div align="center"><strong>广告时间/载止时间</strong>/</div></td>
            <td width="8%" align="center" bgcolor="e8f2ff"><strong>图片广告名称</strong></td>
            <td width="7%" align="center" bgcolor="e8f2ff"><strong>是否显示</strong></td>
            <td width="13%" align="center" bgcolor="e8f2ff"><strong>公司名称</strong></td>
            <td width="12%" align="center" bgcolor="e8f2ff"><div align="center"><strong><span class="p92z">是否显示</span></strong></div></td>
            <td width="10%" align="center" bgcolor="e8f2ff"><div align="center"><strong>首页推荐</strong></div></td>
            <td width="19%" align="center" bgcolor="e8f2ff"><div align="center"><strong><span class="p92z">操作</span></strong></div></td>
          </tr>
          <tr>
            <td height="6" colspan="11"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;

%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><%=k%></td>
            <td><%=Common.getFormatStr(rs.getString("categoryname"))%>/<%=Common.getFormatStr(rs.getString("subcategoryname"))%></td>
            <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("pub_date"))%>/<%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("end_date"))%></div></td>
            <td align="left"><%=Common.getFormatStr(rs.getString("ads_name"))%></td>
            <td align="center"><%=Common.getFormatInt(rs.getString("ads_isshow")).equals("1")?"是":"否"%></td>
            <td align="left"><%=Common.getFormatStr(rs.getString("comp_name"))%></td>
            <td align="center"><div align="center"><span class="p92j"><%=Common.getFormatInt(rs.getString("comp_isshow")).equals("1")?"是":"否"%></span></div></td>
            <td align="center"><%=Common.getFormatInt(rs.getString("index_recom")).equals("1")?"是":"否"%></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../parts/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('adproducts_opt.jsp?myvalue=<%=rs.getString("id")%>','region',650,600)">修改</a></span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="11"><%=bar%></td>
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
