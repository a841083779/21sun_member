<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%><%

HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");

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
String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);

String [][]tempMemberInfo = DataManager.fetchFieldValue(pool,"member_info","flag_job,flag_21part,flag_bbs,flag_space,flag_blog,mem_name,mem_flag_name,convert(varchar(10),mem_flag_enddate,21),convert(varchar(19),login_last_date,21),login_last_ip"," mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and state=1 ");//子站开通信息

String [][]mess = DataManager.fetchFieldValue(pool,"member_message","sum(case when site_flag ='1' then 1 else 0  end),sum(case when site_flag ='2' then 1 else 0  end),sum(case when site_flag ='4' then 1 else 0  end),sum(case when site_flag ='5' then 1 else 0  end),sum(case when site_flag ='7' then 1 else 0  end)"," recipients_mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and sort_flag=1 "); //留言信息1:租赁、2:二手、4:配件、5:供求、7:配套

String [][]mess2 = DataManager.fetchFieldValue(pool,"member_message","sum(case when site_flag ='2' then 1 else 0  end),sum(case when site_flag ='5' then 1 else 0  end)"," recipients_mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and sort_flag=2 "); //询价信息 2:二手、5:供求

//二手
String[][] usedInfoBuy = DataManager.fetchFieldValue(pool4,"buy","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1 ");
String[][] usedInfoSell = DataManager.fetchFieldValue(pool4,"sell","count(*)","mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1");

//配件网
String[][] partsInfoBuy = DataManager.fetchFieldValue(pool7,"buy","count(*)","mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1");
String[][] partsInfoSell = DataManager.fetchFieldValue(pool7,"supply","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1 ");

//租赁网 0:求租,1:出租
String[][] rentInfo = DataManager.fetchFieldValue(pool3,"rent_info","sum(case when class ='0' then 1 else 0  end),sum(case when class ='1' then 1 else 0  end)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1");

//供求市场
String[][] marketInfoBuy = DataManager.fetchFieldValue(pool5,"sell_buy_market","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_show=1");

//配套网  1:配套合作;2:代理招商;3:求购信息;4:供应信息
String[][] fittingsInfo = DataManager.fetchFieldValue(pool9,"fittings_business_info","sum(case when flag ='1' then 1 else 0  end),sum(case when flag ='2' then 1 else 0  end),sum(case when flag ='3' then 1 else 0  end),sum(case when flag ='4' then 1 else 0  end)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_show=1");
//配套网产品信息
String[][] fittingsProductsInfo = DataManager.fetchFieldValue(pool9,"fittings_products","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_show=1 ");

String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的商贸网 - 中国工程机械商贸网</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-1.4.2.min.js"></script>
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
<jsp:include page="top.jsp" />
<jsp:include page="subtop.jsp">
  <jsp:param name="mem_flag" value="<%=mem_flag%>"/>
</jsp:include>
<div class="loginlist_right" style="width:950px;margin:0 auto;margin-top:10px">
<div class="loginok_center" style="width:710px;float:left;margin-right:0px">
  <div class="loginok_center1" style="width:687px;border:1px #e4eef8 solid">
   <!--<div class="swszwpic"><img src="../images/zwpic.gif" /></div>-->
   <div class="swsinformation"><font style="color:#3778ba;font-family:微软雅黑;font-size:19px">您好！<%=Common.getFormatStr(memberInfo.get("mem_no"))%></font> <a style="color:#3f4244;font-size:16px;font-family:微软雅黑">[<%=Common.getFormatStr(memberInfo.get("mem_name"))%>]</a><b style="font-size:14px;color:#ff8900;">　欢迎来到“中国工程机械商贸网会员商务室”</b><br />
   <a style="color:#989796">会员类型：</a><b style="font-size:14px;color:#fc7f04"><%=tempMemberInfo!=null&&tempMemberInfo[0][6]!=null?Common.getFormatStr(tempMemberInfo[0][6]):"-"%></b><br />
   <a style="color:#989796"> 到期时间：</a><a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][7]!=null?Common.getFormatStr(tempMemberInfo[0][7]):"-"%></a><br />
    <a style="color:#989796">上次登陆：</a><a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][8]!=null?Common.getFormatStr(tempMemberInfo[0][8]):"-"%></a>   <a style="color:#989796">在</a>  <a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][9]!=null?Common.getFormatStr(tempMemberInfo[0][9]):"-"%></a></b>  <a style="color:#989796">登录</a></div>
  <img src="dlhbaobao.jpg" width="92" height="108" style="float:right:margin-right:20px;"/></div>
  
   <div class="loginok_center3" style="width:708px">
    <div class="loginok_center3_1"><span class="bigblueb" style="display:block;width:104px;height:24px;background:url('../images/swslm_bg.gif');text-align:center;text-indent:0px;color:#fff;margin-left:20px">信息提醒</span></div>
   
