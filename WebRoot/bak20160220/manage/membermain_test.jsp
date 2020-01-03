<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
ResultSet rs = null;

Connection conn2 =null;
ResultSet rs2 = null;

HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);

String addflag = Common.getFormatStr(request.getParameter("addflag"));
String iframeFilename = "memberhome.jsp";
if(addflag.equals("1")){	
	iframeFilename = "/market/market_opt.jsp";//市场供求
}else if(addflag.equals("2")){
	iframeFilename = "/parts/market_opt.jsp";//配件供求
}else if(addflag.equals("3")){
	iframeFilename = "/parts/store_opt.jsp";//配件仓库管理
}else if(addflag.equals("4")){
	iframeFilename = "/rent/rent_opt.jsp";//租赁供求
}else if(addflag.equals("5")){
	iframeFilename = "/usedmarket/buy_opt.jsp";//二手求购
}else  if(addflag.equals("6")){
	iframeFilename = "/usedmarket/sale_opt.jsp";//二手出售
}

//System.out.println("===="+memberInfo); 

try{
//String sql = "select * from member_purview where len(purview_num)=4  ";
String sql = "select p.* from member_purview p,member_role_purview r where len(p.purview_num)=4 and p.purview_num=r.purview_num and r.role_num='"+((String)memberInfo.get("mem_flag"))+"'  ";

conn = pool.getConnection();
conn2 = pool.getConnection();
rs = DataManager.executeQuery(conn,sql);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的商贸网 - 中国工程机械商贸网</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script src="/scripts/common.js"  type="text/javascript"></script>
<link href="/style/menu.css" rel="stylesheet" type="text/css" />

<style type="text/css">
#winpop { width:380px; height:0px; position:absolute; right:0; bottom:0; border:0px solid #666; margin:0; padding:1px; overflow:hidden; display:none; padding-right:50px}
#winpop .title { width:100%; height:22px; line-height:20px; background:#d1d1d1; font-weight:bold; text-align:center; font-size:12px;}
#winpop .con { width:100%; height:350px; line-height:80px; font-weight:bold; font-size:12px; color:#FF0000; text-decoration:underline; text-align:center} 
.close { position:absolute; right:4px; top:-1px; color:#FFF; cursor:pointer}
</style>

<script language="javascript">
function SetCwinHeight(){
  var right=document.getElementById("iframeRight"); //iframe id
  if (document.getElementById){
   if (right && !window.opera){
    if (right.contentDocument && right.contentDocument.body.offsetHeight){
     if(right.contentDocument.body.offsetHeight<300)
	 right.height =right.contentDocument.body.offsetHeight+100;
	 else
	 right.height =right.contentDocument.body.offsetHeight;
    }else if(right.Document && right.Document.body.scrollHeight){
	　if(right.Document.body.scrollHeight<300)
     right.height = right.Document.body.scrollHeight+100;
	 else
	 right.height = right.Document.body.scrollHeight;
	 
    }
   }
  }
 }
<%if(addflag.equals("")){%>
function tips_pop(){
  var MsgPop=document.getElementById("winpop");
  var popH=parseInt(MsgPop.style.height);//将对象的高度转化为数字
   if (popH==0){
   MsgPop.style.display="block";//显示隐藏的窗口
  show=setInterval("changeH('up')",2);
   }
  else { 
   hide=setInterval("changeH('down')",2);
  }
}
function changeH(str) {
 var MsgPop=document.getElementById("winpop");
 var popH=parseInt(MsgPop.style.height);
 if(str=="up"){
  if (popH<=300){
  MsgPop.style.height=(popH+4).toString()+"px";
  }
  else{  
  clearInterval(show);
  }
 }
 if(str=="down"){ 
  if (popH>=4){  
  MsgPop.style.height=(popH-4).toString()+"px";
  }
  else{ 
  clearInterval(hide);   
  MsgPop.style.display="none";  //隐藏DIV
  }
 }
}
window.onload=function(){//加载
document.getElementById('winpop').style.height='0px';
setTimeout("tips_pop()",800);//3秒后调用tips_pop()这个函数
}
<%}%>
</script>
</head>
<body>
<jsp:include page="top.jsp" />
<div class="weizhik">&nbsp;</div>
<div class="banner">
  <ul>
    <li class="show" id="topNav1" onclick="setTopNavStyle('1')"><a href="/manage/memberhome.jsp" target="main"  id="topNavTxt1">首页</a></li>
    <li id="topNav2" onclick="setTopNavStyle('2')"><a href="/other/user_info_opt.jsp" target="main" class="write" id="topNavTxt2">会员资料</a></li>
	<li id="topNav5" onclick="setTopNavStyle('5')"><a href="/other/user_passw_opt.jsp" target="main" class="write" id="topNavTxt5">密码修改</a></li>
	<li id="topNav3" onclick="setTopNavStyle('3')"><a href="/other/message_recipients_list.jsp" target="main" class="write" id="topNavTxt3">询价留言</a></li>
    <li id="topNav9" onclick="setTopNavStyle('9')"><a href="/exit.jsp" class="write">退出登陆</a></li>
  </ul>
  
</div>
<div class="banner1">
  <!---->
</div>
<div class="top1">
  <div class="loginok_left">
    <div id="container">

        <%
int i=0;	
int j=0;
String num="";	
while(rs.next()){
i=i+1;	
String roleNum = Common.getFormatStr(memberInfo.get("mem_flag"));
String rentIsWebmaster = Common.getFormatStr(memberInfo.get("rent_is_webmaster"));

num = Common.getFormatStr(rs.getString("purview_num"));


%>		
        <div class="title" style="cursor:pointer" onclick="showLeftMenu(<%=i%>);"><%=Common.getFormatStr(rs.getString("purview_name"))%></div>
		<div class="content" id="menu_<%=i%>" <%=i==1?"":"style='display:none'"%>>
		<ul>		
<%
//String sql2 = "select * from member_purview where len(purview_num)>4 and purview_num like '"+num+"%'  ";
String sql2 = "select p.* from member_purview p,member_role_purview r where len(p.purview_num)>4 and p.purview_num like '"+num+"%' and p.purview_num=r.purview_num and r.role_num='"+((String)memberInfo.get("mem_flag"))+"'  ";
rs2 = DataManager.executeQuery(conn,sql2);
	while(rs2.next()){
	j++;	

%>		
<li class="ban01" id="m<%=j%>" onclick="setBackColor('<%=j%>');" ><a href="<%=Common.getFormatStr(rs2.getString("purview_url"))%>" target="main"><%=Common.getFormatStr(rs2.getString("purview_name"))%></a></li>
<%
	}
%>
		</ul>
		</div>	
<%	
}
%>	 
 
  <div class="title" style="cursor:pointer" onclick="showLeftMenu(10);">商务管理专区</div>
		<div class="content" id="menu_10"  style="display:none">
		<ul>		
		
        <li class="ban01" id="m6" onclick="setBackColor('30');" ><a href="http://www.21part.com" target="_blank">杰配网</a> <%if(Common.getFormatStr(memberInfo.get("flag_21part")).equals("1")){%>(已开通<%}else{%>(<a href="http://www.21part.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要加入杰配网吗？')){return false;} "><font color="#FF0000">未开通</font></a>)
            <%}%>
		</li>
		
        <li class="ban01" id="m7" onclick="setBackColor('31');" > <a href="http://www.21-cmjob.com" target="_blank">人才网</a><%if(Common.getFormatStr(memberInfo.get("flag_job")).equals("1")){%>(已开通)<%}else{%>(<a href="http://www.21-cmjob.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要加入人才网吗？')){return false;} "><font color="#FF0000">未开通</font></a>)<%}%></li>
 
		</ul>
		</div>	

  <div class="title" style="cursor:pointer" onclick="showLeftMenu(11);">我的铁臂空间</div>
		<div class="content" id="menu_11"  style="display:none">
		<ul>
		 <li class="ban01" id="m7" onclick="setBackColor('36');" >		
		<a href="http://bbs.21-sun.com" target="_blank">铁臂论坛</a><%if(Common.getFormatStr(memberInfo.get("flag_bbs")).equals("1")){%>(已开通)<%}else{%>(<a href="http://bbs.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂论坛吗？')){return false;} "><font color="#FF0000">未开通</font></a>)<%}%>
		</li>
        <li class="ban01" id="m7" onclick="setBackColor('33');" ><a href="http://blog.21-sun.com"  target="_blank">铁臂博客</a> <%if(Common.getFormatStr(memberInfo.get("flag_blog")).equals("1")){%>(已开通)<%}else{%>(<a href="http://blog.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂博客吗？')){return false;} "><font color="#FF0000">未开通</font></a>)<%}%></a></li>
		
        <li class="ban01" id="m8" onclick="setBackColor('34');" ><a href="http://space.21-sun.com"  target="_blank">铁臂社区</a><%if(Common.getFormatStr(memberInfo.get("flag_space")).equals("1")){%>(已开通)<%}else{%>(<a href="http://space.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂社区吗？')){return false;} "><font color="#FF0000">未开通</font></a>)<%}%></li>
		
        <li class="ban01" id="m9" onclick="setBackColor('35');" ><a href="http://space.21-sun.com"  target="_blank">铁臂工地</a><%if(Common.getFormatStr(memberInfo.get("flag_space")).equals("1")){%>(已开通)<%}else{%>(<a href="http://space.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂工地吗？')){return false;} "><font color="#FF0000">未开通</font></a>)<%}%></li>
 
		</ul>
		</div>


    </div>
    <div class="loginok_left3" style=" padding-top:25px"><img src="/images/hottel1.jpg" width="133" height="54" />
	</div>
    <div class="loginok_left3"><a href="mailto:market@21-sun.com"><img src="/images/tel.gif" border="0" /></a></div>
  </div>
  <div class="loginlist_right">
    <iframe id="iframeRight" name="main" onload="Javascript:SetCwinHeight()" scrolling="no" frameborder="0" width="100%" height="400" src="<%=iframeFilename%>" ></iframe>
  </div>
</div>
<jsp:include page="foot.jsp" />

<div id="winpop">
 <div class="loginok_center3_1-0" style="width:350px">
    <div class="loginok_center3_1-1"><span class="red14"><!--山东--></span><span class="bigblueb">最新行业信息速递</span></div>
    <div class="loginok_center3_1-2" onclick="tips_pop()" style="cursor:pointer">关闭</div>
  </div>
    <div class="con">
	<iframe id="foots" name="foots"  scrolling="no" frameborder="0" width="380" height="350" src="openwin.jsp" ></iframe>
	</div>
</div>	
<script>
setBackColor('<%=addflag%>');
</script>
</body>
</html><%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	pool.freeConnection(conn2);
}
%>
