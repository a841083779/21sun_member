<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
//===调租赁库====
PoolManager pool4 = new PoolManager(4);
Connection conn =null;

//=====页面属性====
String tablename="equipment_auction";
//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(30);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
 
StringBuffer query =new StringBuffer("select * from "+tablename+" where 1=1 ");
//得到参数 测试
String find_equipment_id=Common.getFormatInt(request.getParameter("find_equipment_id"));
if(!find_equipment_id.equals("0")){
	query.append(" and equipment_id = "+find_equipment_id);
}

String find_mem_name=Common.getFormatStr(request.getParameter("find_mem_name"));
if(!find_mem_name.equals("")){
	query.append(" and mem_name like '%"+find_mem_name+"%' ");
}
 

try{
conn = pool4.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.pagesPrint(10); //读取分页提栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script  src="../scripts/common.js"  type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
-->

</style>
</head>
<body>
<form action="" method="get" name="theform" id="theform">
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td width="23%" class="p94b">&nbsp;</td>
            <td width="65%" align="center" nowrap="nowrap"><span class="title1">竞拍人：
              <input name="find_mem_name" type="text" id="find_mem_name" value="<%=find_mem_name%>" />
              <input type="submit" name="Submit" value="查询" />
              <input type="button" name="Submit22" value="清空" onclick="javascript:clearForm()" />
              <input name="find_equipment_id" type="hidden" id="find_equipment_id" value="<%=find_equipment_id%>" />
            </span></td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
         <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="2%" height="30" align="center" bgcolor="e8f2ff"><div align="center"><strong>序</strong></div></td>
            <td width="14%" bgcolor="e8f2ff"><div align="center"><strong>型号</strong></div></td>
            <td width="12%" bgcolor="e8f2ff"><div align="center"><strong>类别</strong></div></td>
            <td width="16%" bgcolor="e8f2ff"><div align="center"><strong>品牌</strong></div></td>
            <td width="15%" bgcolor="e8f2ff"><div align="center"><strong>竞拍人</strong></div></td>
            <td width="13%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>日期</strong></span></div></td>
            <td width="11%" align="center" bgcolor="e8f2ff"><div align="center"><strong>竞拍价格</strong></div></td>
            <td width="17%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="10"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 String temp_category="0";
 while (rs!=null && rs.next()){
   k=k+1;
 temp_category=Common.getFormatInt(rs.getString("category"));
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
            <td height="30" align="center"><%=k%></td>
            <td><%=Common.getFormatStr(rs.getString("model"))%></td>
            <td><%if(temp_category.equals("1"))out.print("挖掘机");else if(temp_category.equals("2"))out.print("装载机");else if(temp_category.equals("3"))out.print("起重机");else if(temp_category.equals("4"))out.print("压路机");else if(temp_category.equals("5"))out.print("推土机");else if(temp_category.equals("6"))out.print("摊铺机");else if(temp_category.equals("7"))out.print("平地机");else if(temp_category.equals("8"))out.print("混凝土");else if(temp_category.equals("9"))out.print("其他设备");%></td>
            <td><%=Common.getFormatStr(rs.getString("brandname"))%></td>
            <td><%=Common.getFormatStr(rs.getString("mem_name"))%></td>
            <td align="center"><div align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("add_date"))%></div></td>
            <td align="center">￥<%=Common.getFormatDouble(rs.getString("price"))%></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../used/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a></span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="10"><%=bar%></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool4.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pagination=null;
	offset=null;
	query=null;
}%>