<div class="loginok_center3_2" style="line-height:27px;color:#787878">
<a style="color:#000">商贸网供求：</a>您共发布了<b style="color:#FF0000">(<%if(marketInfoBuy!=null){out.print(Common.getFormatInt(marketInfoBuy[0][0]));}%>)</b>条供求信息,收到<%if(mess!=null){out.print(Common.getFormatInt(mess[0][3]));}%>条留言，<%if(mess2!=null){out.print(Common.getFormatInt(mess2[0][1]));}%>条询价&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=1">发布供求信息</a><br />
<a style="color:#000">我的二手：</a>您共发布了<b style="color:#FF0000">(<%if(usedInfoBuy!=null){out.print(Common.getFormatInt(usedInfoBuy[0][0]));}%>)</b>条求购信息,<b style="color:#FF0000">(<%if(usedInfoSell!=null){out.print(Common.getFormatInt(usedInfoSell[0][0]));}%>)</b>条出售信息,收到<%if(mess!=null){out.print(Common.getFormatInt(mess[0][1]));}%>条留言，<%if(mess2!=null){out.print(Common.getFormatInt(mess2[0][0]));}%>条询价&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=5">发布求购信息</a>&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=6">发布出售信息</a><br />
<a style="color:#000">我的租赁：</a>您共发布了<%if(rentInfo!=null){out.print(Common.getFormatInt(rentInfo[0][0]));}%>条求租信息,<%if(rentInfo!=null){out.print(Common.getFormatInt(rentInfo[0][0]));}%>条出租信息,收到<%if(mess!=null){out.print(Common.getFormatInt(mess[0][0]));}%>条留言&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=4">发布租赁信息</a>&nbsp;&nbsp;<br />
<a style="color:#000">配件网空间站：</a>您共发布了<b style="color:#FF0000">(<%if(partsInfoBuy!=null){out.print(Common.getFormatInt(partsInfoBuy[0][0]));}%>)</b>条求购信息,<b style="color:#FF0000">(<%if(partsInfoSell!=null){out.print(Common.getFormatInt(partsInfoSell[0][0]));}%>)</b>条供应信息,收到<%if(mess!=null){out.print(Common.getFormatInt(mess[0][2]));}%>条留言&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=8">发布配件求购</a>&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=2">发布配件供应</a><br />

