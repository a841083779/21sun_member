<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %><%HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String sessionMemNo=((String)memberInfo.get("mem_no"));
String cacheName = "membermain_part"+sessionMemNo;
%>
<cache:cache key="<%=cacheName%>" cron="* */12 * * *">
<%
	if(pool==null){
		pool = new PoolManager();
	}
	PoolManager pool7= new PoolManager(7);
	
	String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);
	
   String [][]tempMemberInfo = DataManager.fetchFieldValue(pool,"member_info","flag_job,flag_21part,flag_bbs,flag_space,flag_blog,mem_name,mem_flag_name,convert(varchar(10),mem_flag_enddate,21),convert(varchar(19),login_last_date,21),login_last_ip"," mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and state=1 ");
	
	String messParts="0";//配件留言信息
	    
	String [][]mess = DataManager.fetchFieldValue(pool,"member_message","count(id)"," recipients_mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and site_flag ='4' and sort_flag=1"); //配件留言信息
	if(mess!=null){
	   messParts =Common.getFormatInt(mess[0][0]);
 }

   String[][] partsInfoBuy=null,partsInfoSell=null;
   
   String purview_name    = Common.getFormatStr(request.getParameter("purview_name"));  
  
   if(!purview_name.equals("")){
       purview_name = Common.decryptionByDES(purview_name); //解密
   }
  String site_flag  = Common.getFormatStr(request.getParameter("site_flag"));
   int partsBuyCount=0,partsSellCount=0; //配件求购、出售的数量
   if(site_flag.equals("23")){ //配件
	   partsInfoBuy = DataManager.fetchFieldValue(pool7,"buy","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1 ");
	   if(partsInfoBuy!=null){partsBuyCount = Integer.parseInt(Common.getFormatInt(partsInfoBuy[0][0]));}
	   
	   partsInfoSell = DataManager.fetchFieldValue(pool7,"supply","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' ");
	   if(partsInfoSell!=null){partsSellCount = Integer.parseInt(Common.getFormatInt(partsInfoSell[0][0]));}
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/divopenwin/lhgdialog.js"></script>
<script type="text/javascript" src="/scripts/common.js"></script>
</head>
<body>
<div class="loginlist_right" style="height:auto;overflow:hidden">  
  <div class="loginok_center" style="width:545px;float:left;margin-right:0px">
  <div class="loginok_center1" style="width:522px;border:1px #e4eef8 solid">
   <!--<div class="swszwpic"><img src="../images/zwpic.gif" /></div>-->
   <div class="swsinformation" style="width:430px"><font style="color:#3778ba;font-family:微软雅黑;font-size:14px">您好！<%=Common.getFormatStr(memberInfo.get("mem_no"))%></font> <a style="color:#3f4244;font-size:14px;font-family:微软雅黑">[<%=Common.getFormatStr(memberInfo.get("mem_name"))%>]</a><b style="font-size:14px;color:#ff8900;">　欢迎来到“<%=purview_name%>”</b><br />
   <a style="color:#989796">会员类型：</a><b style="font-size:14px;color:#fc7f04"><%=tempMemberInfo!=null&&tempMemberInfo[0][6]!=null&&!tempMemberInfo[0][6].equals("")?Common.getFormatStr(tempMemberInfo[0][6]):"-"%></b>&nbsp;&nbsp; 
   <a style="color:#989796"> 到期时间：</a><a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][7]!=null&&!tempMemberInfo[0][7].equals("")?Common.getFormatStr(tempMemberInfo[0][7]):"-"%></a><br />
    <a style="color:#989796">上次登陆：</a><a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][8]!=null&&!tempMemberInfo[0][8].equals("")?Common.getFormatStr(tempMemberInfo[0][8]):"-"%></a>   <a style="color:#989796">在</a>  <a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][9]!=null&&!tempMemberInfo[0][9].equals("")?Common.getFormatStr(tempMemberInfo[0][9]):"-"%></a></b>  <a style="color:#989796">登录</a></div>
  </div>

  <div class="loginok_center3" style="width:543px">
    <div class="loginok_center3_1"><span class="bigblueb">信息提醒</span></div>
    <div class="loginok_center3_2"> 
