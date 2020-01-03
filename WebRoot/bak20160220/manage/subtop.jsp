<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"	%><%@ include file ="/manage/config.jsp"%>
<%
	if(pool==null){
		pool = new PoolManager();
	}	
	HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");	
	String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag"));
	String mem_no   = Common.getFormatStr(memberInfo.get("mem_no"));
	
	String addflag=Common.getFormatInt(request.getParameter("addflag"));
	
	//====根据addflag取出site_flag和css_num值====
	String[][] tempSiteInfo = DataManager.fetchFieldValue(pool,"member_purview_new","site_flag,css_num","flag=1 and add_flag='"+addflag+"'");
		
	//String siteFlag = Common.getFormatStr(request.getParameter("site_flag"));
	String siteFlag="19";
	String controlCssNum="0";
	if(tempSiteInfo!=null&&tempSiteInfo[0][0]!=null)
	{siteFlag=Common.getFormatStr(tempSiteInfo[0][0]);
	controlCssNum=Common.getFormatInt(tempSiteInfo[0][1]);
	}
	String bannerStr="";
	if(siteFlag.equals("19")){
		bannerStr ="商贸网供求";
	}else if(siteFlag.equals("22")){
		bannerStr ="我的二手";
	}else if(siteFlag.equals("23")){
		bannerStr ="配件网空间站";
	}else if(siteFlag.equals("24")){
		bannerStr ="我的租赁";
	}else if(siteFlag.equals("27")){
		bannerStr ="配套网空间站";
	}
			
	String[][] tempMemberPurview = DataManager.fetchFieldValue(pool,"member_purview_new","purview_num,purview_name,css_num,site_flag,add_flag,purview_img","flag=1 and len(purview_num)=4 order by orderby asc");
	
	String[][] tempSubMemberPurview = null; //查询子栏目	
	String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
	keyPar = Common.encryptionByDES(keyPar);
		
		
	String[][] tempCombolJob  = null;         //查询人才网的类型		
    String[][] tempMemberFlagPurview = null;  //用户权限可以操作的栏目
	
	List<String> alMemberFlagPurview = new ArrayList<String>();  //存放此权限的所能操作栏目的LIST
	tempMemberFlagPurview = DataManager.fetchFieldValue(pool,"member_role_purview_new","purview_num","role_num='"+mem_flag+"'");
	if(tempMemberFlagPurview!=null){
	  for(int i=0;i<tempMemberFlagPurview.length;i++){
	     alMemberFlagPurview.add(Common.getFormatStr(tempMemberFlagPurview[i][0]));
	  }
	}
   
   String tempMemberInfo[][] =DataManager.fetchFieldValue(pool,"vi_member_info","flag_job,flag_21part","mem_no='"+mem_no+"'");
   String flag_job    ="";//判断是否已经开通人才网
   String flag_21part ="";//判断是否已经开通杰配网
   if(tempMemberInfo!=null){
      flag_job    = Common.getFormatInt(tempMemberInfo[0][0]);
	  flag_21part = Common.getFormatInt(tempMemberInfo[0][1]);
   }
  %>
<script type="text/javascript">
//name,url,width 850,heigth 680
function openDivWin(name,url,width,heigth){
 var w =width; 
 var h =heigth; 
 lhgdialog.opendlg(name,url, w, h, true, true,'windiv'); 
}
function tabImg(img_src,img_title)
{var imgObj=document.getElementById("mainImg");
 var charObj=document.getElementById("imgTitle");
	if(imgObj){imgObj.src="images/"+img_src;}
	if(charObj){charObj.innerHTML=img_title;}
 }
function changeClass(n){  //选中当前的导航条，将其它的设置成不选中
	$("#v"+n).addClass("v"+n+"hover");
	$("#v"+n).attr("style","color:#356794");	
	$("#nav li span a").each(function(i){
	     if(i!=n){		    
		   $("#v"+i).removeClass("v"+i+"hover");
		   $("#v"+i).attr("style","color:#ffffff");
		 }
	}); 

 }
