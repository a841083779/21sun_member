<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@ include file ="/manage/config.jsp"%>
<%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
ResultSet rs = null;

ResultSet rs2 = null; 

HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);

String addflag = Common.getFormatStr(request.getParameter("addflag"));
String iframeFilename = "memberhome.jsp";
if(addflag.equals("1")){	
	iframeFilename = "/market/market_opt.jsp";//市场供求
}else if(addflag.equals("2")){
	iframeFilename = "/parts/supply_opt.jsp";//配件供应
}else if(addflag.equals("3")){
	iframeFilename = "/parts/parts_store_opt.jsp";//配件仓库管理
}else if(addflag.equals("4")){
	iframeFilename = "/rent/rent_opt.jsp";//租赁供求
}else if(addflag.equals("5")){
	iframeFilename = "/usedmarket/buy_opt.jsp";//二手求购
}else  if(addflag.equals("6")){
	iframeFilename = "/usedmarket/sell_opt.jsp";//二手出售
}else  if(addflag.equals("7")){
	iframeFilename = "/market/market_list.jsp";//管理我的供求
}else  if(addflag.equals("8")){
	iframeFilename = "/parts/buy_opt.jsp";//配件求购
}else  if(addflag.equals("9")){
	iframeFilename = "/parts/collect_parts_list.jsp";//管理配件收藏
}
else  if(addflag.equals("10")){
	iframeFilename = "/parts/subscribe_supply_list.jsp";//管理配件订阅
}

