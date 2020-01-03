<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %><%
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String sessionMemNo=((String)memberInfo.get("mem_no"));
String cacheName = "home"+sessionMemNo;
// 获得session判断用户的信息是否完善
Map memberInfoMap = null ;
memberInfoMap = (HashMap)session.getAttribute("memberInfo") ;
String comp_name = Common.getFormatStr(memberInfoMap.get("comp_name")) ;
String per_phone = Common.getFormatStr(memberInfoMap.get("per_phone")) ;
String comp_mode = Common.getFormatStr(memberInfoMap.get("comp_mode")) ;
if(pool==null){
	pool = new PoolManager();
}
/// 检测用户的信息是否完善
String memberInfo_tablename = "member_info_sub" ;
String memberInfo_tj = " mem_no = '"+sessionMemNo  +"'";
String[][] detailInfo = DataManager.fetchFieldValue(pool,memberInfo_tablename,"comp_mode,comp_mobile_phone",memberInfo_tj) ;
PoolManager pool3= new PoolManager(3);
PoolManager pool4= new PoolManager(4);
PoolManager pool5= new PoolManager(5);
PoolManager pool7= new PoolManager(7);
PoolManager pool9= new PoolManager(9);//配套网
Connection conn =null;
ResultSet rs = null;
String keyPar = sessionMemNo+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
String addflag= Common.getFormatInt(request.getParameter("addflag"));   //操作标识
keyPar = Common.encryptionByDES(keyPar);
String [][]tempMemberInfo = DataManager.fetchFieldValue(pool,"member_info","flag_job,flag_21part,flag_bbs,flag_space,flag_blog,mem_name,mem_flag_name,convert(varchar(10),mem_flag_enddate,21),convert(varchar(19),login_last_date,21),login_last_ip,per_province,per_city"," mem_no='"+sessionMemNo+"' and state=1 ");//子站开通信息
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的商贸网 - 中国工程机械商贸网</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="../style/style_new.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-1.4.2.min.js"></script>
<script src="../scripts/scripts.js" type="text/javascript"></script>
<script type="text/javascript" src="cpfl-menu.js"></script>
<style type="text/css">
#winpop {
	width:380px;
	height:0px;
	position:absolute;
	right:0;
	bottom:0;
	border:0px solid #666;
	margin:0;
	padding:1px;
	overflow:hidden;
	display:none;
	padding-right:50px
}
#winpop .title {
	width:100%;
	height:22px;
	line-height:20px;
	background:#d1d1d1;
	font-weight:bold;
	text-align:center;
	font-size:12px;
}
#winpop .con {
	width:100%;
	height:350px;
	line-height:80px;
	font-weight:bold;
	font-size:12px;
	color:#FF0000;
	text-decoration:underline;
	text-align:center
}
.close {
	position:absolute;
	right:4px;
	top:-1px;
	color:#FFF;
	cursor:pointer
}
</style>
<script language=javascript>
function tabImg(img_src,img_title)
{var imgObj=document.getElementById("mainImg");
 var charObj=document.getElementById("imgTitle");
	if(imgObj){imgObj.src="images/"+img_src;}
	if(charObj){charObj.innerHTML=img_title;}
 }
</script>
</head>
<body>
<jsp:include page="top_new.jsp" />
<jsp:include page="subtop_new.jsp">
	<jsp:param name="addflag" value="<%=addflag%>"/>
