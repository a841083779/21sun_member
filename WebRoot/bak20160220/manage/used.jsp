<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.Common"%>
<%
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String mainUrl = "/usedmarket/main.jsp";
	String f = Common.getFormatStr(request.getParameter("f"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Language" content="zh-cn" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>我的商贸网 - 中国工程机械商贸网</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<link href="../style/style_new.css" rel="stylesheet" type="text/css" />
	<link type="text/css" rel="stylesheet" href="/scripts/jBox/Skins/Blue/jbox.css" />
	<script type="text/javascript" src="jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="cpfl-menu.js"></script>
	<script src="../scripts/scripts.js" type="text/javascript"></script>
	<style type="text/css">
		#winpop { width:380px; height:0px; position:absolute; right:0; bottom:0; border:0px solid #666; margin:0; padding:1px; overflow:hidden; display:none; padding-right:50px}
		#winpop .title { width:100%; height:22px; line-height:20px; background:#d1d1d1; font-weight:bold; text-align:center; font-size:12px;}
		#winpop .con { width:100%; height:350px; line-height:80px; font-weight:bold; font-size:12px; color:#FF0000; text-decoration:underline; text-align:center} 
		.close { position:absolute; right:4px; top:-1px; color:#FFF; cursor:pointer}
		.span1{
			margin-left: 8px;
		}
		.f60{
			color:#f60;
			font-weight: bolder;
		}
	</style>
</head>
<body>

<jsp:include page="top_new.jsp" />
<jsp:include page="subtop_new.jsp"></jsp:include>
<div class="memberMain contain950">
  <!--left-->
  <div class="member_left">
    <div class="memberPart">
      <h2>我的二手</h2>
      <ul id="left_menu">        
		<li><a href="javascript:void(0);" style="font-weight: bold;" onclick="goRight('/usedmarket/sale_list.jsp');">库存管理</a></li>
		<li style="background: none;"><a id="yfsb" href="javascript:void(0);" onclick="goRight('/usedmarket/sale_list.jsp');" style="background: none;"><span class="span1"></span>已发设备</a></li>
		<li><a id="fbsb" href="javascript:void(0);" onclick="goRight('/usedmarket/sale_opt.jsp');" style="background: none;"><span class="span1"></span>发布设备</a></li>
		
		<li><a href="javascript:void(0);" style="font-weight: bold;" onclick="goRight('/usedmarket/sell_list.jsp');">出售商机</a></li>
		<li style="background: none;"><a id="yfsj" href="javascript:void(0);" onclick="goRight('/usedmarket/sell_list.jsp');" style="background: none;"><span class="span1"></span>已发信息</a></li>
		<li><a href="javascript:void(0);" id="fbsj" onclick="goRight('/usedmarket/sell_opt.jsp');" style="background: none;"><span class="span1"></span>发布信息</a></li>
		
		<li><a href="javascript:void(0);" style="font-weight: bold;" onclick="goRight('/usedmarket/buy_list.jsp');">求购信息</a></li>
		<li style="background: none;"><a id="qgxx" href="javascript:void(0);" onclick="goRight('/usedmarket/buy_list.jsp');" style="background: none;"><span class="span1"></span>已发信息</a></li>
		<li><a href="javascript:void(0);" id="fbqg" onclick="goRight('/usedmarket/buy_opt.jsp');" style="background: none;"><span class="span1"></span>发布信息</a></li>
		
		<li><a href="javascript:void(0);" style="font-weight: bold;" onclick="goRight('/usedmarket/message_list.jsp?flag=1');">站内留言</a></li>
		
      </ul>
    </div>
    <script type="text/javascript">
    	function goRight(url){
    		document.getElementById("iframeright_1").src=url;
    		jQuery("#left_menu li a").css("color","#000");
    		if(url.indexOf("sale_opt")!=-1){
    			jQuery("#fbsb").css("color","#f60");
    		}else if(url.indexOf("sale_list")!=-1){
    			jQuery("#yfsb").css("color","#f60");
    		}else if(url.indexOf("sell_opt")!=-1){
    			jQuery("#fbsj").css("color","#f60");
    		}else if(url.indexOf("sell_list")!=-1){
    			jQuery("#yfsj").css("color","#f60");
    		}else if(url.indexOf("buy_opt")!=-1){
    			jQuery("#fbqg").css("color","#f60");
    		}else if(url.indexOf("buy_list")!=-1){
    			jQuery("#qgxx").css("color","#f60");
    		}
    	}
    </script>
    <div class="Newmenu noMargin">
      
    </div>
    <div class="memberApplyPart">
      <h2>推荐应用</h2>
      <ul>
        <li> 
        <a href="http://www.21-cmjob.com/" target="_blank"><img src="../images/ico_rcw.gif" /></a>
        <div class="appIntro">
          <span><a href="http://www.21-cmjob.com/" target="_blank">人才网</a></span>
        </div>
        </li> 
      <li> 
        <a href="http://www.21part.com" target="_blank"><img src="../images/ico_jpw.gif" /></a>
        <div class="appIntro">
          <span><a href="http://www.21part.com" target="_blank">杰配网</a></span>
        </div>
      </li>
    <li> 
        <a href="membermain.jsp?addflag=20"><img src="../images/ico_ptw.gif" /></a>
        <div class="appIntro">
          <span><a href="membermain.jsp?addflag=20">配套网</a></span>
        </div>
        </li>
       <li> <a href="http://www.jerehsoft.com/products/index.jsp" target="_blank"><img src="../images/erp_huiyuan.gif" /></a>
          <div class="appIntro"> <span><a href="http://www.jerehsoft.com/products/index.jsp" target="_blank">工程机械行业管理解决方案</a></span> </div>
        </li>
      </ul>
    </div>
    <div class="hotLine">
      <h3>咨询热线</h3>
      <div class="hottel"><font color="white">0535-6792736</font><!-- <br /><font color="black">0535-6727765</font> --></div>
    </div>
  </div>
  <!--left end-->
  <!--right-->
  <div class="member_right">
    <div class="memberRightContain">
  		<iframe id="iframeright_1" name="iframeright_1" scrolling="no" frameborder="0" width="100%" height="970" src="<%=mainUrl %>"></iframe> 
    </div>
  </div>
  <!--right end-->
<div class="clear"></div>  
</div>

<script type="text/javascript">
//name,url,width 850,heigth 680
function openDivWin(name,url,width,heigth){
 	var w =width; 
 	var h =heigth; 
 	lhgdialog.opendlg(name,url, w, h, true, true,'windiv'); 
}
function tabImg(img_src,img_title)
{
	var imgObj=document.getElementById("mainImg");
 	var charObj=document.getElementById("imgTitle");
	if(imgObj){imgObj.src="images/"+img_src;}
	if(charObj){charObj.innerHTML=img_title;}
 }
function changeClass(n){  //选中当前的导航条，将其它的设置成不选中
	$("#v"+n).addClass("v"+n+"hover");
	$("#v"+n).attr("style","color:#356794");	
	$("#nav li span a").each(function(i){
	     if(i!=n){		    
		   $("#v"+i).removeClass("v"+i+"hover");
		   $("#v"+i).attr("style","color:#ffffff");
		 }
	}); 

 }
</script>
<script type="text/javascript" src="/scripts/divopenwin/lhgdialog.js"></script>
<div class="New_foot">
	<a href="http://www.21-sun.com/"><font style="font-family:impact; font-size:12pt; line-height:14pt; color:#003399">21-sun</font><font style="font-family:impact; font-size:12pt; line-height:14pt; color:#ff9955">.com</font></a>   
	<a href="http://www.21-sun.com/">中国工程机械商贸网</a> 
	Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script>
	<strong>免费服务热线：0535-6792736</strong>
</div>
<iframe src="http://www.21-used.com/tools/sso.jsp?name=<%=memberInfo.get("mem_no") %>" style="display: none;"></iframe>
</body>
</html>
<script type="text/javascript" src="/scripts/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript">
function writeApply(){
	jQuery.jBox.close();
	jQuery.jBox("iframe:/usedmarket/apply.jsp",{
		title : "高级会员申请",
		top : "30%",
		width : 340 ,
		height : 300,
		buttons : { "确定" : 1 , "取消" : 0 },
		submit : function(v, h, f){
			if(v==1){
				return jQuery(h).find("iframe")[0].contentWindow.doSub();
			}
			return true;
		}
	});
}
<%
if(!"".equals(f)){
	%>
goRight('/usedmarket/<%=f %>_opt.jsp');
	<%
}
%>
</script>