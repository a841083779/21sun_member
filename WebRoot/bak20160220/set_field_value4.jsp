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
  if(objname!=null && objname!=""){	 
	  var col = parent.document.theform.getElementsByTagName("input");
	 // alert(col.length);
	  for (var i = 0;i < col.length;i ++ ){
		if(col[i].name == objname) {
			//alert(objname); 
		   col[i].value = newFilename;
		}  
	  } 
  }
  var objTxt = parent.document.getElementById('txt_<%=fieldName%>');
  //alert(objTxt);
  if(objTxt!=null){
  	objTxt.innerHTML = "<font color='red'>资料上传成功，<a href='"+newFilename+"' target='_blank'><font color='red'>点击此处查看资料</font></a>，<a href='#' onclick=\"reupload('"+objname+"');\"><font color='red'>点击此处重新上传</font></a>。</font>";
	parent.document.all('ifr_<%=fieldName%>').style.display='none';
	parent.document.all('txt_<%=fieldName%>').style.display='block';
  }
//  alert(parent.document.getElementById('<%=fieldName%>').value);
}

setFiledValue("<%=resourceurl%>");

</script>
</head>
<body>
</body>
</html>
