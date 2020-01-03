<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="include/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}

String memNo = Common.getMemberInfo("mem_no", pool, request,"member_info", "mem_no","passw","memberInfo");
String addflag=Common.getFormatInt(request.getParameter("addflag"));
if(!(memNo.equals("-8888") || memNo.equals("-9999"))){
	//response.sendRedirect("/manage/membermain.jsp?addflag="+addflag);
	response.sendRedirect("/manage/membermain.jsp?addflag="+addflag);
}

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员登录--中国工程机械商贸网</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script language="javascript">
function tjYanzheng(){
	if(document.theform.mem_no.value==""){
		alert("用户名不能为空！");
		document.theform.mem_no.focus();
		return false;
	}else if(document.theform.passw.value==""){
		alert("密码不能为空！");
		document.theform.passw.focus();
		return false;
	}else if(document.theform.rand.value==""){
		alert("验证码不能为空！");
		document.theform.rand.focus();
		return false;
	}
	document.theform.submit();
}

function KeyDown(e)
{var e =e||window.event;
    if (e.keyCode == 13)
    {
        e.returnValue=false;
        e.cancel = true;
        tjYanzheng();
    }
}

</script>
</head>
<body>
<jsp:include page="manage/top.jsp" />
<div class="weizhi"><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="950" height="80" id="sws" align="middle">
<param name="allowScriptAccess" value="sameDomain" />
<param name="movie" value="http://ad.21-sun.com/gg/950/sws.swf" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" /><embed src="http://ad.21-sun.com/gg/950/sws.swf" quality="high" bgcolor="#ffffff" width="950" height="80" name="sws" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object></div>
<div class="weizhi">
  <div class="weizhi_1">您的位置 >> 我的商贸网</div>
  <div class="weizhi_2"> <a href="http://www.21-sun.com/service/index.htm" target="_blank"><img src="images/bot01.gif" alt="" width="12" height="12" border="0" /></a><a href="http://part.21-sun.com" id="hint" target="_blank"> 配件网全面升级，配件企业上网首选！</a><script type="text/javascript"> 
var color = ['#ff0000','#ff00ff','#00ff00','#00ffff','#0000ff','#ffcc00'];
var i=0;
function FlashHintColor(obj)
{
 obj.style.color=color[i];
 i = (i+5)%color.length;  
}
window.setInterval("FlashHintColor(document.getElementById('hint'))",200);
  </script>
  </div>
</div>
<div class="center">
  <div class="center1">
    <div class="center1_1"><span class="mainyh">请登录21-SUN通行证</span><br />
      登录后您可以畅游中国工程机械商贸网旗下所有网站，无须再次登录！</div>
    <div class="center1_2">
      <form id="theform" name="theform" method="post" action="member_login_action.jsp" onkeydown="KeyDown(event)" target="_parent">
        <table width="85%" border="0" align="center">
          <tr>
            <td width="20%"><span class="grayb">用户名：</span></td>
            <td width="51%"><label>
             <input name="mem_no" type="text" id="mem_no" style="width:140px" maxlength="50"/>
              </label></td>
            <td width="29%" rowspan="2"  valign="bottom"><img src="images/login.gif" width="79" height="29" style="cursor:pointer" onclick="tjYanzheng();"/>&nbsp;</td>
          </tr>
          <tr>
            <td><span class="grayb">密　码：</span></td>
            <td><input name="passw" type="password" id="passw"  style="width:140px" maxlength="50"/></td>
          </tr>
		  <tr>
            <td><span class="grayb">验证码：</span></td>
            <td valign="middle"><input name="rand" type="text" id="rand" style="width:80px" maxlength="20"/>
            <img src="/auth/authImgServlet?now=<%=new java.util.Date()%>" name="authImg" align="middle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td height="40px"><!--<a href="#" class="blue14">忘记密码？</a>--> <a href="member_reg.jsp" class="blue14">马上免费注册</a></td>
            <td>&nbsp;</td>
          </tr>
        </table>
      </form>
      <div class="center1_line">
        <!---->
      </div>
      <div class="center1_1"><span class="main14">登录后，您即可享受以下会员服务:</span><br />
        ·发布信息，畅通无阻<br />
        ·拥有自己的商务室，信息商情自己把握。<br />
        <!--·拥有自己的铁臂社区，给您一个交友、分享、交流的空间<br />-->
      </div>
    </div>
  </div>
  <div class="center2"><a href="http://www.21-sun.com/service/index.htm" target="_blank"><a href="http://www.21-sun.com/service/index.htm" target="_blank"><img src="images/right.gif" width="354" height="231" border="0" /></a></a></div>
</div>
<div class="top2">
  <div class="centertext_1">
    <div class="renarrow">会员介绍</div>
  </div>
  <div class="centertext">
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_vip.htm" class="b14" target="_blank">VIP会员</a><br/>
        ·市场调研服务<br/>
        ·新闻采访服务<br/>
        ·市场支持服务<br/>
        ·品牌宣传服务</div>
      <div class="centertext3" ><a href="http://www.21-sun.com/service/huiyuan/member_vip.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_b.htm" class="b14" target="_blank">B类会员</a> <br/>
        ·数据信息支持服务<br/>
        ·新闻采集、报道、采访<br/>
        ·市场信息支持服务<br/>
      ·广告服务支持</div>
      <div class="centertext3" ><a href="http://www.21-sun.com/service/huiyuan/member_b.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_a.htm" class="b14" target="_blank">A类会员</a> <br/>
        ·网站建设服务<br/>
        ·信息支持服务<br/>
        ·广告服务支持<br/><br/></div>
      <div class="centertext3" ><a href="http://www.21-sun.com/service/huiyuan/member_a.htm" target="_blank">查看详情</a></div>
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
        ·超级银伯乐会员<br/>
        ·银伯乐会员<br/>
        ·季度会员</div>
      <div class="centertext3" ><a href="http://www.21-cmjob.com/member/service/index.shtm" target="_blank">查看详情</a></div>
    </div>
  </div>
</div>
<jsp:include page="manage/foot.jsp" />
<script>
function refresh(){
	document.getElementById("authImg").src='/auth/authImgServlet?now=' + new Date();
}
//refresh();
</script>
</body>
</html>
