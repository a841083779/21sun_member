<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.util.Map.Entry"
	%><%@ include file ="/manage/config.jsp"%><%

	pool = new PoolManager(1);
	
	
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
memFlaghp.put("1011","配件网专卖店");
memFlaghp.put("1012","配套网会员");

Connection conn =null;
	
String tablename="member_applyonline";

Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}

StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1");
//得到参数
String mem_name=Common.getFormatStr(request.getParameter("mem_name"));
if(!mem_name.equals("")){
	query.append(" and mem_name ='"+mem_name+"'");
}

String find_catalog_no=Common.getFormatStr(request.getParameter("find_catalog_no"));
if(!find_catalog_no.equals("")){
	query.append(" and catalog_no like '"+find_catalog_no+"%'");
}


String find_mem_flag=Common.getFormatStr(request.getParameter("find_mem_flag"));
if(!find_mem_flag.equals("")){
	query.append(" and apply_mem_flag ='"+find_mem_flag+"'");
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
<title>会员在线申请</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
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
        <td width="1%" class="title_bar">&nbsp;</td>
        <td width="23%" class="p94b">&nbsp;</td>
        <td width="65%" align="center" nowrap="nowrap"> 申请人姓名：
          <input name="mem_name" type="text" id="mem_name" size="15" value="<%=mem_name%>" />
		  会员级别：<select name="find_mem_flag" id="find_mem_flag" ><option value="">请选择会员级别</option><% for(Entry<String, String> e :  memFlaghp.entrySet()){%><option value="<%=e.getKey()%>" <%=Common.getFormatStr(e.getKey()).equals(find_mem_flag)?"selected":""%>><%=e.getValue()%></option><% } %></select>
		  <select name="find_catalog_no" id="find_catalog_no">
		  <option value="">-性质意向-</option>
		  <option value="fittings" <%if(find_catalog_no.equals("fittings"))out.print("selected");%>>配套企业库</option>
		  <option value="used" <%if(find_catalog_no.equals("used"))out.print("selected");%>>二手网</option>
		  <option value="rent" <%if(find_catalog_no.equals("rent"))out.print("selected");%>>租赁网</option>
		  <option value="parts" <%if(find_catalog_no.equals("parts"))out.print("selected");%>>配件网</option>
		
		  
		    </select>
             <input type="submit" name="Submit" value="查询" />
		  <input type="button" name="Submit2" value="清空" onclick="javascript:clearForm()" />        </td>
        <td width="18%" align="right" class="title_bar">&nbsp;</td>
      </tr>
    </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15"><!----></td>
          </tr>
        </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="3%" height="30" align="center" bgcolor="e8f2ff"><strong>序</strong></td>
            <td width="7%" bgcolor="e8f2ff"><strong>申请人</strong></td>
            <td width="23%" align="center" bgcolor="e8f2ff"><div align="center"><strong>公司名称</strong></div></td>
            <td width="24%" align="center" bgcolor="e8f2ff"><strong>联系方式/Email</strong></td>
			<td width="9%" align="center" bgcolor="e8f2ff"><strong>申请会员类别</strong></td>
            <td width="9%" align="center" bgcolor="e8f2ff"><strong>性质意向</strong></td>
            <td width="16%" align="center" bgcolor="e8f2ff"><strong>日期</strong></td>
            <td width="9%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="8"></td>
          </tr>
          <%
 int k=0;
 String tempcatalogName="";
 while (rs!=null && rs.next()){
   k=k+1;
   if(Common.getFormatStr(rs.getString("catalog_no")).indexOf("fittings")>-1)
   tempcatalogName="<font color='red'>配套企业库</font>";
   else if(Common.getFormatStr(rs.getString("catalog_no")).indexOf("used")>-1)
   tempcatalogName="二手网";
   else if(Common.getFormatStr(rs.getString("catalog_no")).indexOf("rent")>-1)
   tempcatalogName="租赁网";
   else if(Common.getFormatStr(rs.getString("catalog_no")).indexOf("parts")>-1)
   tempcatalogName="配件网";
   

%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><%=k%></td>
            <td><%=Common.getFormatStr(rs.getString("mem_name"))%></td>
            <td align="center"><div align="center"><%=Common.getFormatStr(rs.getString("comp_name"))%></div></td>
            <td align="center"><%=Common.getFormatStr(rs.getString("telephone"))%>/<%=Common.getFormatStr(rs.getString("email"))%></td>
			<td align="center"><%=Common.getFormatStr(memFlaghp.get(Common.getFormatStr(rs.getString("apply_mem_flag"))))%></td>
            <td align="center"><%=tempcatalogName%></td>
            <td align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('./opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp;</span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="8"><%=bar%></td>
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
