<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/webadmin/manage/config.jsp"%>
<%
String catalog = Common.getFormatStr(request.getParameter("catalog"));
//=====页面属性====
String pagename="info_opt.jsp";
String mypy="stock_info";
String titlename=StockInfoDict.getCatalogName(catalog);

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));
String urlpath="/webadmin/stock/info/info_opt.jsp";
if(!myvalue.equals("0"))
urlpath=urlpath+"?myvalue="+myvalue;

HashMap map = new HashMap();
Connection conn = null;
try{//====标题的名称====
	if(!myvalue.equals("0")){
		conn = pool.getConnection();
		ResultSet rs = DataManager.executeQuery(conn,"select * from stock_info where id="+myvalue);
		if(rs!=null && rs.next()){
			ResultSetMetaData meta = rs.getMetaData();
			for(int i=1;i<=meta.getColumnCount();i++){
				map.put(meta.getColumnName(i),rs.getString(meta.getColumnName(i)));
			}
		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=titlename%></title>
<link href="/webadmin/style/style.css" rel="stylesheet" type="text/css" />
<script src="/webadmin/scripts/jquery-1.4.1.min.js"></script>
<script src="/webadmin/scripts/common.js"  type="text/javascript"></script>
<script src="/webadmin/scripts/My97DatePicker/WdatePicker.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

function submityn(){
/*
	var catalog = document.getElementsByName("zd_catalog");
	var cc = 0;
	for(var i=0;i<catalog.length;i++){
		if(catalog[i].checked){
			cc ++;
		}
	}
	if(cc == 0){
		alert("请选择类别！");
		return false;
	}
*/
	if($("#zd_stock_code").val()==""){
			alert("请输入股票代码！");
			$("#zd_stock_code").focus();
			return false;
	}
		var d_catalog = document.getElementsByName("zd_d_catalog");
		var cc = 0;
		for(var i =0;i<d_catalog.length;i++){
			if(d_catalog[i].checked){
				cc ++;
			}
		}
		if(cc == 0){
			alert("请选择类别！");
			return false;
		}

		var content =FCKeditorAPI.GetInstance("zd_content").GetXHTML(); 
		if(content==null||content==""){
			alert("内容不能为空");
			return false;
		} 

	document.theform.submit();
}

</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="15"><span class="p982"><span class="pblue1">红色</span><font color="#FF0000">*</font><span class="pblue1">为必填项</span></span></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform" >
    <tr>
      <td align="right" nowrap class="list_left_title" width="10%"><strong>股票代码：</strong></td>
      <td class="list_cell_bg"><input name="zd_stock_code" type="text" id="zd_stock_code" style="width:100px" maxlength="50" class="required" value="<%=Common.getFormatStr(map.get("stock_code")) %>">
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>类型：</strong></td>
      <td class="list_cell_bg">
      <%
      	String[][] dCatalog = DataManager.fetchFieldValue(pool,"stock_dict","code,name","parent='"+catalog+"'");
      	for(int i=0;i<dCatalog.length;i++){
      		%>
      		<input name="zd_d_catalog" type="radio" value="<%=dCatalog[i][0] %>" <%if(Common.getFormatStr(map.get("d_catalog")).equals(dCatalog[i][0])){ %>checked<%}%>><%=dCatalog[i][1] %>
      		<%
      	}
      %>
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>内容：</strong></td>
      <td class="list_cell_bg">
      	<FCK:editor instanceName="zd_content" toolbarSet="simple" width="100%" height="380">
          <jsp:attribute name="value"><%=Common.getFormatStr(map.get("content"))%></jsp:attribute>
        </FCK:editor>
        <font color="#FF0000">*</font></td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" value="保存" onClick="submityn();">
          
		  
          <input name="zd_id" type="hidden" id="zd_id" value="<%=Common.getFormatStr(map.get("id")).equals("")?"0":Common.getFormatStr(map.get("id"))%>">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="zd_add_user" type="hidden" id="zd_add_user" value="<%=usern%>">
          <input name="zd_catalog" type="hidden" id="zd_catalog" value="<%=catalog%>">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
		  </div></td>
    </tr>
  </form>
</table>
<table width="98%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="10"></td>
  </tr>
</table>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
	}
}
<%
if(!myvalue.equals("0")){
//	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
if(conn!=null){
	pool.freeConnection(conn);
}
titlename=null;
urlpath=null;
}
%>
