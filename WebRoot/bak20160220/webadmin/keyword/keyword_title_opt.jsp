<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="../manage/config.jsp"%>
<%if(pool==null){
	pool = new PoolManager();
}

//=====页面属性====
String pagename="keyword_title_opt.jsp";
String mypy="keyword_search_title";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));


String urlpath="../keyword/keyword_title_list.jsp";


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
			alert("请输入标题！");
			theform.zd_title.focus();
			return false;
		}else if(theform.zd_url.value==""){
			alert("请输入链接地址！");
			theform.zd_url.focus();
			return false;
		}else if(theform.zd_summary.value==""){
			alert("请输入描述，内容控制在300个汉字以内！");
			theform.zd_summary.focus();
			return false;
		}else if(theform.zd_company.value==""){
			alert("请输入公司名称！");
			theform.zd_company.focus();
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
      <td align="right" nowrap class="list_left_title"><strong>标　　题：</strong></td>
      <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" >
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">描　　述：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_summary" cols="50" rows="8" id="zd_summary" onKeyUp="if((this.value).length>300){ this.value=(this.value).substr(0,300);alert('描述请控制在300个汉字以内。');}"></textarea>
        <font color="#FF0000">*</font></td>
    </tr>
	<tr>
      <td align="right" nowrap class="list_left_title"><strong>所属公司：</strong></td>
      <td class="list_cell_bg"><input name="zd_company" type="text" id="zd_company" size="60" maxlength="40" >
        <font color="#FF0000">*</font></td>
    </tr>
	 <tr>
      <td align="right" nowrap class="list_left_title"><strong>url：</strong></td>
      <td class="list_cell_bg"><input name="zd_url" type="text" id="zd_url" size="60" maxlength="40" >
        <font color="#FF0000">*</font></td>
    </tr>
	  <tr>
      <td height="22" align="right" nowrap class="list_left_title">图　　片：</td>
      <td height="22" class="list_cell_bg"><input name="zd_img" type="text" id="zd_img" size="50" maxlength="40">
<input name="selectimg" type="button" class="form_button" id="selectimg" value="上 传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=<%=request.getServerName()+":"+request.getServerPort()%>&websiteId=25&dir=main&fieldname=zd_img','upload',480,150)"></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">发布日期：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_pub_date" name="zd_pub_date" value="<%=Common.getToday("yyyy-MM-dd",0)%>" size="20" maxlength="20"/></td>
      </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">有效日期至：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_valid_date" name="zd_valid_date" value="<%=Common.getToday("yyyy-MM-dd",6)%>" size="20" maxlength="20"/></td>
      </td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">类型：</td>
      <td height="22" class="list_cell_bg"><input type="checkbox" id="type" name="type" value="1">
        供求
        <input type="checkbox" id="type" name="type" value="2">
        二手
		<input type="checkbox" id="type" name="type" value="3">
        租赁 
		<input type="checkbox" id="type" name="type" value="4">
        配件
		</td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">是否显示：</td>
      <td height="22" class="list_cell_bg"><input type="radio" id="zd_is_show1" name="zd_is_show" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_show2" name="zd_is_show" value="2">
        否 </td>
    </tr>
	<tr>
      <td align="right" nowrap class="list_left_title"><strong>点击量：</strong></td>
      <td class="list_cell_bg"><input name="zd_view_count" type="text" id="zd_view_count" size="20" maxlength="40" ></td>
    </tr>
	<tr>
      <td align="right" nowrap class="list_left_title"><strong>序号：</strong></td>
      <td class="list_cell_bg"><input name="zd_order_no" type="text" id="zd_order_no" size="20" maxlength="40" ></td>
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
		  <input name="zd_keyword" type="hidden" id="zd_keyword" value="<%=Common.getFormatStr(request.getParameter("parentKeyword"))%>">
		   <input name="zd_keyword_id" type="hidden" id="zd_keyword_id" value="<%=Common.getFormatStr(request.getParameter("parentId"))%>">
		   
		   <input type="hidden" id="zd_type" name="zd_type" value=""/>
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
