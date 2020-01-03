<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="manager_role_opt.jsp";
String mypy="manager_role";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));//是否刷新
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));//数据id


String urlpath="../member/manager_role_list.jsp";


try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理员角色管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script>
//为多选框赋值
function submityn(){
		

			
		theform.submit();
}
</script>
</head>
<body>
<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="list_border_bg">
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>角色编号：</strong></td>
      <td class="list_cell_bg"><input name="zd_role_num" type="text" id="zd_role_num" size="16"  ></td>
    </tr>

        <td height="22" align="right" nowrap class="list_left_title">角色名称：</td>
          <td height="22" class="list_cell_bg"><input name="zd_role_name" type="text" id="zd_role_name" size="38" ></td>
    </tr>
 
    <tr>
      <td height="22" colspan="2" align="center" bgcolor="#FFFFFF" ><input type="button" name="Submit" value="保存" onClick="submityn()">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="urlpath" type="hidden" id="urlpath" value="/webadmin/member/manager_role_opt.jsp?myvalue=<%=myvalue%>">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          </td>
    </tr>
  </table>
</form>
  <iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
  <script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","../manage/set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));	
	}
}
<%
if(!myvalue.equals("")){
	out.print("set_formxx(\""+myvalue+"\");");
}
%>
</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>
