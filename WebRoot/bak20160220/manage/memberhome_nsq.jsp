<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%><%
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");

if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
ResultSet rs = null;

String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);

String [][]mess = DataManager.fetchFieldValue(pool,"member_message","site_flag,count(*)","sort_flag=2 and recipients_mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' group by site_flag");
String [][]mess2 = DataManager.fetchFieldValue(pool,"member_message","count(*)","sort_flag=1 and recipients_mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_read=0");

String [][]tempMemberInfo = DataManager.fetchFieldValue(pool,"member_info","flag_job,flag_21part,flag_bbs,flag_space,flag_blog,mem_name,mem_flag_name,convert(varchar(10),mem_flag_enddate,21),login_last_date,login_last_ip","state=1 and mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' ");

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
<div class="loginlist_right">
<div class="loginok_center">
  <div class="loginok_center1"> <img src="/images/none.gif" width="78" height="64" class="imgleft"/> <span class="big"><%=memberInfo.get("mem_no")%> [ <%=tempMemberInfo!=null&&tempMemberInfo[0][5]!=null?Common.getFormatStr(tempMemberInfo[0][5]):"-"%> ]</span><br />
    会员类型：<span class="blackb"><%=tempMemberInfo!=null&&tempMemberInfo[0][6]!=null?Common.getFormatStr(tempMemberInfo[0][6]):"-"%></span>  &nbsp;&nbsp;&nbsp;&nbsp;到期时间：<span class="blackb"><%=tempMemberInfo!=null&&tempMemberInfo[0][7]!=null?Common.getFormatStr(tempMemberInfo[0][7]):"-"%></span><br />