</script>
<script type="text/javascript" src="/scripts/divopenwin/lhgdialog.js"></script>
<SCRIPT type="text/javascript" src="jquery.js"></SCRIPT>
<style type="text/css">
#winpop { width:380px; height:0px; position:absolute; right:0; bottom:0; border:0px solid #666; margin:0; padding:1px; overflow:hidden; display:none; padding-right:50px}
#winpop .title { width:100%; height:22px; line-height:20px; background:#d1d1d1; font-weight:bold; text-align:center; font-size:12px;}
#winpop .con { width:100%; height:350px; line-height:80px; font-weight:bold; font-size:12px; color:#FF0000; text-decoration:underline; text-align:center} 
.close { position:absolute; right:4px; top:-1px; color:#FFF; cursor:pointer}
</style>

<div class="shangwushidh">
<div class="shangwushidhl" style="display:"><a href="memberhome.jsp">会员商务室</a><%=bannerStr.equals("")?"":"&nbsp;&gt;&nbsp;"+bannerStr%></div>
<div class="shangwushidhr"><a href="memberinfo_new.jsp">系统设置</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="../exit.jsp">退出登录</a></div></div>
  
<div id="nav_wrap">
<div id="nav">
<ul class="c">     
<li style="width:1px"></li>
<!--一级栏目-->
	  <% 
	   String tempPurviewNum ="",tempPurviewName="",tempCssNum="",tempSiteFlag="",tempAddFlag="",tempPurviewImg="";  // 栏目编号、栏目名称、CSS编号、类别编号、图片
	   String tempSubPurviewName="",tempSubAddFlag="";
	   String helpPage=""; 
	   String tempPurviewSearch="";
		if(tempMemberPurview!=null){
		   for(int i=0;i<tempMemberPurview.length;i++){
		   
		    tempPurviewNum  = Common.getFormatStr(tempMemberPurview[i][0]);  //栏目编号
			tempPurviewName = Common.getFormatStr(tempMemberPurview[i][1]);  //栏目名称
			tempCssNum      = Common.getFormatStr(tempMemberPurview[i][2]);  //样式编号
			tempSiteFlag    = Common.getFormatStr(tempMemberPurview[i][3]);  //站点编号
			tempAddFlag     = Common.getFormatStr(tempMemberPurview[i][4]);	 //菜单类别编号
			tempPurviewImg	= Common.getFormatStr(tempMemberPurview[i][5]);  //类别图片
			tempSubMemberPurview=null;
			
			//查询出帮助页
			if(tempSiteFlag.equals("22")){
				helpPage ="usedhelp.jsp";
			}else if(tempSiteFlag.equals("23")){
				helpPage ="partshelp.jsp";
			}else if(tempSiteFlag.equals("24")){
				helpPage ="renthelp.jsp";
			}else if(tempSiteFlag.equals("27")){
				helpPage ="fittingshelp.jsp";
			}
			//=====租赁站点判断条件===
 tempPurviewSearch="and purview_num like '"+tempPurviewNum+"%' ";
if(tempPurviewNum.equals("6003")||tempPurviewNum.equals("6008"))
tempPurviewSearch="and (purview_num like '6003%' or purview_num like '6008%') ";
//==================
		   tempSubMemberPurview = DataManager.fetchFieldValue(pool,"member_purview_new","add_flag,purview_name","flag =1  and site_flag='"+tempSiteFlag+"'  and len(purview_num)>4 "+tempPurviewSearch+" and banner_show=1 order by orderby asc");
	%>
		 <li><span class="v<%=tempCssNum%>">
		  <%
			if(tempSiteFlag.equals("14")){       //判断是否为 人才网
			    if(flag_job.equals("1")){        //已开通人才网
			        tempCombolJob = DataManager.fetchFieldValue(pool,"cmbol_member","type","uid='"+mem_no+"'");//查询人才网类型
					if(tempCombolJob!=null){
						if(Common.getFormatInt(tempCombolJob[0][0]).equals("2")){%><!--判断是个人还是公司  2 为公司-->
						  <a href="http://www.21-cmjob.com" target="_blank" id="v<%=tempCssNum%>" onmouseover="changeClass('<%=tempCssNum%>');"><%=tempPurviewName%></a>
						<%}else{%>
					     <a href="http://www.21-cmjob.com" target="_blank" id="v<%=tempCssNum%>" onmouseover="changeClass('<%=tempCssNum%>');"><%=tempPurviewName%></a>
						<%}
					}					   
			     }else{ //未开通人才网
			%>
					<a href="javascript:openDivWin('','/comjob/member_start.jsp?key=<%=keyPar%>',400,200)"id="v<%=tempCssNum%>" onmouseover="changeClass('<%=tempCssNum%>');"><%=tempPurviewName%></a>
			<%	  }			
			}else if(tempSiteFlag.equals("13")){  //是否为杰配网
					if(flag_21part.equals("1")){//已开通杰配网
				%>
				  <a href="http://www.21part.com" target="_blank" id="v<%=tempCssNum%>" onmouseover="changeClass('<%=tempCssNum%>');"><%=tempPurviewName%></a>
				<%	
					}else{//未开通杰配网
				%>
				  <a href="javascript:openDivWin('','/21part/member_start.jsp?key=<%=keyPar%>',400,200)" id="v<%=tempCssNum%>" onmouseover="changeClass('<%=tempCssNum%>');"><%=tempPurviewName%></a>
		   <%   }
			  }else{
		   %>
				<a href="membermain.jsp?addflag=<%=tempAddFlag%>" id="v<%=tempCssNum%>" onmouseover="changeClass('<%=tempCssNum%>');"><%=tempPurviewName%></a>
				
			 <%
			   }			
			%>
			</span>
			<!--一级栏目结束-->		
          <%//===子栏目===
			   if(tempSubMemberPurview!=null){
	      %>
		    	<div class="kind_menu" id="kind_menu<%=tempCssNum%>">
		  <%
			     for(int j=0;j<tempSubMemberPurview.length;j++){				   
					tempSubAddFlag       = Common.getFormatStr(tempSubMemberPurview[j][0]);	
					tempSubPurviewName	 = Common.getFormatStr(tempSubMemberPurview[j][1]);					
		  %>    <a href="membermain.jsp?addflag=<%=tempSubAddFlag%>"><%=tempSubPurviewName%></a>
		   <%if(j<(tempSubMemberPurview.length-1)){%><span></span><%}%>
		  <%}%>
		 	     </div>
		 <%
		    }
		 %> 
        </li>		
	<% 
	    }
	  }
	%>
     </ul>
    </div>
</div>
<SCRIPT type="text/javascript" src="menu.js"></SCRIPT>
<script>
	$("#v<%=controlCssNum%>").addClass("v<%=controlCssNum%>hover");
	$("#v<%=controlCssNum%>").attr("style","color:#356794");
	$("#kind_menu<%=controlCssNum%>").show();
	</script>
