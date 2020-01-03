<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"
	%>
<%@ include file ="/webadmin/manage/config.jsp"%>
<%
String WEBSITE_URL = "http://192.168.20.229:9110/";//"http://stock.21-sun.com/";
String catalog = Common.getFormatStr(request.getParameter("catalog"));

//===调租赁库====
if(pool == null){
	pool = new PoolManager();
}
Connection conn =null;

//=====页面属性====
String tablename="stock_webinfo";
String pageSubName="webInfo_opt.jsp?catalog="+catalog;

//======================
Pagination pagination = new Pagination();
//设置每页显示条数
pagination.setCountOfPage(10);
//分页中当前记录
String offset=Common.getFormatStr(request.getParameter("offset"));
if(offset.equals("")){
	offset="0";
}
 
StringBuffer query =new StringBuffer("select * from "+tablename+" where catalog='").append(catalog).append("'");


System.out.println(query);
try{  

conn = pool.getConnection();
//SQL查询	
ResultSet rs = pagination.getQueryResult(query.toString(), request,conn,1);
String bar = pagination.pagesPrint(10); //读取分页提栏
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="/webadmin/style/style.css" rel="stylesheet" type="text/css" />
<script src="/webadmin/scripts/jquery-1.4.1.min.js"></script>
<script  src="/webadmin/scripts/common.js"  type="text/javascript"></script>
<script  src="/webadmin/scripts/calendar.js"  type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function batchCollect(){
		var checkbox = document.getElementsByName("checkdel");
		var idArr = new Array();
		for(var i=0;i<checkbox.length;i++){
			if(checkbox[i].checked){
				idArr.push(checkbox[i].value);
			}
		}
		if(idArr.length==0){
			if(window.confirm("您没有选择类别，默认为全部！")){
				for(var i=0;i<checkbox.length;i++){
					idArr.push(checkbox[i].value);
				}
			}else{
				return false;
			}
		}
		document.getElementById("divObjection").style.display="";
		$.getJSON('<%=WEBSITE_URL%>/collect.jsp?ids='+idArr.join()+'&format=json&jsonpcallback=?',
			function(data){
				if(data.flag=="1"){
					alert("操作成功！");
					document.location.reload();
					document.getElementById("divObjection").style.display="none";
				}else{
					alert("出了点问题！");
				}
			}
		);

	}
	function batchGenerateHtml(){
		var checkbox = document.getElementsByName("checkdel");
		var dCatalogArr = new Array();
		for(var i=0;i<checkbox.length;i++){
			if(checkbox[i].checked){
				dCatalogArr.push(checkbox[i].value2);
			}
		}
		if(dCatalogArr.length==0){
			if(window.confirm("您没有选择类别，默认为全部！")){
				for(var i=0;i<checkbox.length;i++){
					dCatalogArr.push(checkbox[i].value2);
				}
			}else{
				return false;
			}
		}
		document.getElementById("divObjection").style.display="";
		$.getJSON('<%=WEBSITE_URL%>toHtml.jsp?catalog=<%=catalog%>&d_catalog='+dCatalogArr.join()+'&format=json&jsonpcallback=?',
			function(data){
				if(data.flag=="1"){
					alert("操作成功！");
					document.location.reload();
					document.getElementById("divObjection").style.display="none";
				}else{
					alert("出了点问题！");
				}
			}
		);
	}
</script>
<style type="text/css">
<!--
body {
	margin-top: 10px;
}
select {/*解决样式冲突*/
	float:none;
}
-->

</style>
</head>
<body>
<form action="" method="get" name="theform" id="theform">
<input type="hidden" name="catalog" value="<%=catalog %>"/>
  <table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="1%" class="title_bar">&nbsp;</td>
            <td width="23%" class="p94b">&nbsp;</td>
            <td width="65%" align="center" nowrap="nowrap">
            </td>
            <td width="18%" align="right" class="title_bar">&nbsp;</td>
          </tr>
        </table>
        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="15">
			    <input type="button" id="hot" name="hot" value="批量采集" onclick="batchCollect();"/>
			    <input type="button" id="hot" name="hot" value="批量生成静态页" onclick="batchGenerateHtml();"/>
				<input type="button" name="b_add" value="增加" onclick="openWin('<%=pageSubName%>','win',800,600)"/>						  
		    </td>
			  
          </tr>
        </table>
        <table width="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
		    <td width="3%" height="30" align="center" bgcolor="e8f2ff">
			  <input type="checkbox" id="checkall" name="checkall" onclick="CheckAll();" />
			</td>
            <td width="3%" height="30" align="center" bgcolor="e8f2ff"><strong>ID</strong></td>
            <td width="10%" align="center" bgcolor="e8f2ff"><strong>类别</strong></td>
            <td width="11%" align="center" bgcolor="e8f2ff"><strong>详细类别</strong></td>
            <td width="43%" align="center" bgcolor="e8f2ff"><strong>网页</strong></td>
            <td width="15%" align="center" bgcolor="e8f2ff"><strong>断点</strong></td>
            <td width="15%" align="center" bgcolor="e8f2ff"><div align="center"><span class="p92z"><strong>操作</strong></span></div></td>
          </tr>
          <tr>
            <td height="6" colspan="6"></td>
          </tr>
          <%
 int k=pagination.getCurrenPages()*pagination.getCountOfPage()-pagination.getCountOfPage();
 while (rs!=null && rs.next()){
   k=k+1;
%>
          <tr  <%=(k%2)==1?"bgcolor='#F9F9F9'":""%>>
		    <td height="30" align="center">
				<input type="checkbox" id="checkdel" name="checkdel" value="<%=Common.getFormatStr(rs.getString("id"))%>" value2="<%=Common.getFormatStr(rs.getString("d_catalog"))%>"/>
			</td>
            <td height="30" align="center"><%=k%></td>
            <td align="center"><%=StockInfoDict.getCatalogName(rs.getString("catalog"))%></td>
            <td align="center"><%=StockInfoDict.getCatalogName(rs.getString("d_catalog"))%></td>
            <td align="left"><%=Common.getFormatStr(rs.getString("website"))%></td>
			<td align="center"><%=Common.getFormatDate("yyyy-MM-dd",rs.getDate("breakpoint"))%></td>
            <td align="center"><div align="center"><span class="p92j"><a href="javascript:otherDeleteData('../opt_delete.jsp','<%=Common.encryptionByDES(rs.getString("id"))%>','<%=Common.encryptionByDES(tablename)%>');">删除</a> &nbsp;&nbsp; <a href="#" onclick="openWin('<%=pageSubName%>&myvalue=<%=rs.getString("id")%>','win',800,600)">修改</a></span></div></td>
          </tr>
          <%
}
%>
          <tr >
            <td height="30" colspan="6"><%=bar%></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
<iframe name="hiddenFrame" style="display:none"></iframe>
<div id="divObjection" style="display:none; z-index: 100; left: 25%; right:25%; position: absolute; text-align: center; width: 50%; height: 120px; border-right: #009900 1px solid; border-top: #009900 1px solid; border-left: #009900 1px solid; border-bottom: #009900 1px solid; background-color: #f9fff6;padding-top:50px">
<img src="/webadmin/stock/progress.gif"/><br>
正在处理，请稍后……
</div>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	
	conn =null;
    tablename=null;
	pageSubName=null;
	pagination=null;
	offset=null;
	query=null;
}%>