<%if(site_flag.equals("23")){%>
<a style="color:#000">配件网空间站：</a>您共发布了<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=40" target="_parent"><b><%=partsBuyCount%></b></a>条求购信息,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=41" target="_parent"><b><%=partsSellCount%></b></a>条供应信息,收到<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=43" target="_parent"><b><%=messParts%></b></a>条留言&nbsp;&nbsp;&nbsp;&nbsp; <br /><%if((partsBuyCount+partsSellCount)<5){%>您发布的信息量过少，为获得更多商机，建议您增加信息发布量！<%}%><a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=8" target="_parent">发布配件求购</a>&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=2" target="_parent">发布配件供应</a><br /><%}%>

</div>
  </div>
  <div class="loginok_center3" style="width:543px">
    <div class="loginok_center3_1"><span class="bigblueb">便捷通道</span></div>
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
            (<a href="http://bbs.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onClick="if(!confirm('您确认要开通铁臂论坛吗？')){return false;} "><font color="#FF0000">点击开通</font></a>)
            <%}%>
            <br/>
              <span class="data"><a href="http://bbs.21-sun.com" target="_blank">bbs.21-sun.com</a></span></li>
          <li><a href="http://space.21-sun.com" target="_blank"><img src="/images/tbsplogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://space.21-sun.com" target="_blank">铁臂社区</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][3]!=null&&Common.getFormatStr(tempMemberInfo[0][3]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://space.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onClick="if(!confirm('您确认要开通铁臂社区吗？')){return false;} "><font color="#FF0000">点击开通</font></a>)
            <%}%> <br/>
              <span class="data"><a href="http://space.21-sun.com" target="_blank">space.21-sun.com</a></span></li>
          <li><a href="http://blog.21-sun.com" target="_blank"><img src="/images/smwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://blog.21-sun.com" target="_blank">铁臂博客</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][4]!=null&&Common.getFormatStr(tempMemberInfo[0][4]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://blog.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onClick="if(!confirm('您确认要开通铁臂博客吗？')){return false;} "><font color="#FF0000">点击开通</font></a>)
            <%}%>
            <br/>
              <span class="data"><a href="http://blog.21-sun.com" target="_blank">blog.21-sun.com</a></span>
			</li>
        </ul>
      </div>
     
    </div>
  </div>
</div>
<div class="loginok_right" style="float:right;height:auto;overflow:hidden">
  <div class="loginok_right_1">
    <div class="loginok_right_1_1"  ><span class="red14">21-SUN公告</span></div>
    <div class="loginok_right3_2">
      <ul>
	  <li><a target="_blank" href="http://stock.21-sun.com/  " class="blue12"><font color="#FF0000">博览行业财经动态，专家解读股市悬机！行业股市专区--您的财富直通车！</font></a></li>
        <li><a target="_blank" href="http://data.21-sun.com/show.jsp?kid=8034&oldflag=" class="blue12">中国破碎锤行业分析及前景预测报告</a></li>
		<li><a target="_blank" href="http://data.21-sun.com" class="blue12">工程机械行业深度调研与咨询，为您提供全方位专业分析<br />电话：0535-6723226</a><br />
		邮箱：<a href="mailto:yangjf@21-sun.com">yangjf@21-sun.com</a> </li>
      </ul><img src="/images/rencai200.gif" alt="中国工程机械人才网" width="200" height="78"  border="0"/>
	   <div class="loginok_right_2_2_1"><a href="http://www.21-cmjob.com/" target="_blank"></a></div></div>
  </div>
<div class="loginok_right_1" style="height:213px">
    <div class="loginok_right_1_1"  ><span class="red14" style="color:#1a5786">意见反馈</span></div>
    <div>
		<iframe id="iframeright" name="iframeright" scrolling="no" frameborder="0" width="100%" height="213px" src="yjfk.jsp"></iframe>
	</div>
  </div>
</div>
</div>
</body>
</html>
</cache:cache>