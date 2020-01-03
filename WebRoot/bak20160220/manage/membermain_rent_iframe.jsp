<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %><%HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String sessionMemNo=((String)memberInfo.get("mem_no"));
String cacheName = "membermain_rent"+sessionMemNo;
%>

<%
	if(pool==null){
		pool = new PoolManager();
	}
	PoolManager pool3= new PoolManager(3);
	
	String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);
	
   String [][]tempMemberInfo = DataManager.fetchFieldValue(pool,"member_info","flag_job,flag_21part,flag_bbs,flag_space,flag_blog,mem_name,mem_flag_name,convert(varchar(10),mem_flag_enddate,21),convert(varchar(19),login_last_date,21),login_last_ip"," mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and state=1 ");
	
	String messRent="0";//租赁留言信息 
    String [][]mess = DataManager.fetchFieldValue(pool,"member_message","count(id)"," recipients_mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and site_flag ='1' and  sort_flag=1 ");
	if(mess!=null){
	   messRent = Common.getFormatInt(mess[0][0]);
	 }

   String[][] rentInfo=null;
   
   String purview_name    = Common.getFormatStr(request.getParameter("purview_name"));  
  
   if(!purview_name.equals("")){
       purview_name = Common.decryptionByDES(purview_name); //解密
   }
   String site_flag  = Common.getFormatStr(request.getParameter("site_flag"));
   int rentBuyCount=0,rentSellCount=0;//求租、出租 租赁数量
   if(site_flag.equals("24")){ //租赁
		 rentInfo = DataManager.fetchFieldValue(pool3,"rent_info","sum(case when class ='0' then 1 else 0  end),sum(case when class ='1' then 1 else 0  end)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1 ");
		 if(rentInfo!=null){rentBuyCount = Integer.parseInt(Common.getFormatInt(rentInfo[0][0]));
		 rentSellCount = Integer.parseInt(Common.getFormatInt(rentInfo[0][1]));
		 }
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
 <%if(site_flag.equals("24")){%>
<a style="color:#000">我的租赁：</a>您共发布了<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=37" target="_parent"><b><%=rentBuyCount%></b></a>条求租信息,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=37" target="_parent"><b><%=rentSellCount%></b></a>条出租信息,收到<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=38" target="_parent"><b><%=messRent%></b></a>条留言&nbsp;&nbsp;&nbsp; <br /><%if((rentBuyCount+rentSellCount)<5){%>您发布的信息量过少，为获得更多商机，建议您增加信息发布量！<%}%><a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=4" target="_parent">发布租赁信息</a><br /><%}%>

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

</div>
</body>
</html>
