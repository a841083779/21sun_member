<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
String resourceurl=(String)request.getParameter("resourceurl");
String fieldName=(String)request.getParameter("fieldName");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="/webadmin/style/oper_area_style.css" rel="stylesheet" type="text/css">
<script  src="/webadmin/scripts/prototype.js"  type="text/javascript"></script>
<script  src="/webadmin/scripts/common.js" type="text/javascript"></script>
<script language="javascript">
function setFiledValue(newFilename)
{
  newFilename = "http://resource.21-sun.com"+newFilename;
  var objname = "<%=fieldName%>";
  //alert(newFilename);
  //alert(parent.document.getElementById('txtUrl'));
  if(objname==null || objname==""){	 
	   var target_field = opener.document.getElementById('txtUrl');	  
	   //alert(target_field);
	   target_field.value = newFilename;  
	   opener.previewI_F();
  }else{
	  var col = opener.document.theform.getElementsByTagName("input");
	  for (var i = 0;i < col.length;i ++ ){
		if(col[i].name == objname) { 
		   col[i].value = newFilename;
		}  
	  }  
  }
  window.close();
}
setFiledValue("<%=resourceurl%>");
</script>
</head>
<body>
</body>
</html>
