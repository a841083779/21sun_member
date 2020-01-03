<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/manage/config.jsp"%>
<% 
if(pool==null){
	pool = new PoolManager();
}
String flag=Common.getFormatInt(request.getParameter("flag"));//信息事业部为１

String id=Common.getFormatInt(request.getParameter("id"));
if(id==null||id.equals(""))
{
	id="0";
}else
{
	id=Common.getFormatInt(Common.getFormatStr(id));/**过滤**/
}
String mypy="index_21sun";
String urlpath="index_21sun_edit.jsp";
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/isnumber.js"  type="text/javascript"></script>
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
//头条控制
function mainCheck(){
 	var zd_sort_flag = document.getElementById("zd_sort_flag").value;
	var zd_title = document.getElementById("zd_title").value;
   	var is_first = document.getElementById("is_first").value;
	var main_title = checkLength(zd_title);

	alert("主标题长度: " + main_title + " is_first :" + is_first);
	  //行业报告，最新资讯进行控制
	   if("1" == zd_sort_flag || "2" == zd_sort_flag){
	   		//alert("zd_sort_flag=:" + zd_sort_flag);
			/* if(zd_title != null){
			 	if(zd_title.length  > 16){
				alert("主标题的长度大于16个字符,请修改主标题长度");
				return false;
			}
			*/
			
			//if(is_first==1 && main_title > 16){ 
			//	alert("主标题的长度大于16个字符,请修改主标题长度"); 
			//	return false; 
			//} 
			
		}
	   
	theform.submit();
}

