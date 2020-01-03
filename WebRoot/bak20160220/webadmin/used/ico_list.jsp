<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="../manage/config.jsp"%>
<%
PoolManager pool4 = new PoolManager(4);
Connection conn =null;
//=====页面属性====
String tablename="map_ico";
String pageSubName = "ico_opt.jsp";
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

try{  

conn = pool4.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,2);
String bar = pagination.pagesPrint(10); //读取分页提栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
	
		<table width="98%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 20px; margin-right: 20px;">
			<tr>
				<td><input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',800,600)"/>		</td>
			</tr>
		</table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 20px; margin-right: 20px;">
          <tr>
            <td width="40%" bgcolor="e8f2ff" align="center"><strong>品牌名称</strong></td>
            <td width="40%" bgcolor="e8f2ff" align="center"><strong>图标名称</strong></td>
            <td width="20%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="8"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 String tempcategory="";
 while (rs!=null && rs.next()){
   k=k+1;
%>
          <tr <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
          	<td height="30" align="center"><%=rs.getString("brand_name")==null?"":rs.getString("brand_name") %></td>
          	<td align="center"><%=rs.getString("name")==null?"":rs.getString("name") %></td>
          	<td align="center">
          		<a href="#" onclick="openWin('<%=pageSubName%>?myvalue=<%=rs.getString("id")%>','',500,400)">修改</a>
          		<a href="javascript:otherDeleteData('../used/opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a>
          	</td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="8"><%=bar%></td>
          </tr>
        </table>
        </td>
    </tr>
  </table>
</form>
<div id="tip" style="display:none;width:100px; height:50px; position:absolute; top:0; left:0; border:3px solid #078AA6; background-color:#fff; text-align:center;"></div>
</body>
</html>
<script type="text/javascript">
<!--
jQuery(".xiangxi").hover(function(e){
		var x = e.clientX;
		var y = e.clientY;
		var tip = jQuery(this).attr("title");
		jQuery("#tip").html(tip);
		jQuery("#tip").css("top",y);
		jQuery("#tip").css("left",x);
		jQuery("#tip").show();
	},function(){
		jQuery("#tip").hide();
	});
//-->
</script>
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
