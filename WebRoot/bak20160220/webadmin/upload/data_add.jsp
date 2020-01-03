<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,jereh.web21sun.database.*,jereh.web21sun.util.*,jereh.web21sun.action.*"
	%><html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>上传资料</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css" />
<script>
function submitYN(){
	if(PW.file1.value==null || PW.file1.value==""){
		alert("请选择文件!");
		return false;
	}else{
	PW.action="data_add_action.jsp?title="+encodeURIComponent(PW.title.value);
	PW.submit();
	}
}
</script>
</head>
<body> <form METHOD="POST" ACTION="data_add_action.jsp" onSubmit="return submitYN();" NAME="PW" ENCTYPE="multipart/form-data">
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="32" align="right" class="font_big"><strong>资料名称：</strong></td>
        <td height="32" class="font_big"><input name="title" type="text" id="title" size="30" maxlength="200" >       </td>
      </tr>
      <tr>
        <td height="32" class="font_big"><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
         
		  <input name="websiteID" type="hidden" id="flag" value="<%=request.getParameter("websiteID")%>">
            <tr>
              <td align="right" nowrap><p class="font_big"><strong>选择文件：                </strong></p>              </td>
            </tr>
         
        </table></td>
        <td height="32" class="font_big"><input name="file1" type="file" id="file1">
&nbsp;&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2"><span class="font_big">
          <input type="submit" name="Submit2" value="上  传">
        </span></td>
      </tr>
  </table> 
</form>
</body>
</html>