<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="manager_opt.jsp";
String mypy="admin_user";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));//是否刷新
String flag=Common.getFormatInt(request.getParameter("flag"));

String myvalue=Common.getFormatStr(request.getParameter("myvalue"));//数据id
String mem_no=Common.getFormatStr(request.getParameter("mem_no"));//会员编号

String memberSubId ="";


String urlpath="../member/manager_opt.jsp?myvalue="+myvalue;
try{//====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理员管理</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script  src="../scripts/calendar.js"  type="text/javascript"></script>
<script>
//为多选框赋值
function submityn(){
$("#zd_mem_flag_name").val($("select[name='zd_mem_flag'] option[selected]").text());
document.theform.submit();
}

function changememname()
{
$("#zd_mem_flag_name").val($("select[name='zd_mem_flag'] option[selected]").text());
}

//===删除会员====
function dodelete()
{if(confirm('是否要删除该会员?'))
 {$.get("delete_member.jsp", { id: "<%=myvalue%>"},
  function(data){
  if(data==1)
    alert("删除成功!");
	window.close();
  }); 
  }
}

</script>
<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
</head>
<body>
<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
  <input type="hidden" name="mem_no" id="mem_no" value="<%=mem_no%>">
  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="list_border_bg">
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>管理员账号：</strong></td>
      <td class="list_cell_bg"><input name="zd_usern" type="text" id="zd_usern" size="18"  >
        <span class="list_left_title">密码：
        <input name="zd_passw" type="text" id="zd_passw" size="18" >
        </span>&nbsp;&nbsp;</td>
    </tr>
    <tr>
      <td align="right" nowrap class="list_left_title">管理员名称：</td>
      <td class="list_cell_bg"><input name="zd_realname" type="text" id="zd_realname" size="18"  ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">管理员级别：</td>
      <td height="22" class="list_cell_bg"><select name="zd_mem_flag" id="zd_mem_flag" onChange="javascript:changememname()">
          <option value=""></option>
          <%=Common.option_str(pool, "manager_role","role_num,role_name"," 1=1 order by role_num", "",0)%>
        </select>
        
        
        最后登录日期：
        <input name="zd_last_date" type="text" id="zd_last_date" size="10"  ></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">状态：</td>
      <td height="22" class="list_cell_bg"><input name="zd_state" type="radio" value="1" checked />
        正常
        <input name="zd_state" type="radio" value="0" />
        禁用         
        <input name="zd_sex" type="hidden" id="zd_sex" value="1">
        <input name="zd_type" type="hidden" id="zd_type" value="3">
        <input name="zd_last_date" type="hidden" id="zd_last_date" value="3"></td>
    </tr>

    <tr>
      <td height="22" colspan="2" align="center" bgcolor="#FFFFFF" >
	  <input type="button" name="Submit" value="保存" onClick="submityn()">
	  <input name="zd_id" type="hidden" id="zd_id" value="0">
        <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
        <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
        <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>">
        <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">      </td>
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
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>
