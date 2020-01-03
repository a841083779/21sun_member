<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="../manage/config.jsp"%>
<%
	pool = new PoolManager(5);

//=====页面属性====
String pagename="question_opt.jsp";
String mypy="question";
String titlename="";

//====得到参数====
String isReload=Common.getFormatInt(request.getParameter("isReload"));
String flag=Common.getFormatInt(request.getParameter("flag"));
String myvalue=Common.getFormatStr(request.getParameter("myvalue"));
String urlpath="../market/question_list.jsp";
try{//====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>建议管理</title>
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
		
		var obj2 = document.getElementsByName("product_flag");
		var productFlagValue = ",";
		for(var i=0;i<obj2.length;i++){
			if(obj2[i].checked){
				productFlagValue += obj2[i].value+",";
			}
		}
		if(productFlagValue==",") productFlagValue="";
		theform.zd_product_flag.value = productFlagValue;	
		
		if(theform.zd_title.value==""){
			alert("请输入标题！");
			theform.zd_title.focus();
			return false;
		}else if(theform.zd_city.value==""){
			alert("请选择省市！");
			theform.zd_city.focus();
			return false;
		}else if(returnRadio("zd_market_flag")==false){
			alert("请选择业务分类！");
			theform.zd_market_flag.focus();
			return false;
		}else if(returnRadio("zd_business_flag")==false){
			alert("请选择交易目的！");
			theform.zd_business_flag.focus();
			return false;			
		}else if(theform.zd_product_flag.value==""){
			alert("请选择产品分类！");
			theform.zd_product_flag.focus();
			return false;
		}else if(theform.zd_descr.value==""){
			alert("请输入描述，内容控制在300个汉字以内！");
			theform.zd_descr.focus();
			return false;
		}
			
		theform.submit();
}
</script>
</head>
<body>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="list_border_bg">
  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
      <tr>
      <td height="22" align="right" nowrap class="list_left_title">添加日期：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_add_date" name="zd_add_date" value="" size="20" maxlength="20"  readonly="true" /></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">添加者IP：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_add_ip" name="zd_add_ip" value="" size="20" maxlength="20"  readonly="true" /></td>
    </tr>
    <tr>
      <td height="22" align="right" nowrap class="list_left_title">添加者姓名：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_mem_name" name="zd_mem_name" value="" size="20" maxlength="20"  readonly="true" /></td>
    </tr>
      <tr>
      <td height="22" align="right" nowrap class="list_left_title">电&nbsp;&nbsp;&nbsp;&nbsp;话：</td>
      <td height="22" class="list_cell_bg"><input type="text" id="zd_tel" name="zd_tel" value="" size="20" maxlength="20"  readonly="true" /></td>
    </tr>
    <tr>
     <td height="22" align="right" nowrap class="list_left_title">建&nbsp;&nbsp;&nbsp;&nbsp;议：</td>
      <td height="22" class="list_cell_bg"><textarea name="zd_descr" cols="30" rows="8" id="zd_descr" ></textarea>
    </td>
    </tr>
    <tr><td colspan="4"><hr/></td></tr>
     <tr>
      <td height="22" align="right" nowrap class="list_left_title">  <input type="button" name="Submit" value="关闭" onClick="closwin();"></td>
    </tr>
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
	$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
	}
}
function closwin(){
  window.opener = null  ;
  window.close() ;
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
