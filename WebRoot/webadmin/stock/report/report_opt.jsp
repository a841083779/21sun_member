<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/webadmin/manage/config.jsp"%>
<%
String catalog = Common.getFormatStr(request.getParameter("catalog"));
//=====页面属性====
String pagename="report_opt.jsp";
String mypy="stock_report";
String titlename="报告";

//====得到参数====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));
String urlpath="/webadmin/stock/report/report_opt.jsp";
if(!myvalue.equals("0"))
urlpath=urlpath+"?myvalue="+myvalue;

HashMap map = new HashMap();
Connection conn = null;
try{//====标题的名称====
	if(!myvalue.equals("0")){
		conn = pool.getConnection();
		ResultSet rs = DataManager.executeQuery(conn,"select id,stock_code,title,content,catalog,pdf,pdf_code,convert(varchar(10),pub_date,23) as pub_date from stock_report where id="+myvalue);
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
	if($("#zd_stock_code").val()==""){
			alert("请输入相关股票！");
			$("#zd_stock_code").focus();
			return false;
	}
	if($("#zd_title").val()==""){
			alert("请输入标题！");
			$("#zd_title").focus();
			return false;
	}else if($("#zd_pub_date").val()==""){
			alert("请输入发布日期！");
			$("#zd_pub_date").focus();
			return false;
	}else if($("#zd_report").val()==""){
			alert("请上传报告！");
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
      <td align="right" nowrap class="list_left_title"><strong>类别：</strong></td>
      <td class="list_cell_bg">
      <%
      	String[][] dCatalog = DataManager.fetchFieldValue(pool,"stock_dict","code,name","parent='report'");
      	for(int i=0;i<dCatalog.length;i++){
      		%>
      		<input name="zd_catalog" type="radio" value="<%=dCatalog[i][0] %>" <%if(Common.getFormatStr(map.get("catalog")).equals(dCatalog[i][0])){ %>checked<%}%>><%=dCatalog[i][1] %>
      		<%
      	}
      %>
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>相关股票：</strong></td>
      <td class="list_cell_bg"><input name="zd_stock_code" type="text" id="zd_stock_code" style="width:100px" maxlength="6" class="required" value="<%=Common.getFormatStr(map.get("stock_code")) %>">
       <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>标题：</strong></td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" style="width:300px" maxlength="50" class="required" value="<%=Common.getFormatStr(map.get("title")) %>">
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>发布日期：</strong></td>
      <td class="list_cell_bg"><input name="zd_pub_date" type="text" id="zd_pub_date" style="width:120px" readonly class="required" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<%=Common.getFormatStr(map.get("pub_date")) %>">
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title"><strong>报告：</strong></td>
      <td height="22" class="list_cell_bg">
      <input name="zd_pdf" type="text" id="zd_pdf" size="60" maxlength="100" value="<%=Common.getFormatStr(map.get("pdf")) %>" readonly>
      <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=28&dir=stock&fieldname=zd_pdf','upload',480,150)" ></td>
      </td>
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
          
		  
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="zd_add_user" type="hidden" id="zd_add_user" value="<%=usern%>">
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
titlename=null;
urlpath=null;
}
%>
