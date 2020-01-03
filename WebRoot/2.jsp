<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"	%>
<%@page import="com.jerehnet.util.common.CommonString"%><%@ include file ="include/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
String memNo = Common.getMemberInfo("mem_no", pool, request,"member_info", "mem_no","passw","memberInfo");
String addflag=Common.getFormatInt(request.getParameter("addflag")).equals("0")?"1":Common.getFormatInt(request.getParameter("addflag"));
String source = CommonString.getFormatPara(request.getParameter("source"));
if(source.equals("part")){
	addflag = "64";
}
if(!(memNo.equals("-8888") || memNo.equals("-9999"))){
	response.sendRedirect("/manage/membermain.jsp?addflag="+addflag);  // 单点登陆 
}

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta property="qc:admins" content="2265566612252621535663757" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>会员登录--中国工程机械商贸网</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.2.min.js"></script>
<script src=" http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=3516048995" type="text/javascript" charset="utf-8"></script>
<script language="javascript">
 var _speedMark = new Date();
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
<div class="weizhi">
  <div class="weizhi_1">您的位置 >> 我的商贸网</div>
  <div class="weizhi_2"> <a href="http://www.21-sun.com/service/index.htm" target="_blank"><img src="images/bot01.gif" alt="" width="12" height="12" border="0" /></a><a href="http://www.21-part.com" id="hint" target="_blank"> 配件网全面升级，配件企业上网首选！</a><script type="text/javascript"> 
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
        <table width="85%" border="0">
          <tr>
            <td width="20%"><span class="grayb">用户名：</span></td>
            <td width="51%"><label>
             <input name="mem_no" type="text" tabindex="1" id="mem_no" style="width:140px" maxlength="50"/>
              </label></td>
            <td width="29%" rowspan="2"  valign="bottom"><img src="images/login.gif" width="79" height="29" style="cursor:pointer" onclick="tjYanzheng();"/>&nbsp;<br /><a href="/member_pass_find.jsp" class="blue14">忘记密码？</a></td>
          </tr>
          <tr>
            <td><span class="grayb">密　码：</span></td>
            <td><input name="passw" tabindex="2" type="password" id="passw"  style="width:140px" maxlength="50"/></td>
          </tr>
		  <tr>
            <td><span class="grayb">验证码：</span></td>
            <td valign="middle"><input name="rand" tabindex="3" type="text" id="rand" style="width:80px" maxlength="20"/>
            <img src="/auth/authImgServlet?now=<%=new java.util.Date()%>" name="authImg" align="middle" id="authImg" title="如果您看不清，请在图片上单击，可以更换验证码！" onClick="refresh();"/></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3" style="padding:6px 0px;">
            <table width="338" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="121"><span class="grayb">使用其它帐号登录：</span></td>
                <td width="217" valign="middle">
                  <span><a href="javascript:;" target="_parent" onclick="javascript:oauthLogin(2) ;"> 
                  <img src="/images/sina.png"  style=" vertical-align:-2px;"/>&nbsp;微博登录</a></span>
                  &nbsp; <span><a href="javascript:;" target="_parent" onclick="oauthLogin(4)">
                  <img src="/images/qq.png" style=" vertical-align:-3px; "/>&nbsp;QQ登录</a></span> </td>
               </tr>
            </table>  
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td height="40px"><!--<a href="#" class="blue14">忘记密码？</a>--> <a href="<%if(!source.equals("")){ %>member_reg.jsp?source=<%=source%><%}else{ %>member_reg.jsp<%} %>" class="blue14">马上免费注册</a></td>
            <td>&nbsp;
            <input name="f" type="hidden" value="<%=Common.getFormatStr(request.getParameter("f")) %>" />
            </td>
          </tr>
        </table>
        <input type="hidden" name="loginCity" id="loginCity"  />
        <input type="hidden" name="source" value="<%=source %>"  />
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
  <!--<div class="center2"><a href="http://www.21-sun.com/service/index.htm" target="_blank"><img src="images/right.gif" width="354" height="231" border="0" /></a></div>-->
  <div class="center2"><a href="http://cio.21-sun.com/" target="_blank"><img src="http://ad.21-sun.com/homepic/cio/cio_2014.gif" width="354" height="231" border="0" /></a></div>
  