String [][]tempMemberInfo = DataManager.fetchFieldValue(pool,"member_info","flag_job,flag_21part,flag_bbs,flag_space,flag_blog","state=1 and mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' ");
//System.out.println("===="+memberInfo);
try{
//String sql = "select * from member_purview where len(purview_num)=4  ";
String sql = "select p.* from member_purview p,member_role_purview r where len(p.purview_num)=4 and p.flag=1 and p.purview_num=r.purview_num and r.role_num='"+ Common.getFormatStr(memberInfo.get("mem_flag"))+"'  ";
//System.out.println("sql:====="+sql);
conn = pool.getConnection();
rs=DataManager.executeQuery(conn,sql);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>我的商贸网 - 中国工程机械商贸网</title>
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script src="/scripts/common.js"  type="text/javascript"></script>
<script type="text/javascript" src="/scripts/divopenwin/lhgdialog.js"></script>
<link href="/style/menu.css" rel="stylesheet" type="text/css" />
<script src="/scripts/prototype.lite.js" type="text/javascript"></script>
<script src="/scripts/moo.fx.js" type="text/javascript"></script>
<script src="/scripts/moo.fx.pack.js" type="text/javascript"></script>
<style type="text/css">
#winpop { width:380px; height:0px; position:absolute; right:0; bottom:0; border:0px solid #666; margin:0; padding:1px; overflow:hidden; display:none; padding-right:50px}
#winpop .title { width:100%; height:22px; line-height:20px; background:#d1d1d1; font-weight:bold; text-align:center; font-size:12px;}
#winpop .con { width:100%; height:350px; line-height:80px; font-weight:bold; font-size:12px; color:#FF0000; text-decoration:underline; text-align:center} 
.close { position:absolute; right:4px; top:-1px; color:#FFF; cursor:pointer}
</style>
<script language="javascript">
function SetCwinHeight(){
  var right=document.getElementById("iframeright"); //iframe id
  if (document.getElementById){
   if (right && !window.opera){
    if (right.contentDocument && right.contentDocument.body.offsetHeight){
     if(right.contentDocument.body.offsetHeight<100)
	 right.height =right.contentDocument.body.offsetHeight+100;
	 else
	 right.height =right.contentDocument.body.offsetHeight;
    }else if(right.Document && right.Document.body.scrollHeight){
	　if(right.Document.body.scrollHeight<100)
     right.height = right.Document.body.scrollHeight+100;
	 else
	 right.height = right.Document.body.scrollHeight;
	 
    }
   }
  }
 }
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
</script>
</head>
<body>
<jsp:include page="top.jsp" />
<div class="weizhik">&nbsp;</div>
<div class="banner">
  <ul>
    <li class="show" id="topNav1" onclick="setTopNavStyle('1')"><a href="/manage/memberhome.jsp" target="iframeright"  id="topNavTxt1">首页</a></li>
    <li id="topNav2" onclick="setTopNavStyle('2')"><a href="/other/user_info_opt.jsp" target="iframeright" class="write" id="topNavTxt2">会员资料</a></li>
    <li id="topNav5" onclick="setTopNavStyle('5')"><a href="/other/user_passw_opt.jsp" target="iframeright" class="write" id="topNavTxt5">密码修改</a></li>
    <li id="topNav3" onclick="setTopNavStyle('3')"><a href="/other/message_recipients_list.jsp" target="iframeright" class="write" id="topNavTxt3">留言</a></li>
    <li id="topNav9" onclick="setTopNavStyle('9')"><a href="/exit.jsp" class="write">退出登陆</a></li>
  </ul>
</div>
<div class="banner1"> </div>
<div class="top1">
  <div class="loginok_left" style="height:auto;overflow:hidden">
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
      <div class="title" style="cursor:pointer" ><%=Common.getFormatStr(rs.getString("purview_name"))%></div>
      <div class="content" >
        <ul>
          <%
//String sql2 = "select * from member_purview where len(purview_num)>4 and purview_num like '"+num+"%'  ";
String sql2 = "select p.* from member_purview p,member_role_purview r where len(p.purview_num)>4  and p.flag=1 and p.purview_num like '"+num+"%' and p.purview_num=r.purview_num and r.role_num='"+roleNum+"'  order by p.purview_num ";
//System.out.println("sql2:====="+sql2);
rs2 = DataManager.executeQuery(conn,sql2);
	while(rs2.next()){
	j++;
%>
          <li class="ban01" id="m<%=j%>" onclick="setBackColor('<%=j%>');" ><a href="<%=Common.getFormatStr(rs2.getString("purview_url"))%>" target="iframeright"><%=Common.getFormatStr(rs2.getString("purview_name"))%></a></li>
          <%
	}
%>
        </ul>
      </div>
      <%	
}
%>
      <div class="title" style="cursor:pointer" >商务管理专区</div>
      <div class="content" >
        <ul>
          <li class="ban01" id="m6" onclick="setBackColor('30');" ><a href="http://www.21part.com" target="_blank">杰配网</a>
            <%if(tempMemberInfo!=null&&tempMemberInfo[0][1]!=null&&Common.getFormatStr(tempMemberInfo[0][1]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="javascript:openDivWin('','/21part/member_start.jsp?key=<%=keyPar%>',400,200)"class="hong"><font color="#FF0000">未开通</font></a>)
            <%}%>
          </li>
          <li class="ban01" id="m7" onclick="setBackColor('31');" > <a href="http://www.21-cmjob.com" target="_blank">人才网</a>
            <%if(tempMemberInfo!=null&&tempMemberInfo[0][0]!=null&&Common.getFormatStr(tempMemberInfo[0][0]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="javascript:openDivWin('','/comjob/member_start.jsp?key=<%=keyPar%>',400,200)"  class="hong"><font color="#FF0000">未开通</font></a>)
            <%}%>
          </li>
        </ul>
      </div>
      <div class="title" style="cursor:pointer" >我的铁臂空间</div>
      <div class="content" >
        <ul>
          <li class="ban01" id="m7" onclick="setBackColor('36');" > <a href="http://bbs.21-sun.com" target="_blank">铁臂论坛</a>
            <%if(tempMemberInfo!=null&&tempMemberInfo[0][2]!=null&&Common.getFormatStr(tempMemberInfo[0][2]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://bbs.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂论坛吗？')){return false;} "><font color="#FF0000">未开通</font></a>)
            <%}%>
          </li>
          <li class="ban01" id="m7" onclick="setBackColor('33');" ><a href="http://blog.21-sun.com"  target="_blank">铁臂博客</a>
            <%if(tempMemberInfo!=null&&tempMemberInfo[0][4]!=null&&Common.getFormatStr(tempMemberInfo[0][4]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://blog.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂博客吗？')){return false;} "><font color="#FF0000">未开通</font></a>)
            <%}%>
            </a></li>
          <li class="ban01" id="m8" onclick="setBackColor('34');" ><a href="http://space.21-sun.com"  target="_blank">铁臂社区</a>
            <%if(tempMemberInfo!=null&&tempMemberInfo[0][3]!=null&&Common.getFormatStr(tempMemberInfo[0][3]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://space.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂社区吗？')){return false;} "><font color="#FF0000">未开通</font></a>)
            <%}%>
          </li>
        </ul>
      </div>
    </div>
    <div class="loginok_left3" style=" padding-top:25px"><img src="/images/hottel1.jpg" width="133" height="54" /> </div>
    <div class="loginok_left3"><a href="mailto:market@21-sun.com"><img src="/images/tel.gif" border="0" /></a></div>
  </div>
  <div class="loginlist_right" style="height:auto;overflow:hidden">
    <iframe id="iframeright" name="iframeright" onload='javascript:SetCwinHeight();' scrolling="no" frameborder="0" width="100%" height="490" src="<%=iframeFilename%>" ></iframe>
	 <!--<iframe id="iframeReg" name="iframeReg" scrolling="no" frameborder="0" width="100%" height="490" src="" ></iframe>-->
  </div>
</div>
<jsp:include page="foot.jsp" />
<script type="text/javascript">
		var contents = document.getElementsByClassName('content');
		var toggles = document.getElementsByClassName('title');
	
		var myAccordion = new fx.Accordion(
			toggles, contents, {opacity: true, duration: 400}
		);
		myAccordion.showThisHideOpen(contents[0]);
	</script>
<div id="winpop">
  <div class="loginok_center3_1-0" style="width:350px">
    <div class="loginok_center3_1-1"><span class="red14">
      <!--山东-->
      </span><span class="bigblueb">最新行业信息速递</span></div>
    <div class="loginok_center3_1-2" onclick="tips_pop()" style="cursor:pointer">关闭</div>
  </div>
  <div class="con">
    <iframe id="foots" name="foots"  scrolling="no" frameborder="0" width="380" height="350" src="openwin.jsp" ></iframe>
  </div>
</div>
</body>
</html>
<%
}catch(Exception e){e.printStackTrace();}
finally{
	pool.freeConnection(conn);
	
}
%>