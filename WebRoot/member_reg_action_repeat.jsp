<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@ include file ="include/config.jsp"%>
<%
	String memNo = Common.getFormatStr(request.getParameter("mem_no"));
	String perEmail = Common.getFormatStr(request.getParameter("perEmail"));
	String passw = Common.getFormatStr(request.getParameter("passw"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员注册 - 中国工程机械商贸网</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/tablestyle.css" rel="stylesheet" type="text/css" />
<script src="scripts/jquery-1.4.1.min.js"  type="text/javascript"></script>
<script src="scripts/citys.js"  type="text/javascript"></script>
<script src="scripts/zhucheyanzheng.js"  type="text/javascript"></script>
</head>
<body>
<jsp:include page="manage/top.jsp" />
<div class="weizhi">
  <div class="weizhi_1">您的位置 >> 我的商贸网</div>
  <div style="float:right"><a href="/" class="blue">登录</a></div>
</div>
<div class="center">
  <div class="zhuce">
    <ul class="step">
      <li class="step1"></li>
      <li class="steparrow"></li>
      <li class="step3"></li>
      <li class="steparrow"></li>
      <li class="step6_c"></li>
    </ul>
  </div>
  <div class="zhuce1">
    <%
	//发送验证邮件
	try{
 		WEBEmail.sendMailByUrl(perEmail,null,null,"商贸网注册激活邮件","http://member.21-sun.com/tools/data/active_to_email.jsp?no="+memNo+"&pa="+passw+"&em="+perEmail,"utf-8");
	}catch (Exception e){
		e.printStackTrace();
	}

%>
    <table width="60%" border="0" align="center">
      <tr>
        <td valign="top" style="margin:20px 0px">
          <span style="color:#F60;font-weight:bold;">重复激活邮件已发送,请到邮箱<a class="blue12" href="http://mail.<%=perEmail.substring(perEmail.indexOf("@")+1)%>" target="_blank"><%=perEmail%></a>中激活完成注册</span><br /<br />
          如有疑问，请电话联系：0535-6792736</td>
      </tr>
    </table>
  </div>
</div>
<div class="top2">
  <div class="centertext_1">
    <div class="renarrow">会员介绍</div>
  </div>
  <div class="centertext">
    <div class="centertext1">
      <div class="centertext2"> <a href="http://main.21-sun.com/service/huiyuan/member_vip.htm" class="b14" target="_blank">VIP会员</a><br/>
        ·市场调研服务<br/>
        ·新闻采访服务<br/>
        ·市场支持服务<br/>
        ·品牌宣传服务</div>
      <div class="centertext3" ><a href="http://main.21-sun.com/service/huiyuan/member_vip.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://main.21-sun.com/service/huiyuan/member_b.htm" class="b14" target="_blank">B类会员</a> <br/>
        ·数据信息支持服务<br/>
        ·新闻采集、报道、采访<br/>
        ·市场信息支持服务<br/>
        ·广告服务支持</div>
      <div class="centertext3" ><a href="http://main.21-sun.com/service/huiyuan/member_b.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://main.21-sun.com/service/huiyuan/member_a.htm" class="b14" target="_blank">A类会员</a> <br/>
        ·网站建设服务<br/>
        ·信息支持服务<br/>
        ·广告服务支持<br/>
        <br/>
      </div>
      <div class="centertext3" ><a href="http://main.21-sun.com/service/huiyuan/member_a.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/rent/gg/huiyuan.htm" class="b14" target="_blank">租赁通会员</a> <br/>
        ·租赁信息排名靠前<br/>
        ·获得网上租赁店铺<br/>
        ·查看客户的留言回馈<br/>
        ·超值广告服务</div>
      <div class="centertext3" ><a href="http://www.21-sun.com/rent/gg/huiyuan.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1_1">
      <div class="centertext2"> <a href="http://www.21-cmjob.com/member/service/index.shtm" class="b14" target="_blank">人才网会员</a> <br/>
        ·金伯乐会员<br/>
        ·银伯乐会员<br/>
        ·季度会员<br/>
        ·月度会员</div>
      <div class="centertext3" ><a href="http://www.21-cmjob.com/member/service/index.shtm" target="_blank">查看详情</a></div>
    </div>
  </div>
</div>
<jsp:include page="manage/foot.jsp" />
</body>
</html>
