<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*"
%>
<%
String fieldname=Common.getFormatStr(request.getParameter("fieldname"));
String flag=Common.getFormatStr(request.getParameter("flag"));
String tag=Common.getFormatStr(request.getParameter("tag"));
String urlparams="?1=1";
if(!fieldname.equals(""))
	urlparams+="&fieldname="+fieldname;
if(!flag.equals(""))
	urlparams+="&flag="+flag;
if(!tag.equals(""))
	urlparams+="&tag="+tag;
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>上传文件</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="../style/style.css">
<script>
function submitYN(){
	if(PW.file1.value==null || PW.file1.value==""){
		alert("请选择文件!");
		return false;
	} 
	//var filename = PW.file1.value;
	//if(filename.indexOf(".")==-1){
	//	alert("请选择正确的文件格式！");
	//	return false;
	//}
	//var dotindex = filename.lastIndexOf(".");
	//var ext = filename.substring(dotindex+1);
	//if(ext!="jpg"&&ext!="jepg"&&ext!="gif"&&ext!="swf"){
	//	alert("请选择正确的文件格式！");
	//	return false;
	//}
}
</script></head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2">
        <form METHOD="POST" ACTION="file_add_action.jsp<%=urlparams%>" onSubmit="return submitYN();" NAME="PW" ENCTYPE="multipart/form-data">
        <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
            <input name="fieldname" type="hidden" id="fieldname" value="<%=request.getParameter("fieldname")%>">
			<input name="flag" type="hidden" id="flag" value="10">
			<input name="tag" type="hidden" id="tag" value="<%=request.getParameter("tag")%>">
            <tr>
              <td width="2%" nowrap><!----></td>
              <td width="98%" nowrap>
				<p class="p92"><span class="font_big"><strong>选择文件：</strong></span>
                <input name="file1" type="file" id="file1">
&nbsp;&nbsp;
<input type="submit" name="Submit2" value="上传"></td>
            </tr>
            <tr>
              <td nowrap>&nbsp;</td>
              <td nowrap>&nbsp;</td>
            </tr>
        </table>
        </form>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
</body>
</html>