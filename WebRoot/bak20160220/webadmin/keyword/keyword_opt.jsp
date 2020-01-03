<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="keyword_opt.jsp";
String mypy="keyword_search";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));


String urlpath="../keyword/keyword_list.jsp";


try{//====标题的名称====

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>供求发布</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}

//为多选框赋值
function submityn(){
		
		if(theform.zd_title.value==""){
			alert("请输入关键词！");
			theform.zd_title.focus();
			return false;
		}else{
		      //判断多选框是否选择
			  var checkdel = document.getElementsByName('type');
			  var checkedFlag=false;
				for(i=0;i<checkdel.length;i++){
				   if(checkdel[i].checked){
					checkedFlag = true;
				  }
			    }
		     if(checkedFlag){
					var chs = new Array();
					$("input[type=checkbox]:checked").each(function(){
					chs.push($(this).val());
					});
				   theform.zd_type.value= chs.toString();
				   theform.zd_type_str.value= chs.toString().replace('1','供求').replace('2','二手').replace('3','租赁').replace('4','配件');
			 }else{
			     alert("请选择分类！");
				 return false;
			 }		
		}
		theform.submit();
}
</script>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="15"><span class="p982"><span class="pblue1">红色</span><font color="#FF0000">*</font><span class="pblue1">为必填项</span></span></td>
  </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
    <tr>
      <td align="right" nowrap class="list_left_title"><strong>关键词：</strong></td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" >
        <font color="#FF0000">*</font></td>
    </tr>
	<tr>
      <td align="right" nowrap class="list_left_title"><strong>点击量：</strong></td>
      <td class="list_cell_bg"><input name="zd_view_count" type="text" id="zd_view_count" size="60" maxlength="40" value="0">
        <font color="#FF0000">*</font></td>
    </tr>
	
	<tr>
      <td height="22" align="right" nowrap class="list_left_title">分类：</td>
      <td height="22" class="list_cell_bg"><table border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><input type="checkbox" id="type" name="type" value="1">供求</input></td>
            <td><input type="checkbox" id="type" name="type" value="2">二手</input></td>
            <td><input type="checkbox" id="type" name="type" value="3">租赁</input></td>
			<td><input type="checkbox" id="type" name="type" value="4">配件</input></td>
          </tr>
		  <input type="hidden" id="zd_type" name="zd_type" value=""/>
		  <input type="hidden" id="zd_type_str" name="zd_type_str" value=""/>
        </table></td>
    </tr>
	
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn()">
          <input name="zd_id" type="hidden" id="zd_id" value="0">
          <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
          <input name="zd_add_user" type="hidden" id="zd_add_user" value="">
          <input name="zd_add_date" type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
          <input name="zd_add_ip" type="hidden" id="zd_add_ip" value="<%=Common.getRemoteAddr(request,1)%>">
          <input name="myvalue" type="hidden" id="myvalue" value='<%=myvalue%>'>
          <input name="isReload" type="hidden" id="isReload" value="<%=isReload%>">
          <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
          <input name="randflag" type="hidden" id="randflag" value="1">
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
