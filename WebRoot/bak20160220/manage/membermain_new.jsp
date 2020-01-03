<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%><%
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");

if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
ResultSet rs = null;

String tempPurviewNum1     = "";    //编号
String tempSubPurviewNum1  = "";    //子编号
String tempSiteFlag1       = "";    //站点编号
String tempPurviewName1    = "";    //父栏目的名称 
String addflag = Common.getFormatStr(request.getParameter("addflag"));  //栏目的编号
String[][] tempPurviewAddflag = null;

if(!addflag.equals("")){  //
	tempPurviewAddflag= DataManager.fetchFieldValue(pool,"member_purview_new","purview_num,site_flag,purview_name"," add_flag='"+addflag+"' and flag =1 ");	
	if(tempPurviewAddflag!=null){
	    tempPurviewNum1 =  Common.getFormatInt(tempPurviewAddflag[0][0]); //编号
				
		if(tempPurviewNum1.length()>4){//当是子栏目时，需要查询出其对应的父栏目
			tempPurviewNum1 = Common.getFormatInt(tempPurviewAddflag[0][0]).substring(0,4);		
			tempSubPurviewNum1 = Common.getFormatInt(tempPurviewAddflag[0][0]);
		}else{
		    tempPurviewName1 = Common.getFormatStr(tempPurviewAddflag[0][2]);
			if(!tempPurviewName1.equals("")){
			   tempPurviewName1 = Common.encryptionByDES(tempPurviewName1);
			}
		}		
	    tempSiteFlag1 = Common.getFormatInt(tempPurviewAddflag[0][1]);
	}
}
String helpPage="";
if(tempSiteFlag1.equals("22")){
  helpPage ="usedhelp.jsp";
}else if(tempSiteFlag1.equals("23")){
  helpPage ="partshelp.jsp";
}else if(tempSiteFlag1.equals("24")){
  helpPage ="renthelp.jsp";
}else if(tempSiteFlag1.equals("27")){
  helpPage ="fittingshelp.jsp";
}

String[][]  tempSubMemberPurview =null; //查询子栏目

//=====左侧菜单子目录,增加租赁站点判断条件===
String tempPurviewSearch="and purview_num like '"+tempPurviewNum1+"%' ";
if(tempPurviewNum1.equals("6003")||tempPurviewNum1.equals("6008"))
tempPurviewSearch="and (purview_num like '6003%' or purview_num like '6008%') ";

tempSubMemberPurview = DataManager.fetchFieldValue(pool,"member_purview_new","purview_num,purview_name,purview_url,add_flag,site_flag"," site_flag='"+tempSiteFlag1+"'  and flag =1  and len(purview_num)>4 "+tempPurviewSearch+" order by orderby asc");
//======

String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag"));
String iframeFilename = "";  //登录页面

String[][] tempMemberFlagPurview = null;
List<String> alMemberFlagPurview = new ArrayList<String>();  //查询当前用户的权限。

tempMemberFlagPurview = DataManager.fetchFieldValue(pool,"member_role_purview_new","purview_num","role_num='"+mem_flag+"'");
if(tempMemberFlagPurview!=null){
  for(int i=0;i<tempMemberFlagPurview.length;i++){
	 alMemberFlagPurview.add(Common.getFormatStr(tempMemberFlagPurview[i][0]));
  }
}
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
<script type="text/javascript">
function reinitIframe(){
var iframe = document.getElementById("iframeright_1");
try{
	var bHeight = iframe.contentWindow.document.body.scrollHeight;
	var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
	var height = Math.max(bHeight, dHeight);
	iframe.height =  height;
}catch (ex){}
}
window.setInterval("reinitIframe()", 200);
</script>
</head>
<body>
<jsp:include page="top.jsp" />
<jsp:include page="subtop.jsp">
  <jsp:param name="mem_flag" value="<%=mem_flag%>"/>
  <jsp:param name="addflag" value="<%=addflag%>"/>
</jsp:include>

<div class="swscenter">
<div class="swscenterl">
<div class="swsleftmenu">
<div class="swsleftmenutop"><img src="../images/hysws.gif" /></div>
<div class="swsmenulist">
<ul>
<%
    String tempSubPurviewNum ="",tempSubPurviewName="",tempSubpurviewUrl="",tempSubPurviewAddFlag="",tempSubSiteFlag=""; 
	String tempHelpPage="";
	if(tempSubMemberPurview!=null){ //循环左侧栏目
	  for(int i=0;i<tempSubMemberPurview.length;i++){	
	   out.println("<li>");
		tempSubPurviewNum     = Common.getFormatStr(tempSubMemberPurview[i][0]);
		tempSubPurviewName    = Common.getFormatStr(tempSubMemberPurview[i][1]);
		tempSubpurviewUrl     = Common.getFormatStr(tempSubMemberPurview[i][2]);
		tempSubPurviewAddFlag = Common.getFormatStr(tempSubMemberPurview[i][3]);
		tempSubSiteFlag       = Common.getFormatStr(tempSubMemberPurview[i][4]);
		
		if(tempSubPurviewNum1.equals(tempSubPurviewNum)){
		  if(!addflag.equals("") && alMemberFlagPurview!=null &&!alMemberFlagPurview.contains(tempSubPurviewNum)){ 		     
		     iframeFilename= helpPage+"?purviewName="+tempSubPurviewName; //没有权限时，iframe为一个帮助页
		  }else{
		    iframeFilename = tempSubpurviewUrl; //有权限时，链接到对应的页面
		  }		  
		}		
	%>
	  <a href="membermain.jsp?addflag=<%=tempSubPurviewAddFlag%>" <%=tempSubPurviewNum1.equals(tempSubPurviewNum)?"style=\"background:url('../images/hover_bg1.gif');font-size:14px;font-weight:bold;color:#285675\"":""%>><%=tempSubPurviewName%></a>
	<%	 
     }
 }
 
 //====供求市场===
 if(iframeFilename.equals("")&&tempSiteFlag1.equals("19")){
   iframeFilename ="membermain_market_iframe.jsp?site_flag="+tempSiteFlag1+"&purview_name="+tempPurviewName1;
 }
 //====二手====
 else if(iframeFilename.equals("")&&tempSiteFlag1.equals("22")){
   iframeFilename ="membermain_used_iframe.jsp?site_flag="+tempSiteFlag1+"&purview_name="+tempPurviewName1;
 }
  //====租赁====
else if(iframeFilename.equals("")&&tempSiteFlag1.equals("24")){
   iframeFilename ="membermain_rent_iframe.jsp?site_flag="+tempSiteFlag1+"&purview_name="+tempPurviewName1;
 }
  //====配件====
else if(iframeFilename.equals("")&&tempSiteFlag1.equals("23")){
   iframeFilename ="membermain_part_iframe.jsp?site_flag="+tempSiteFlag1+"&purview_name="+tempPurviewName1;
 }
  //====配套====
else if(iframeFilename.equals("")&&tempSiteFlag1.equals("27")){
   iframeFilename ="membermain_fittings_iframe.jsp?site_flag="+tempSiteFlag1+"&purview_name="+tempPurviewName1;
 }

%>
</ul>
</div>
</div>
<div class="swsad"><img src="../images/swsgg.gif" /></div>
</div>
<div class="swscenterr"><iframe id="iframeright_1" name="iframeright_1" scrolling="no" frameborder="0" width="100%" height="490" src="<%=iframeFilename%>" ></iframe></div>
</div>
<jsp:include page="foot.jsp" />
</body>
</html>
