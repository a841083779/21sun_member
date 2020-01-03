<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/manage/config.jsp"%>
<% 
if(pool==null){
	pool = new PoolManager();
}
String id=request.getParameter("id");
if(id==null||id.equals(""))
{
	id="0";
}else
{
	id=Common.getFormatStr(id);/**过滤**/
}
String mypy="aboutus_news";
String urlpath="info_edit.jsp";
 
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<title>添加新闻信息</title>
<script type="text/javascript">
function submityn(){
	theform.submit();
}

</script>
</head>
<body style="margin:0px;margin-left:10px;">

<form id="theform" name="theform" method="post" action="opt_save_update.jsp">
<input type="hidden" name="zd_id" value="<%=id%>">
<input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
<input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
    <table border="0" cellspacing="1" width="100%" bordercolordark="#FFFFFF" class="pCC0E24" bordercolorlight="#008080" >
    <tr>
      <td width="15%" align="center"  >标　　题:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_title" name="zd_title" style="width:96%" Class="xmlInput textInput5" dataType="Require" msg="新闻标题不能为空"></td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >链    接:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_url" name="zd_url" style="width:96%" Class="xmlInput textInput5" ></td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >缩 略 图:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_small_img" name="zd_small_img" style="width:76%" Class="xmlInput textInput5" readonly onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=member.21-sun.com:80&websiteId=29&dir=aboutus&fieldname=zd_small_img','upload',480,150)">
      <input type="button" name="buttton" value="上传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=member.21-sun.com:80&websiteId=29&dir=aboutus&fieldname=zd_small_img','upload',480,150)">
      </td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >发布日期:</td>
      <td width="85%"  >
      <input name="zd_pub_date"   type="text" id="zd_pub_date" value="<%= Common.getToday("yyyy-MM-dd",0)%>" size="21"   />
      </td>                       
    </tr>
	<tr>
      <td width="15%" align="center"  >摘　　要:</td>
      <td width="85%"  >
      <FCK:editor instanceName="zd_sumarry" toolbarSet="simple"  width="100%" height="300" >
			<jsp:attribute name="value">
			</jsp:attribute>
			</FCK:editor> 
      
      </td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >内    容:</td>
      <td width="85%"  >
	      <FCK:editor instanceName="zd_content" toolbarSet="simple" width="100%" height="300" >
			<jsp:attribute name="value">
			</jsp:attribute>
			</FCK:editor> 
    </tr>
	<tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
      </div></td>
    </tr>
      </table>
  </form>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","/webadmin/manage/set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
	}
}
<%
if(!id.equals("0")){
	out.print("set_formxx(\""+id+"\");");
}
%>
</script>
</body>
</html>                    