<a style="color:#000">配套网空间站：</a>您共发布了<b style="color:#FF0000">(<%if(fittingsInfo!=null){out.print(Common.getFormatInt(fittingsInfo[0][0]));}%>)</b>条配套合作信息,<b style="color:#FF0000">(<%if(fittingsInfo!=null){out.print(Common.getFormatInt(fittingsInfo[0][1]));}%>)</b>条代理招商信息,<b style="color:#FF0000">(<%if(fittingsInfo!=null){out.print(Common.getFormatInt(fittingsInfo[0][2]));}%>)</b>条配套求购,<b style="color:#FF0000">(<%if(fittingsInfo!=null){out.print(Common.getFormatInt(fittingsInfo[0][3]));}%>)</b>条配套供应&nbsp;&nbsp;&nbsp;<a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=11">发布配套合作</a>&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=12">发布代理招商</a>    </div>
  </div>
  
  <div class="loginok_center3" style="width:708px">
    <div class="loginok_center3_1"><span class="bigblueb" style="display:block;width:104px;height:24px;background:url('../images/swslm_bg.gif');text-align:center;text-indent:0px;color:#fff;margin-left:20px">便捷通道</span></div>
    <div class="loginok_center3_2">
      <div class="loginok_center3_2_1">
        <ul>
          <li><a href="http://www.21-cmjob.com" target="_blank"><img src="/images/rcwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://www.21-cmjob.com" target="_blank">人才网</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][0]!=null&&Common.getFormatStr(tempMemberInfo[0][0]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="javascript:openDivWin('','/comjob/member_start.jsp?key=<%=keyPar%>',400,200)" class="hong"><font color="#FF0000">点击开通</font></a>)
            <%}%>
            <br/>
            <span class="data"><a href="http://www.21-cmjob.com" target="_blank">www.21-cmjob.com</a></span></li>
          <li><a href="http://www.21part.com" target="_blank"><img src="/images/jpwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://www.21part.com" target="_blank">杰配网</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][1]!=null&&Common.getFormatStr(tempMemberInfo[0][1]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="javascript:openDivWin('','/21part/member_start.jsp?key=<%=keyPar%>',400,200)" class="hong" ><font color="#FF0000">点击开通</font></a>)
            <%}%>
            <br/>
              <span class="data"><a href="http://www.21part.com" target="_blank">www.21part.com</a></span></li>
          <li><a href="http://bbs.21-sun.com" target="_blank"><img src="/images/smwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://bbs.21-sun.com" target="_blank">铁臂论坛</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][2]!=null&&Common.getFormatStr(tempMemberInfo[0][2]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://bbs.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂论坛吗？')){return false;} "><font color="#FF0000">点击开通</font></a>)
            <%}%>
            <br/>
              <span class="data"><a href="http://bbs.21-sun.com" target="_blank">bbs.21-sun.com</a></span></li>
          <li style="float:left"><a href="http://space.21-sun.com" target="_blank"><img src="/images/tbsplogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://space.21-sun.com" target="_blank">铁臂社区</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][3]!=null&&Common.getFormatStr(tempMemberInfo[0][3]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://space.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂社区吗？')){return false;} "><font color="#FF0000">点击开通</font></a>)
            <%}%> <br/>
              <span class="data"><a href="http://space.21-sun.com" target="_blank">space.21-sun.com</a></span></li>
          <li><a href="http://blog.21-sun.com" target="_blank"><img src="/images/smwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://blog.21-sun.com" target="_blank">铁臂博客</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][4]!=null&&Common.getFormatStr(tempMemberInfo[0][4]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://blog.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂博客吗？')){return false;} "><font color="#FF0000">点击开通</font></a>)
            <%}%>
            <br/>
              <span class="data"><a href="http://blog.21-sun.com" target="_blank">blog.21-sun.com</a></span>
			</li>
			
        </ul>
      </div>
     
    </div>
  </div>
</div>
<div class="loginok_right" style="float:right">
  <div class="loginok_right_1">
    <div class="loginok_right_1_1"  ><span class="red14">21-SUN公告</span></div>
    <div class="loginok_right3_2">
      <ul>
        <li><a target="_blank" href="http://data.21-sun.com" class="blue12">2010-2012年中国液压破碎锤市场发展研究及前景预测</a></li>
		<li><a target="_blank" href="http://data.21-sun.com" class="blue12">
			电子版：9800元/份。<br />电话：0535- 6722555  6727766  6723251</a> </li>
      </ul>
	   <div class="loginok_right_2_2_1"><a href="http://www.21-cmjob.com/" target="_blank"><img src="/images/rencai200.gif" alt="中国工作机械人才网" width="200" height="78"  border="0"/></a></div>
    </div>
  </div>
<div class="loginok_right_1">
    <div class="loginok_right_1_1"  ><span class="red14" style="color:#1a5786">意见反馈</span></div>
    <div>
		 <iframe id="iframeright" name="iframeright" scrolling="no" frameborder="0" width="100%" height="200" src="yjfk.jsp"></iframe>
	</div>
  </div>

</div>
</div>
<jsp:include page="foot.jsp" />
</body>
</html>
