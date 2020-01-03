<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%>
<%
 PoolManager pool3 = new PoolManager(3);

//=====页面属性====
String pagename="trad_info_opt.jsp";
String mypy="rent_news";
String titlename="";

String mem_no ="";
HashMap memberInfo = new HashMap();
if(session.getAttribute("memberInfo")!=null){   
	memberInfo = (HashMap) session.getAttribute("memberInfo");
	mem_no     = String.valueOf(memberInfo.get("mem_no"));  //登陆账号
}
//====得到参数====
String myvalue  = Common.getFormatStr(request.getParameter("myvalue"));
String urlpath="../rent/trad_info_opt.jsp";
String url="";

if(!myvalue.equals("")){
   urlpath=urlpath+"?myvalue="+java.net.URLEncoder.encode(myvalue,"UTF-8");  
   //需要编码 才能将加密后产生的特殊字符 例如：将 +  转码成 %2B   
}
String searchStr=" and mem_no='"+mem_no+"' ";
String tempInfo[][]=DataManager.fetchFieldValue(pool3, "rent_master"," distinct province", " 1=1"+searchStr);
if(tempInfo!=null){
	url= Common.getFormatStr(tempInfo[0][0]);
}


try{//====标题的名称====
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>供求发布</title>
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script src="../scripts/common.js"  type="text/javascript"></script>
<script src="../scripts/citys.js"  type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<script>
  function refresh(){
	 document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
  }
   //为多选框赋值
 function submityn(){
	if($("#zd_title").val()==""){
			alert("请输入标题！");
			$("#zd_title").focus();
			return false;
	}else if($("#zd_pubdate").val()==""){
			alert("请填写发布日期！");
			$("#zd_pubdate").focus();
			return false;
	}else if($("#zd_content").val()==""){
	       alert("请填写公告内容！");
			$("#zd_content").focus();
			return false;	
	}
	document.theform.submit();
 }
</script>
</head>
<body>
  <div class="loginlist_right">
  <div class="loginlist_right2"><span class="mainyh">行情资讯管理</span></div>
  <div class="loginlist_right1">
     <table  width="95%" border="0" align="center" class="tablezhuce">
		  <form action="opt_save_update.jsp" method="post" name="theform" id="theform">
			<tr>
			  <td align="right" nowrap class="list_left_title"><strong>新闻标题：</strong></td>
			  <td class="list_cell_bg"><input name="zd_title" type="text" id="zd_title" size="60" maxlength="40" class="required">
				<font color="#FF0000">*</font></td>
			</tr>
			<tr>
			  <td height="22" align="right" nowrap class="list_left_title"><strong>发布日期：</strong></td>
			  <td height="22" class="list_cell_bg"><input readonly="readonly" name="zd_pubdate" type="text" id="zd_pubdate" size="15" maxlength="30" dataType="Require" msg="留言内容不能为空" value="<%=Common.getToday("yyyy-MM-dd",0)%>"></td>
			</tr>
			<tr>
			  <td height="22" align="right" nowrap class="list_left_title"><strong>是否发布：</strong></td>
			  <td height="22" class="list_cell_bg">
				 &nbsp;<input type="radio" name="zd_is_pub" value="1" checked> 立即发布
				 &nbsp;&nbsp;&nbsp;<input type="radio" name="zd_is_pub" value="0"> 暂缓发布
			  </td>
			</tr>
			<tr>
			  <td align="right" nowrap class="list_left_title"><strong>内容：</strong></td>
			  <td class="list_cell_bg">
			  	<script type="text/plain" id="editor_intro" style="width:600px;"></script>
					<input type="hidden" name="zd_content" id="zd_content" value='' />
				</td>
			</tr>    	
			<tr >
			  <td height="30px" class="list_left_title" align="left" colspan="2"><div align="left"><a href="#" onClick="submityn()"><img src="../images/bottom01.gif" width="91" height="38" border="0"></a>		
				<input name="zd_id"         type="hidden" id="zd_id"       value="0">
				<input name="mypy"          type="hidden" id="mypy"        value="<%=Common.encryptionByDES(mypy)%>">
				<input name="zd_mem_no"     type="hidden" id="zd_mem_no" value="<%=mem_no%>">		
				<input name="zd_add_date"   type="hidden" id="zd_add_date" value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>">
				<input name="zd_add_ip"     type="hidden" id="zd_add_ip"   value="<%=Common.getRemoteAddr(request,1)%>">	
				<input name="myvalue"       type="hidden" id="myvalue"     value='<%=myvalue%>'>		
				<input name="urlpath"       type="hidden" id="urlpath"     value="<%=urlpath%>">
				<input name="zd_pubdate"    type="hidden" id="zd_pubdate"  value="<%=Common.getToday("yyyy-MM-dd HH:mm:ss",0)%>"/>	
				<input name="zd_category"   type="hidden" id="zd_category" value="1001">
				<input name="zd_clicked"    type="hidden" id="zd_clicked"  value="0">
				<input name="zd_catalog_no" type="hidden" id="zd_catalog_no" value="700702">
				<input name="zd_url"        type="hidden" id="zd_url"        value="<%=url%>">
			  </div></td>
			</tr>
		</form>	
  </table>
  </div>
  </div>
   <iframe name="getxinxi" id="getxinxi" frameborder=0 width=1 height=1 scrolling="no" style="visibility:hidden"></iframe>
	<script   language="javascript">
	function set_formxx(val){
	//alert(val);
		if(val!=null && val!=""){
		$('#getxinxi').attr("src","set_formxx.jsp?mypy="+encodeURIComponent('<%=mypy%>')+"&paraName=myvalue&paraValue="+encodeURIComponent(val));		
		}
	}
	<%
	if(!myvalue.equals("0")){
		out.print("set_formxx(\""+Common.decryptionByDES(myvalue)+"\");");
	}
	%>
	
	var ue_intro = new baidu.editor.ui.Editor({
    	textarea : 'zd_content',
    	autoHeightEnabled:false,
    	minFrameHeight:250
    });
    ue_intro.render('editor_intro');
    ue_intro.addListener("selectionchange",function(){
	    var state_intro = ue_intro.queryCommandState("source");
	    document.getElementById("zd_content").value=ue_intro.getContent();
	});
	
	function afterForm(){
		ue_intro.setContent(document.getElementById("zd_content").value);	
	}
	</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
titlename=null;
urlpath=null;
}
%>
