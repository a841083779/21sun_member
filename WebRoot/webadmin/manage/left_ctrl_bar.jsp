<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>left_ctrl</title>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	background-image: url(../images/admin/fw_left_view_ctrl_bg.gif);
}
-->
</style></head>
<script>
<!--

function closeoropen() {
	if (document.all('ifclose').style.display=="none") {
		document.all('ifclose').style.display="";
		document.LeftOrRight.src="../images/left.gif";
		top.extend();
	}else{
		document.all('ifclose').style.display="none";
		document.LeftOrRight.src="../images/right.gif";
		top.closeFrame();	
	}
}


function closeoropen2() {
	if (document.all('ifclose').style.display=="none") {
		document.all('ifclose').style.display="";
		document.LeftOrRight.src="../style/yellow/images/munu/GoRight.gif";
		top.extend();
	}
}

</script>
<body>
<table width="8" height="100%" border="0" cellpadding="0" cellspacing="0" background="../images/admin/fw_left_view_ctrl_bar_bg.gif">
  <tr> 
    <td height="21" align="center" valign="top" background="../images/admin/fw_left_view_ctrl_bg.gif">&nbsp;</td>
  </tr>
  <tr>
    <td align="center"><img src="../images/admin/fw_left_view_ctrl_bar_hiddenleft.gif" width="5" height="51" name='LeftOrRight' onClick="top.showOrHiddenMenuFrame(this)" style="cursor:hand"></td>
  </tr>
</table>
</body>
</html>
