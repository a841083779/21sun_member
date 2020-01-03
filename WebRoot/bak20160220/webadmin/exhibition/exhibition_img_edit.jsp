<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<% 
if(pool==null){
	pool = new PoolManager();
}
String id=Common.getFormatInt(request.getParameter("id"));
if(id==null||id.equals(""))
{
	id="0";
}else
{
	id=Common.getFormatInt(Common.getFormatStr(id));/**过滤**/
}
String mypy="exhibition_bobao";
String urlpath="exhibition_img_edit.jsp";
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<title>添加新闻信息</title>
<script type="text/javascript">
//返回字节数，区分中英文字符
function checkLength(inputStar) {
 var bytesCount = 0;
 for (var i = 0; i < inputStar.length; i++) {
  var c = inputStar.charAt(i);
  if (/^[\u0000-\u00ff]$/.test(c)) {
   bytesCount += 1;
  }
  else {
   bytesCount += 2;
  }
 }
 return bytesCount/2;
}

function submityn(){
	var zd_title = document.getElementById("zd_title").value;
    var zd_sub_title = document.getElementById("zd_sub_title").value;

	theform.submit();
}

</script>
</head>
<body style="margin:0px;margin-left:10px;">
<form id="theform" name="theform" method="post" action="opt_save_update.jsp">
  <input type="hidden" name="zd_id" value="<%=id%>">
  <input name="mypy" type="hidden" id="mypy" value="<%=Common.encryptionByDES(mypy)%>">
  <input name="urlpath" type="hidden" id="urlpath" value="<%=urlpath%>">
  <input name="zd_pub_date" type="hidden" id="zd_pub_date" value="<%= Common.getToday("yyyy-MM-dd",0)%>"/>
  <table border="0" cellspacing="1" width="100%" bordercolordark="#FFFFFF" class="pCC0E24" bordercolorlight="#008080" >
    <tr>
      <td width="15%" align="center"  >标　题：</td>
      <td colspan="3"  ><input name="zd_title"  type="text" Class="xmlInput textInput5" id="zd_title" value="" size="50" dataType="Require" msg="新闻标题不能为空"> </td>
    </tr>
    <tr>
      <td width="15%" align="center"  >链    接：</td>
      <td width="85%"  ><input name="zd_url"  type="text"  Class="xmlInput textInput5" id="zd_url" value="" size="50" ></td>
    </tr>
    <tr>
      <td align="center">短标题：</td>
      <td  ><input name="zd_sub_title"  type="text" Class="xmlInput textInput5" id="zd_sub_title" value="" size="50"  ></td>
    </tr>
    <tr>
      <td width="15%" align="center"  >缩 略 图：</td>
      <td width="85%"  ><input name="zd_img"  type="text" Class="xmlInput textInput5" id="zd_img" value="" size="50" >
        <!-- <input type="button" name="buttton" value="上传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=member.21-sun.com:80&websiteId=29&dir=aboutus&fieldname=zd_img','upload',480,150)">-->   
        <span id="news_img" style="position: relative; top:5px; left: 8px;"></span>
        </td>
    </tr>
    <tr>
      <td width="15%" align="center"  >发布日期：</td>
      <td width="85%"  ><input name="zd_pub_date"   type="text" id="zd_pub_date" value="<%= Common.getToday("yyyy-MM-dd",0)%>" size="21"   />      </td>
    </tr>
    <tr>
      <td align="center"  >是否发布：</td>
      <td  ><input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="0">
    否    </tr>
    <tr>
      <td align="center"  >序号：</td>
    <td  ><input name="zd_order_no"  type="text"  Class="xmlInput textInput5" id="zd_order_no" value="" size="5" readonly="readonly" >    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2">
      	<div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
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
<script type="text/javascript" src="http://ad.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript">
	jQuery("#news_img").JrUpload({
		remotUrl : "http://ad.21-sun.com/upload.jsp",
		folder : "main_news" ,
		callback : "setNewsImg"
	});
	function setNewsImg(data){
		jQuery("#zd_img").val("http://ad.21-sun.com"+data);
	}
</script>
</body>
</html>
