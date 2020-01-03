<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String sessionMemNo=((String)memberInfo.get("mem_no"));
String cacheName = "home"+sessionMemNo;
%>
<%
// 获得session判断用户的信息是否完善
Map memberInfoMap = null ;
memberInfoMap = (HashMap)session.getAttribute("memberInfo") ;
String comp_name = Common.getFormatStr(memberInfoMap.get("comp_name")) ;
String comp_mobile_phone = Common.getFormatStr(memberInfoMap.get("comp_mobile_phone")) ;
String comp_mode = Common.getFormatStr(memberInfoMap.get("comp_mode")) ;
%>
<%
if(pool==null){
	pool = new PoolManager();
}
PoolManager pool3= new PoolManager(3);
PoolManager pool4= new PoolManager(4);
PoolManager pool5= new PoolManager(5);
PoolManager pool7= new PoolManager(7);
PoolManager pool9= new PoolManager(9);//配套网
Connection conn =null;
ResultSet rs = null;
String keyPar = sessionMemNo+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
String addflag= Common.getFormatInt(request.getParameter("addflag"));   //操作标识
String controlflag = Common.getFormatInt(request.getParameter("controlflag"));  //1:修改密码 
String iframeFilename="/manage/member_reg_more.jsp"; //企业信息修改
if(controlflag.equals("1")){
    iframeFilename ="/other/user_passw_opt.jsp"; //密码修改 
}else if(controlflag.equals("2")){
	iframeFilename ="/manage/member_reg_more_person.jsp"; //个人信息修改
}

keyPar = Common.encryptionByDES(keyPar);

String [][]tempMemberInfo = DataManager.fetchFieldValue(pool,"member_info","flag_job,flag_21part,flag_bbs,flag_space,flag_blog,mem_name,mem_flag_name,convert(varchar(10),mem_flag_enddate,21),convert(varchar(19),login_last_date,21),login_last_ip,per_province,per_city"," mem_no='"+sessionMemNo+"' and state=1 ");//子站开通信息
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
#winpop { width:380px; height:0px; position:absolute; right:0; bottom:0; border:0px solid #666; margin:0; padding:1px; overflow:hidden; display:none; padding-right:50px}
#winpop .title { width:100%; height:22px; line-height:20px; background:#d1d1d1; font-weight:bold; text-align:center; font-size:12px;}
#winpop .con { width:100%; height:350px; line-height:80px; font-weight:bold; font-size:12px; color:#FF0000; text-decoration:underline; text-align:center} 
.close { position:absolute; right:4px; top:-1px; color:#FFF; cursor:pointer}
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
       <li>用户名：<strong><%=sessionMemNo%></strong><br /><a href="/manage/memberinfo_new.jsp?controlflag=1" class="nred">密码修改</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=mem_type_url %>" class="nred"><%=("".equals(comp_name) ||"".equals(comp_mobile_phone)||"".equals(comp_mode))?"资料完善":"资料修改"%></a></li>
        <li>所在地：<strong><%=Common.getFormatStr(memberInfo.get("per_province"))%><%=Common.getFormatStr(memberInfo.get("per_city"))%></strong></li>
        <li>会员等级：<b><%=tempMemberInfo!=null&&tempMemberInfo[0][6]!=null&&!tempMemberInfo[0][6].equals("")?Common.getFormatStr(tempMemberInfo[0][6]):"-"%></b></li>
        <li>会员期限：<%=tempMemberInfo!=null&&tempMemberInfo[0][7]!=null&&!tempMemberInfo[0][7].equals("")?Common.getFormatStr(tempMemberInfo[0][7]):"无限制"%></li>
      </ul>
    </div>
    <div class="Newmenu">
      <ul>
   <!--      <li><a href="#">商机推荐</a></li> -->
        <li><a target="_blank" href="http://market.21-sun.com/buylistshow_1.htm">询价单</a></li>
        <li><a href="/manage/membermain.jsp?addflag=1">发布供求信息</a></li>
        <li><a href="/manage/membermain.jsp?addflag=2">发布配件信息</a></li>
        <li><a href="/manage/membermain.jsp?addflag=6">发布二手信息</a></li>
        <li><a href="/manage/membermain.jsp?addflag=4">发布租赁信息</a></li>
      </ul>
    </div>
    <div class="hotLine">
      <h3>咨询热线</h3>
      <div class="hottel"><font color="white">0535-6792736</font><br /><font color="black">0535-6727765</font></div>
    </div>
  </div>
  <!--left end-->
  <!--right-->
  <div class="member_right">
   <div class="memberRightContain">
      <iframe id="iframeright_1" name="iframeright_1" scrolling="no" frameborder="0" width="100%" height="760"  onload="this.height=iframeright_1.document.body.scrollHeight+30" src="<%=iframeFilename%>" allowtransparency="true" ></iframe>
    </div>
  </div>
  <!--right end-->
<div class="clear"></div>  
</div>
<div class="loginlist_right" style="width:950px;margin:0 auto;margin-top:10px">
<div class="loginok_center" style="width:710px;float:left;margin-right:0px">
  
</div>
<jsp:include page="foot_new.jsp"/>
<script>
$.getJSON("http://www.21-part.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://market.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21-used.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21-rent.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://bbs.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://blog.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21part.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21-cmjob.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://space.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://member.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://data.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21peitao.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://zhidao.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://spec.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
</script>
<div style="display: none"><script src="http://s94.cnzz.com/stat.php?id=4088238&web_id=4088238" language="JavaScript"></script></div>
</body>
</html>