function submityn(){
 	var zd_sort_flag = document.getElementById("zd_sort_flag").value;
	var zd_title = document.getElementById("zd_title").value;
    var zd_sub_title = document.getElementById("zd_sub_title").value;
	var main_title = checkLength(zd_title);
	var sub_title = checkLength(zd_sub_title);
	var is_first = document.getElementsByName("is_first");
	var checkValue="";     
	for(var i=0;i<is_first.length;i++)                      
	{
      if(is_first[i].checked)
      checkValue=is_first[i].value;                        //变量赋予单选框选中的值
	}
	/*
	alert("主标题长度: " + main_title + " 副标题长度: " + sub_title);
	
		alert("主标题长度: " + main_title + " is_first :" + checkValue);
	*/
	  //行业报告，最新资讯进行控制
	   if("1" == zd_sort_flag || "2" == zd_sort_flag){
	   		
			//if(checkValue==1 && main_title > 16){
			//	alert("头条主标题的长度大于16个字符,请修改主标题长度");
			//	return false;
			//}
			
		}
	  //行业报告，最新资讯进行控制
	  
	   if("1" == zd_sort_flag || "2" == zd_sort_flag){
	   		//alert("zd_sort_flag=:" + zd_sort_flag);
			/* if(zd_title != null){
			 	if(zd_title.length  > 16){
				alert("主标题的长度大于16个字符,请修改主标题长度");
				return false;
			}
			*/
			//if(main_title > 18){
			//	alert("主标题的长度大于18个字符,请修改主标题长度");
			//	return false;
			//}
			
		}
	   
	  if("1" == zd_sort_flag){
		  
		  if(zd_title != null && zd_sub_title != null){
		
		  	if((main_title + sub_title) > 28){
				alert("主副标题总的长度大于28个字符,请修改主副标题长度");
				return false;
			}
		  }
	  }
	  
	  //替换字符
	/* var oEditor = FCKeditorAPI.GetInstance('zd_content');
	
	 alert("内容是:" + oEditor.GetXHTML(true));
	 var resultStr = repl(oEditor.GetXHTML(true));
	  oEditor.InsertHtml("resultStr");
	  */zd_sub_url
	  var zd_url = document.getElementById("zd_url");
	  if(zd_url != null){
	  	zd_url.value = repl(zd_url.value);
	  }
	   var zd_sub_url = document.getElementById("zd_sub_url");
	  if(zd_sub_url != null){
	  	zd_sub_url.value = repl(zd_sub_url.value);
	  }
	theform.submit();
}
//两个标题长度要控制
function repl(str){
	//var str = "&amp;kdjsd&&quot;&ssf";
	var result = str.replace( /&(?!#?\w+;)/g , '&amp;');
	//alert("the result is : " + result);
	return result;
}	
function getEditorHTMLContents(EditorName) { 
var oEditor = FCKeditorAPI.GetInstance(EditorName); 
return(oEditor.GetXHTML(true)); 
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
      <td colspan="3"  ><input name="zd_title"  type="text" Class="xmlInput textInput5" id="zd_title" value="" size="50" dataType="Require" msg="新闻标题不能为空"> 
        &nbsp; &nbsp; &nbsp; &nbsp;<font color="#FF0000">是否资讯、行业报告头条：</font>
          <input type="radio" id="is_first1" name="is_first" value="1"  checked="checked">
        是
        <input type="radio" id="is_first2" name="is_first" value="0">
      否    	</td>
    </tr>
    <tr>
      <td width="15%" align="center"  >链    接：</td>
      <td width="85%"  ><input name="zd_url"  type="text"  Class="xmlInput textInput5" id="zd_url" value="" size="50" ></td>
    </tr>
    <tr>
      <td align="center"  >副标题：</td>
      <td  ><input name="zd_sub_title"  type="text" Class="xmlInput textInput5" id="zd_sub_title" value="" size="48"  ></td>
    </tr>
    <tr>
      <td width="15%" align="center"  >副链接：</td>
      <td width="85%"  ><input name="zd_sub_url"  type="text"  Class="xmlInput textInput5" id="zd_sub_url" value="" size="50" ></td>
    </tr>
    <tr>
      <td width="15%" align="center"  >缩 略 图：</td>
      <td width="85%"  ><input name="zd_img"  type="text" Class="xmlInput textInput5" id="zd_img" value="" size="50" >
        <!--<input type="button" name="buttton" value="上传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=member.21-sun.com:80&websiteId=29&dir=aboutus&fieldname=zd_img','upload',480,150)">-->
        <span id="news_img" style="position: relative; top:5px; left: 8px;"></span>
        </td>
    </tr>
    <tr>
      <td width="15%" align="center"  >发布日期：</td>
      <td width="85%"  ><input name="zd_pub_date"   type="text" id="zd_pub_date" value="<%= Common.getToday("yyyy-MM-dd",0)%>" size="21"   />      </td>
    </tr>
    <tr>
      <td align="center"  >类型：</td>
      <td  ><select name="zd_sort_flag" id="zd_sort_flag" >
	  <%if("1".equals(flag)){%>
	   <option value="1">最新资讯</option>
          <option value="2">行业分析报告</option>         
          <option value="4">热点</option>

          <option value="6">案例营销</option>
          <option value="7">行业信息</option>
		  <option value="8">数据分析</option>
	  		
		<%}else{%>
            <option value="3">最新产品</option>
          <option value="5">信息</option>
		  
		  <%}%>
    </select>    </tr>
    <tr>
      <td align="center"  >是否发布：</td>
      <td  ><input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="0">
    否    </tr>
    <tr>
      <td align="center"  >序号：</td>
    <td  ><input name="zd_order_no"  type="text"  Class="xmlInput textInput5" id="zd_order_no" value="" size="5" onkeydown = "DigitInput(this,event);">    </tr>
	 <tr>
      <td height="22" align="right" nowrap class="list_left_title">排版内容：</td>
      <td height="22" class="list_cell_bg"><FCK:editor instanceName="zd_content" toolbarSet="simple" width="93%" height="280">
          <jsp:attribute name="value"> </jsp:attribute>
        </FCK:editor></td>
    </tr>
    <tr >
      <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left">
          <input type="button" name="Submit" value="保存" onClick="submityn();">
          <input name="b_close" type="button" class="form_button" onClick="closeWindow();" value="关 闭">
        </div></td>
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