</div>
<div class="top2">
  <div class="centertext_1">
    <div class="renarrow">会员介绍</div>
  </div>
  <div class="centertext">
    
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_a.htm" class="b14" target="_blank">A类会员</a> <br/>
        ·网站制作服务<br/>
        ·信息支持服务<br/>
        ·广告服务支持<br/><br/></div>
      <div class="centertext3" ><a href="http://www.21-sun.com/service/huiyuan/member_a.htm" target="_blank">查看详情</a></div>
    </div>
    
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_zl.htm" class="b14" target="_blank">租赁通会员</a> <br/>
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
        ·银伯乐会员<br/><br/></div>
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
jQuery(function(){
	setTimeout(function(){	
		jQuery("img[src*='Connect_logo_7.png']").attr("src","http://qzonestyle.gtimg.cn/qzone/vas/opensns/res/img/Connect_logo_1.png") ;
	},1000) ;
}) ;
	 var iWidth=460; //窗口宽度
      var iHeight=400;//窗口高度
var iTop=(window.screen.height-iHeight)/2;
var iLeft=(window.screen.width-iWidth)/2;
function openplatform(tag){
	if('sina'==jQuery.trim(tag)){
		window.open("https://api.weibo.com/oauth2/authorize?client_id=3516048995&redirect_uri=http://member.21-sun.com/openplatform/sina.jsp&response_type=code",'新浪微博登录','height=400,width=460,top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
	}
	if('qq'==tag){
		window.open("https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=100365337&scope=all&redirect_uri=http://member.21-sun.com/openplatform/qq.jsp",'QQ登录','height=400,width=460,top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
	}
}

function oauthLogin(id)
{
	//以下为按钮点击事件的逻辑。注意这里要重新打开窗口，窗口的大小需要固定
	//否则后面跳转到QQ登录，授权页面时会直接缩小当前浏览器的窗口，而不是打开新窗口
	var left,top;
	if(id==2){var w=650;h=360;left=50;top=100;} // sina 
	if(id==4){var w=570;h=460;left=10;top=50;}  // qq
	var A=window.open("http://member.21-sun.com/openplatform/?to="+id+"&do=login&go=http://member.21-sun.com/","WinLogin",
	"width="+w+",height="+h+",left="+parseInt((screen.availWidth -  w)/2-left)+",top="+parseInt((screen.availHeight - h)/2-top)+",menubar=0,scrollbars=0,resizable=1,status=0,titlebar=0,toolbar=0,location=0");
}
jQuery(function(){
	jQuery("#mem_no").focus();
});
jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"]; 
	var city = remote_ip_info["city"];  // 登录地点城市 
	jQuery("#loginCity").val(province+''+city) ;
}) ;
</script>

<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
#ads02 { position:fixed; right:0px; top:80px; z-index:99999; width:42px; height:350px;}
* html #ads02 {position:absolute; left:expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,0)||0)-(parseInt(this.currentStyle.marginRight,0)||0)); top:expression(eval(document.documentElement.scrollTop)+100);}
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>
<!--对联广告-->
<div id="ads01" class="ads_hover">
<a href="http://cio.21-sun.com/" target="blank" style="display:block;"><img src="http://ad.21-sun.com/homepic/21taiyang/leftx_20140509.gif" width="42" height="330" class="ads_small" /><img src="http://ad.21-sun.com/homepic/cio/cio_2014_l.gif" width="95" height="330" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads01').className='hide';document.getElementById('ads02').className='hide';" style="cursor:pointer; margin-top:1px; float:left;" />
</div>
<div id="ads02" class="ads_hover">
<a href="http://cio.21-sun.com/" target="blank" style="display:block;"><img src="http://ad.21-sun.com/homepic/cio/cio_2014_r.gif" width="95" height="330" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads01').className='hide';document.getElementById('ads02').className='hide';" style="cursor:pointer; margin-top:1px; float:right;" />
</div>
<!--对联广告结束-->

</body>
</html>
