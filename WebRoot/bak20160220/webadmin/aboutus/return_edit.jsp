<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
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
String mypy="aboutus_zw_return";
 
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<title>岗位类别信息管理</title>
<script type="text/javascript">
function submityn(){
	theform.submit();
}
 
</script>
</head>
<body style="margin:0px;margin-left:10px;">

<form id="theform" name="theform" method="post" action="opt_save_update.jsp">
<input type="hidden" name="zd_id" value="<%=id%>">
<input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
  <table border="0" width="100%" cellpadding="0" cellspacing="0">
    <tr>
      <td width="100%">
 
  <div align="center">
    <center>
    <fieldset class="dialogblock" style="width:100%">
      <legend><span class="textbold" unselectable="on">基本信息</span></legend>
    <table border="0" cellspacing="1" width="100%" bordercolordark="#FFFFFF" class="pCC0E24" bordercolorlight="#008080" >
    <tr>
      <td width="15%" align="center"  >应聘人:</td>
      <td width="85%"  ><input type="text" name="zd_name" id="zd_name" class="st1" /></td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >上传时间:</td>
      <td width="85%"  ><input type="text" name="zd_add_date" id="zd_add_date" class="st1" /></td>                       
    </tr>
    <tr>
        <td width="15%" align="center"   >性别：</td>
        <td>
		<select name="zd_sex" id="zd_sex" >
			<option value="1">男</option>
			<option value="0">女</option>
		</select>
		</td>
      </tr>
    <tr>
      <td width="15%" align="center"  >学历:</td>
      <td width="85%"  >
		<select name="zd_xueli" id="zd_xueli" class="st2">
          <option value="1">高中</option>
          <option value="2">中专</option>
          <option value="3">大专</option>
          <option value="4">本科</option>
          <option  value="5">研究生</option>
        </select>
		</td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >工作经验:</td>
      <td width="85%"  ><textarea name="zd_jingyan" id="zd_jingyan" cols="75" rows="6" class="st3"></textarea></td>                       
    </tr>
    <tr>
      <td width="15%" align="center"  >所在地:</td>
      <td width="85%"  ><input type="text" name="zd_place" id="zd_place" class="st1"></td>                       
    </tr>
     <tr>
        <td width="15%" align="center"  >工作能力：</td>
        <td><textarea name="zd_nengli" id="zd_nengli" cols="75" rows="6" class="st3"></textarea></td>
      </tr>
    <tr>
      <td width="15%" align="center"  >简历:</td>
      <td width="85%"  ><input name="zd_filepath" id="zd_filepath" class="st1" readonly="readonly" onclick="window.open(this.value)">(单击查看)</td>                       
    </tr>
	 
	<tr >
      <td height="30px" class="list_left_title" align="center" colspan="2"><div align="center">
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