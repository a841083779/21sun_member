<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<%@ include file ="/manage/config.jsp"%>
<% 
if(pool==null){
	pool = new PoolManager();
}
String flag=Common.getFormatInt(request.getParameter("flag"));//信息事业部为１
//
//每个模块的标识
String tag = Common.getFormatInt(request.getParameter("tag"));
String type = "";
  if("4".equals(tag)){
			type = "热点";
	}else if("5".equals(tag)){
			type = "信息";
	}else if("6".equals(tag)){
			type = "案例营销";
	}else if("7".equals(tag)){
			type = "行业信息";
	}else if("8".equals(tag)){
			type = "数据分析";
	}else if("9".equals(tag)){
			type = "最新视频";
	}else if("10".equals(tag)){
			type = "本网热点";
	}else if("11".equals(tag)){
			type = "新版资讯";
	}else if("12".equals(tag)){
			type = "视频直播";
	}else if("13".equals(tag)){
			type = "排行榜";
	}else if("14".equals(tag)){
			type = "录入排行榜1";
	}else if("15".equals(tag)){
			type = "录入排行榜2";
	}else if("16".equals(tag)){
			type = "调用排行榜1";
	}else if("17".equals(tag)){
			type = "调用排行榜2";
	}


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

	//alert("主标题长度: " + main_title + " is_first :" + is_first);
	  //行业报告，最新资讯进行控制
	   if("1" == zd_sort_flag || "2" == zd_sort_flag){
	   		//alert("zd_sort_flag=:" + zd_sort_flag);
			/* if(zd_title != null){
			 	if(zd_title.length  > 16){
				alert("主标题的长度大于16个字符,请修改主标题长度");
				return false;
			}
			*/
			
			if(is_first==1 && main_title > 16){
				alert("主标题的长度大于16个字符,请修改主标题长度");
				return false;
			}
			
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
	
	var zd_mouse_title = document.getElementById("zd_mouse_title").value;
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
	   if("1" == zd_sort_flag || "2" == zd_sort_flag || "8" == zd_sort_flag){
	   		
			if(checkValue==1 && main_title > 16){
				alert("头条主标题的长度大于16个字符,请修改主标题长度");
				return false;
			}
			
		}
		//热点鼠标标题
		 if("4" == zd_sort_flag || "5" == zd_sort_flag ){
	   		
			if(zd_mouse_title > 40){
				alert("鼠标标题的长度大于40个字符,请修改鼠标标题长度");
				return false;
			}
			
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
			if(main_title > 18){
				alert("主标题的长度大于18个字符,请修改主标题长度");
				return false;
			}
			
		}
	   //最新视频
		 if("9" == zd_sort_flag){	   		
			if(main_title > 16){
				alert("对于最新视频，主标题的长度大于16个字符,请修改主标题长度");
				return false;
			}			
		}
		//本网热点
		 //if("10" == zd_sort_flag || "11" == zd_sort_flag){	  //edited by gaopeng --20121114  		
		 if("10" == zd_sort_flag){	  
			if(main_title > 18){
				alert("主标题的长度大于18个字符,请修改主标题长度");
				return false;
			}			
		}
		 //视频直播
		 if("12" == zd_sort_flag){	   		
			if(main_title > 8){
				alert("对于视频直播，主标题的长度大于８个字符,请修改主标题长度");
				return false;
			}			
		}
		//排行榜
		 if("13" == zd_sort_flag || "14" == zd_sort_flag || "15" == zd_sort_flag){	   		
			if(main_title > 19){
				alert("对于排行榜，主标题的长度大于19个字符,请修改主标题长度");
				return false;
			}			
		}
		if("16" == zd_sort_flag || "17" == zd_sort_flag){	   		
			if(main_title > 17){
				alert("对于调用信息中心数据的排行榜，主标题的长度大于17个字符,请修改主标题长度");
				return false;
			}			
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
<script type="text/javascript"> 
<!-- 
function getRangeById(id) 
{ 
	var word=''; 
	if (document.selection){
		o=document.selection.createRange();
		if(o.text.length>0)
			word=o.text;
	}else{ 
		o=document.getElementById(id); 
		p1=o.selectionStart;
		p2=o.selectionEnd; 
		if (p1||p1=='0'){
			if(p1!=p2)
				word=o.value.substring(p1,p2);
		}
	} 
	return word; 
	
} 
//--> 
function repl_red(id){
	//alert("id is : " + id);
	var content = document.getElementById(id).value;
	content = content.replace(getRangeById(id),"<font color='red'>" + getRangeById(id) + "</font>");
	document.getElementById(id).value = content;
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
  <td colspan=2 align=center >所属栏目：<%=type%></td>
  </tr>
    <tr>
      <td align="center"  >索引：</td>
      <td  ><input name="zd_sub_title"  type="text" Class="xmlInput textInput5" id="zd_sub_title" value="" size="10"  >&nbsp;&nbsp;
	  <% if("4".equals(tag) || "5".equals(tag)){%>
		
		<%}else{%>
	  <input type="button" value="选中文字点击变红" onClick="repl_red('zd_sub_title');">
	  	<%}%>
	  </td>
    </tr>
    <tr>
      <td width="15%" align="center"  >索引链接：</td>
      <td width="85%"  ><input name="zd_sub_url"  type="text"  Class="xmlInput textInput5" id="zd_sub_url" value="" size="50" ></td>
    </tr>
    <tr>
 <td width="15%" align="center"  >主标题：</td>
      <td colspan="3"  ><input name="zd_title"  type="text" Class="xmlInput textInput5" id="zd_title" value="" size="50" dataType="Require" msg="新闻标题不能为空">&nbsp;&nbsp;
	    <% if("4".equals(tag) || "5".equals(tag)){%>
		索引/标题是否加红：
        <input type="radio" id="zd_is_red1" name="zd_is_red" value="1" >
        是
        <input type="radio" id="zd_is_red2" name="zd_is_red" value="0" checked="checked">
        否 
		<%}else{%>
	   <input type="button" value="选中文字点击变红" onClick="repl_red('zd_title');">
	  	<%}%>
	 
       </td>
    </tr>
    <tr>
      <td width="15%" align="center"  >主标题链接：</td>
      <td width="85%"  ><input name="zd_url"  type="text"  Class="xmlInput textInput5" id="zd_url" value="" size="50" dataType="Require" msg="新闻链接不能为空"></td>
    </tr>  
    <tr>
      <td width="15%" align="center"  >鼠标移上标题：</td>
      <td width="85%"  ><input name="zd_mouse_title"  type="text"  Class="xmlInput textInput5" id="zd_mouse_title" value="" size="50" dataType="Require" msg="鼠标移上标题不能为空">　
      请输入鼠标移上进时显示的文字</td>
    </tr>
    <tr>
      <td width="15%" align="center"  >缩 略 图：</td>
      <td width="85%"  ><input name="zd_img"  type="text" Class="xmlInput textInput5" id="zd_img" value="" size="50" >
        <!--<input type="button" name="buttton" value="上传" onClick="openWin('http://resource.21-sun.com/web_upload_files.jsp?nurl=member.21-sun.com:80&websiteId=29&dir=aboutus&fieldname=zd_img','upload',480,150)">（视频、本网热点用）-->
        <span id="news_img" style="position: relative; top:5px; left: 8px;"></span>
        </td>
    </tr>
    <tr>
      <td width="15%" align="center"  >发布日期：</td>
      <td width="85%"  ><input name="zd_pub_date"   type="text" id="zd_pub_date" value="<%= Common.getToday("yyyy-MM-dd",0)%>" size="21"   />
      </td>
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
          <option value="9">最新视频</option>
          <option value="10">本网热点</option>
           <option value="11">新版资讯</option>
            <option value="12">视频直播</option>
           <option value="13">排行榜</option>
           <option value="14">录入排行榜１</option>
           <option value="15">录入排行榜２</option>
		   <option value="16">调用排行榜１</option>
		   <option value="17">调用排行榜２</option>
          <%}else{%>
          <option value="3">最新产品</option>
          <option value="5">信息</option>
          <%}%>
        </select>
    </tr>
    <tr>
      <td align="center"  >是否发布：</td>
      <td  ><input type="radio" id="zd_is_pub" name="zd_is_pub" value="1" checked="checked">
        是
        <input type="radio" id="zd_is_pub" name="zd_is_pub" value="0">
        否 
    </tr>
    <tr>
      <td align="center"  >序号：</td>
      <td  ><input name="zd_order_no"  type="text"  Class="xmlInput textInput5" id="zd_order_no" value="" size="5" onkeydown = "DigitInput(this,event);"><font color="red">一定要为英文半角数字，如果您修改排行榜头条，请不要变此序号</font>
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