上次登录：<span class="blackb"><%=tempMemberInfo!=null&&tempMemberInfo[0][8]!=null?Common.getFormatStr(tempMemberInfo[0][8]):"-"%></span> 在 <span class="blackb"><%=tempMemberInfo!=null&&tempMemberInfo[0][9]!=null?Common.getFormatStr(tempMemberInfo[0][9]):"-"%><!--<%=Common.getFormatStr(memberInfo.get("login_last_city"))%>--></span>登陆<br/>
  </div>

  <div class="loginok_center3">
    <div class="loginok_center3_1"><span class="bigblueb">信息提醒</span></div>
    <div class="loginok_center3_2">
	  <%if(Common.getFormatStr(memberInfo.get("comp_name")).equals("") || Common.getFormatStr(memberInfo.get("comp_address")).equals("") || Common.getFormatStr(memberInfo.get("comp_url")).equals("") ){%>
	  <strong>会员信息：</strong>你的会员信息中关于公司方面的信息录入不全，<a href="/other/user_info_opt.jsp" class="blue12">点击此处进入请补充公司信息</a><br/><%}%>
       <%if(Common.getFormatStr(memberInfo.get("comp_intro")).equals("")){%>
       <strong>公司介绍：</strong>您的公司介绍还没有填写，完整的公司介绍，可以让更多的浏览者了解您，<a href="/other/user_info_opt.jsp" class="blue12">点击此处进入请补充公司介绍</a><br/><%}%>
       <strong>企业活跃度：</strong>您的企业活跃度为中，建议您多登录，多发信息，提高企业活跃度和诚信度<br/>
	    <strong>我的询价留言：</strong><%for(int i=0;mess!=null&&i<mess.length;i++){%><%
		 String siteFlag = mess[i][0];
		if(siteFlag.equals("1")){
			out.println("<a href='/other/message_list.jsp?sort_flag=1&site_flag=1'>租赁调剂("+mess[i][1]+")</a>");
		}else if(siteFlag.equals("2")){
			out.println("<a href='/other/message_list.jsp?sort_flag=2&site_flag=2'>二手市场("+mess[i][1]+")</a>");
		}else if(siteFlag.equals("4")){
			out.println("<a href='/other/message_list.jsp?sort_flag=2&site_flag=4'>配件市场("+mess[i][1]+")</a>");
		}else if(siteFlag.equals("5")){
			out.println("<a href='/other/message_list.jsp?sort_flag=2&site_flag=5'>供求市场("+mess[i][1]+")</a>");
		}
		%>&nbsp;&nbsp;&nbsp;&nbsp;<%}%>
		<%if(!mess2[0][0].equals("0")){%><a class="r" href="/other/message_recipients_list.jsp" id="hint" title=""><b>未阅读提醒(<%=mess2[0][0]%>)</b></a>
<script type="text/javascript">
var color = ['#ff0000','#ff00ff','#00ff00','#00ffff','#0000ff','#ffcc00'];
var i=0;
function FlashHintColor(obj)
{
 obj.style.color=color[i];
 i = (i+5)%color.length;  
}
window.setInterval("FlashHintColor(document.getElementById('hint'))",200);
</script>
<%}%>
    </div>
  </div>
  <div class="loginok_center3">
    <div class="loginok_center3_1"><span class="bigblueb">便捷通道</span></div>
    <div class="loginok_center3_2">
      <div class="loginok_center3_2_1">
        <ul>
          <li><a href="http://www.21-cmjob.com" target="_blank"><img src="/images/rcwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://www.21-cmjob.com" target="_blank">人才网</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][0]!=null&&Common.getFormatStr(tempMemberInfo[0][0]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="javascript:openDivWin('','/comjob/member_start.jsp?key=<%=keyPar%>',400,200)" class="hong"><font color="#FF0000">未开通，点击开通</font></a>)
            <%}%>
            <br/>
            <span class="data"><a href="http://www.21-cmjob.com" target="_blank">www.21-cmjob.com</a></span></li>
          <li><a href="http://www.21part.com" target="_blank"><img src="/images/jpwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://www.21part.com" target="_blank">杰配网</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][1]!=null&&Common.getFormatStr(tempMemberInfo[0][1]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="javascript:openDivWin('','/21part/member_start.jsp?key=<%=keyPar%>',400,200)" class="hong" ><font color="#FF0000">未开通，点击开通</font></a>)
            <%}%>
            <br/>
              <span class="data"><a href="http://www.21part.com" target="_blank">www.21part.com</a></span></li>
          <li><a href="http://bbs.21-sun.com" target="_blank"><img src="/images/smwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://bbs.21-sun.com" target="_blank">铁臂论坛</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][2]!=null&&Common.getFormatStr(tempMemberInfo[0][2]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://bbs.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂论坛吗？')){return false;} "><font color="#FF0000">未开通，点击开通</font></a>)
            <%}%>
            <br/>
              <span class="data"><a href="http://bbs.21-sun.com" target="_blank">bbs.21-sun.com</a></span></li>
          <li><a href="http://space.21-sun.com" target="_blank"><img src="/images/tbsplogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://space.21-sun.com" target="_blank">铁臂社区</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][3]!=null&&Common.getFormatStr(tempMemberInfo[0][3]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://space.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂社区吗？')){return false;} "><font color="#FF0000">未开通，点击开通</font></a>)
            <%}%> <br/>
              <span class="data"><a href="http://space.21-sun.com" target="_blank">space.21-sun.com</a></span></li>
          <li><a href="http://blog.21-sun.com" target="_blank"><img src="/images/smwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://blog.21-sun.com" target="_blank">铁臂博客</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][4]!=null&&Common.getFormatStr(tempMemberInfo[0][4]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://blog.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂博客吗？')){return false;} "><font color="#FF0000">未开通，点击开通</font></a>)
            <%}%>
            <br/>
              <span class="data"><a href="http://blog.21-sun.com" target="_blank">blog.21-sun.com</a></span>
			</li>
        </ul>
      </div>
     
    </div>
  </div>
</div>
<div class="loginok_right">
  <div class="loginok_right_1">
    <div class="loginok_right_1_1"  ><span class="red14">21-SUN公告</span></div>
    <div class="loginok_right3_2">
      <ul>
        <li><a target="_blank" href="http://data.21-sun.com" class="blue12">2010-2012年中国液压破碎锤市场发展研究及前景预测</a></li>
		<li><a target="_blank" href="http://data.21-sun.com" class="blue12">
			电子版：9800元/份。<br />电话：0535- 6722555  6727766  6723251</a> </li>
      </ul>
	   <div class="loginok_right_2_2_1"><a href="http://www.21-cmjob.com/" target="_blank"><img src="/images/rencai200.gif" alt="中国工作机械人才网" width="200" height="78"  border="0"/></a></div>
	   <div class="loginok_right_2_2_1"><a href="http://space.21-sun.com/" target="_blank"><img src="/images/tiebi.gif"   border="0"/></a></div>
    </div>
  </div>

</div>
</div>
</body>
</html>
