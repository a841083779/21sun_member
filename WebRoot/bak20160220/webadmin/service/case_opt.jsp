<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="case_opt.jsp";
String mypy="service_webcase";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));//是否刷新
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));//数据id


String urlpath="../service/case_list.jsp";


try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>成功案例发布</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script>
//ajax判断标题重复
function checkTitle(){
	var titleVal = $.trim($("#zd_title").val());
	if(titleVal!=""){
		$.ajax({
		   type: "POST",
		   url: "titleAjax.jsp",
		   data: "title="+titleVal,
		   cache:false,		   
		   success: function(msg){
		     if($.trim(msg)=="exit"){
			     alert("该标题已经存在！");
			     $('#isExist').val("fail");
			     $('#zd_title').focus(); 
		     }else if($.trim(msg)=="ok"){
		     	$('#isExist').val("ok");
		     }else if($.trim(msg)=="fail"){
		     	alert("数据传输错误，请再次尝试！");
		     }
		   }
		});
	}
}

//为多选框赋值
function submityn(){
		var titleVal = $.trim($("#zd_title").val());
		var isExist = $.trim($("#isExist").val());
		if(titleVal==""){
			alert("请输入标题！");
			$('#zd_title').focus(); 
			return false;
		}
		<%if("".equals(myvalue)) {%>
		if(isExist!="ok"){
			alert("请检查标题！");
			return false;
		}
		<%}%>
		theform.submit();
}
</script>
</head>
<body>
<form action="opt_save_update.jsp" method="post" name="theform" id="theform">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="list_border_bg">
    <tr>
      <td width="14%" height="22" align="right" class="list_left_title">标题：</td>
      <td width="86%" height="22" class="list_cell_bg"><input name="zd_title" type="text" class="required" id="zd_title" size="60" maxlength="500" <%if("".equals(myvalue)) {%>onchange="checkTitle();"<%} %>></td>
    	<input type="hidden" id="isExist" value="fail" />
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">网址：</td>
      <td height="22" class="list_cell_bg"><input name="zd_url" type="text" id="zd_url" size="60" maxlength="500"></td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">图片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img" type="text" id="zd_img" size="60" maxlength="500">
	  
	  <input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=25&dir=main&fieldname=zd_img','upload',480,150)">	  </td>
    </tr>
    <tr>
      <td height="22" align="right" class="list_left_title">发布时间：</td>
      <td height="22" class="list_cell_bg"><input name="zd_add_date" type="text" class="required" id="zd_add_date" size="60" maxlength="500" value="<%=Common.getToday("yyyy-MM-dd",0)%>"></td>
    </tr>
    <tr >
      <td height="22" align="right" nowrap class="list_left_title">是否发布：</td>
      <td height="22" class="list_cell_bg"><input name="zd_is_show" type="radio" class="form_radio" value="1" checked>
        立即发布
        <input name="zd_is_show" type="radio" class="form_radio" value="0">
        暂不发布        </td>
    </tr>
    <tr>
      <td height="22" colspan="2" align="center" bgcolor="#FFFFFF" ><input type="button" name="Submit" value="保存" onClick="submityn()">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_user" type="hidden" id="zd_add_user" value="">
         
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>">
          <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">          </td>
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