</jsp:include>
<div class="memberMain contain950"> 
  <!--left-->
  <div class="member_left">
    <div class="memberInfo">
      <h2>会员资料</h2>
      <ul>
        <li>用户名：<strong><%=sessionMemNo%></strong><br />
          <a href="/manage/memberinfo_new.jsp?controlflag=1" class="nred">密码修改</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=mem_type_url %>" class="nred"><%=("".equals(comp_name) ||"".equals(per_phone)||"".equals(comp_mode))?"资料完善":"资料修改"%></a></li>
        <li>所在地：<strong><%=Common.getFormatStr(memberInfo.get("per_province"))%><%=Common.getFormatStr(memberInfo.get("per_city"))%></strong></li>
        <li>会员等级：<b><%=tempMemberInfo!=null&&tempMemberInfo[0][6]!=null&&!tempMemberInfo[0][6].equals("")?Common.getFormatStr(tempMemberInfo[0][6]):"-"%></b></li>
        <li>会员期限：<%=tempMemberInfo!=null&&tempMemberInfo[0][7]!=null&&!tempMemberInfo[0][7].equals("")?Common.getFormatStr(tempMemberInfo[0][7]):"无限制"%></li>
      </ul>
    </div>
    <div class="Newmenu">
      <ul>
        <!-- <li><a href="/manage/membermain.jsp?addflag=33">商机推荐</a></li> -->
        <!-- <li><a href="/manage/membermain.jsp?addflag=33">询价单</a></li> -->
        <li><a target="_blank" href="http://market.21-sun.com/buylistshow_1.htm">询价单</a></li>
        <li><a href="/manage/membermain.jsp?addflag=1">发布供求信息</a></li>
        <li><a href="/manage/membermain.jsp?addflag=64">发布配件信息</a></li>
        <li><a href="/home/used/equipment/edit.jsp">发布二手信息</a></li>
        <li><a href="/manage/membermain.jsp?addflag=63">发布租赁信息</a></li>
      </ul>
    </div>
    <div class="hotLine">
      <h3>咨询热线</h3>
      <div class="hottel"><font color="white">0535-6792736</font><br />
        <font color="black">0535-6727765</font></div>
    </div>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="member_right">
    <div class="welcome01"> <strong>您好！<%=Common.getFormatStr(memberInfo.get("mem_name"))%></strong><br />
      欢迎您来到"会员商务室"，在这里，您可以免费发布供求、配件、租赁等信息，足不出户做生意！ <br />
      完善您的"个人资料"，有助于赢取买家信任，快速获得订单，达成交易。 <%=null == detailInfo?"您的资料尚未完善，<a href='"+mem_type_url+"' class='nred'>现在就去完善。</a>":"<a href='"+mem_type_url+"' class='nred'>修改我的信息</a>" %> </div>
    <ul class="memberHomeBtns">
      <li><a href="/manage/membermain.jsp?addflag=1">发布供求</a></li>
      <li><a href="/manage/membermain.jsp?addflag=64">发布配件</a></li>
      <li><a href="/home/used/equipment/edit.jsp">发布二手</a></li>
      <li><a href="/manage/membermain.jsp?addflag=4">发布租赁</a></li>
    </ul>
    <div class="apply">
      <div class="newTitle">
        <h2>推荐应用</h2>
      </div>
      <ul>
        <!--    <li> 
        <a href="javascript:openDivWin('','/comjob/member_start.jsp?key=<%=keyPar%>',400,200)"><img src="../images/ico_rcw.gif" /></a>
        <div class="appIntro">
          <span><a href="javascript:openDivWin('','/comjob/member_start.jsp?key=<%=keyPar%>',400,200)">人才网</a></span>
        </div>
        </li> -->
        <li> <a href="http://www.21-cmjob.com/" target="_blank"><img src="../images/ico_rcw.gif" /></a>
          <div class="appIntro"> <span><a href="http://www.21-cmjob.com/" target="_blank">人才网</a></span> </div>
        </li>
        <!-- 
        <li> 
        <a href="javascript:openDivWin('','/21part/member_start.jsp?key=<%=keyPar%>',400,200)"><img src="../images/ico_jpw.gif" /></a>
        <div class="appIntro">
          <span><a href="javascript:openDivWin('','/21part/member_start.jsp?key=<%=keyPar%>',400,200)">杰配网</a></span>
        </div>
        </li>
         -->
        <li> <a href="http://www.21part.com" target="_blank"><img src="../images/ico_jpw.gif" /></a>
          <div class="appIntro"> <span><a href="http://www.21part.com" target="_blank">杰配网</a></span> </div>
        </li>
        
        <!-- 
        <li> 
        <a href="membermain.jsp?addflag=67"><img src="../images/ico_ptw.gif" /></a>
        <div class="appIntro">
          <span><a href="membermain.jsp?addflag=67">配套网</a></span>
        </div>
        </li>
         -->
        <li> <a href="membermain.jsp?addflag=20"><img src="../images/ico_ptw.gif" /></a>
          <div class="appIntro"> <span><a href="membermain.jsp?addflag=20">配套网</a></span> </div>
        </li>
        <!-- <li> <a href="javascript://void(0);" onclick="syncToLpw();"><img src="../images/ico_lpw.jpg" /></a>
          <div class="appIntro"> <span><a href="javascript://void(0);" onclick="syncToLpw();">太阳商城</a></span> </div>
        </li> -->
      </ul>
    </div>
    <div style="width:100px; float:left; padding-top:10px;">
      <a href="http://www.wajueji.com/activity/fallINlove.jsp" target="_blank" title="爱在铁臂，难以离开！"><img src="/images/ad_huiyuan_01.jpg" width="750" height="120" alt="爱在铁臂，难以离开！" /></a>
    </div>
  </div>
  <!--right end-->
  <div class="clear"></div>
</div>
<div class="loginlist_right" style="width:950px;margin:0 auto;margin-top:10px">
<div class="loginok_center" style="width:710px;float:left;margin-right:0px">
<jsp:include page="foot_new.jsp"/>
<script>
$.getJSON("http://www.21-part.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://market.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21-used.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21-rent.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21part.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21-cmjob.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://member.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://data.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21peitao.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://zhidao.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://spec.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
</script> 
<script type="text/javascript">
//name,url,width 850,heigth 680
function openDivWin(name,url,width,heigth){
 var w =width; 
 var h =heigth; 
 lhgdialog.opendlg(name,url, w, h, true, true,'windiv'); 
}
function tabImg(img_src,img_title)
{var imgObj=document.getElementById("mainImg");
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

	function syncToLpw(){
		var url = "http://www.21taiyang.com/tools/member/sync.jsp?action=rl&source=1&mem_no=<%=Common.getFormatStr(memberInfo.get("mem_no")) %>&password=<%=Common.getFormatStr(memberInfo.get("passw")) %>&mem_name=<%=Common.getFormatStr(memberInfo.get("mem_name")) %>&email=<%=Common.getFormatStr(memberInfo.get("per_email")) %>";
		window.open(url);
	}
</script> 
<link rel="stylesheet" href="/scripts/jBox/Skins/Blue/jbox.css" type="text/css"></link>
<script type="text/javascript" src="/scripts/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript">
$.jBox.messager('尊敬的各位伙伴：<br />为给广大客户提供一个专业的信息平台，商贸网近期会对供求市场的信息进行整理，如您发现您发布的信息不存在或帐号不能登录，<span style="color:red">有可能是您的信息与我们行业不相关或不符合我们的要求，被删除或禁用。</span><br />感谢您对中国工程机械商贸网的关注，如给您造成不便，我们深表歉意！<br />如您有任何问题，请拨打：0535-6723231。', '重要通知',0);
</script>
</body>
</html>