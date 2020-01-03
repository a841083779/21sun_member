<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/manage/config.jsp"%>
<% 
if(pool==null){
	pool = new PoolManager();
}
String id=request.getParameter("id");
if(id==null||id.equals(""))
{
	id="0";
}else
{
	id=Common.getFormatStr(id);/**过滤**/
}
String mypy="aboutus_resume";
String urlpath="jobs_edit.jsp";
String[][] zgs = DataManager.fetchFieldValue(pool, "aboutus_resume",
					"id,username", "1=1 order by id");		
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<title>编辑招聘信息</title>
<script type="text/javascript">
function submityn(){
	theform.submit();
}

</script>
<style>

textarea{
	BORDER-RIGHT: #B4B4B4 1px solid; 
	BORDER-TOP: #B4B4B4 1px solid; 
	FONT-SIZE: 13px; 
	BORDER-LEFT: #B4B4B4 1px solid; 
	COLOR: #000000; 
	BORDER-BOTTOM: #B4B4B4 1px solid;
	height:50px;
	overflow-y:visible; 
	word-break:break-all;
}

</style>
</head>
<body style="margin:0px;margin-left:10px;">

<form id="theform" name="theform" method="post" action="opt_save_update.jsp">
<input type="hidden" name="zd_id" value="<%=id%>">
<input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
<input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
  <table border="0" width="100%" cellpadding="0" cellspacing="0">
    <tr>
      <td width="100%">
 
  <div align="center">
    <center>
    <fieldset class="dialogblock" style="width:100%">
      <legend><span class="textbold" unselectable="on">基本信息</span></legend>
    <table border="0" cellspacing="1" width="100%" bordercolordark="#FFFFFF" class="pCC0E24" bordercolorlight="#008080" >
    <tr>
      <td width="15%" align="center"  >求职者姓名:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_username" name="zd_username" style="width:96%" Class="xmlInput textInput5" ></td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >应聘岗位:</td>
      <td width="85%"  >
      <input  type="text" value="" id="zd_position" name="zd_position" style="width:96%" Class="xmlInput textInput5" >
	</td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >年龄:</td>
      <td width="85%"  >
       <input  type="text" value="" id="zd_age" name="zd_age" style="width:96%" Class="xmlInput textInput5" >
		</td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >发布日期:</td>
      <td width="85%"  >
      <input name="zd_add_date"   type="text" id="zd_add_date"  size="21"   />
      </td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >性别:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_sex" name="zd_sex" size="6" Class="xmlInput textInput5" ></td>                       
    </tr>
     <tr>
      <td width="15%" align="center"  >学历/学位:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_education" name="zd_education" size="26" Class="xmlInput textInput5" ></td>                       
    </tr>
     <tr>
      <td width="15%" align="center"  >婚姻状况:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_marrage" name="zd_marrage" size="26" Class="xmlInput textInput5" ></td>                       
    </tr>
     <tr>
      <td width="15%" align="center"  >政治面貌:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_political" name="zd_political" size="26" Class="xmlInput textInput5" ></td>                       
    </tr>
     <tr>
      <td width="15%" align="center"  >联系方式（手机）:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_telphone" name="zd_telphone" size="26" Class="xmlInput textInput5" ></td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >电子邮箱:</td>
      <td width="85%"  ><input  type="text" value="" id="zd_email" name="zd_email" size="26" Class="xmlInput textInput5" ></td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >备注:</td>
      <td width="85%"  >	
		<textarea name="zd_remark" id="zd_remark" style="width:630px;height:100px;"></textarea>
			</td>
    </tr>
	<tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
      </div></td>
    </tr>
      </table>
    </center>
  </div>
</td>
    </tr>
  </table>
  </form>
<iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
<script   language="javascript">
function set_formxx(val){
	if(val!=null && val!=""){
	$('#getxinxi').attr("src","/webadmin/manage/set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));
	
	}
}
<%
if(!id.equals("0")){
	out.print("set_formxx(\""+id+"\");");
}
%>
</script>
</body>
</html>                    