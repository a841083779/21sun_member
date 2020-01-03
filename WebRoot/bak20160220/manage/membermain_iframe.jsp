<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%>
<%
	if(pool==null){
		pool = new PoolManager();
	}
	HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
	
	PoolManager pool4= new PoolManager(4);
	PoolManager pool3= new PoolManager(3);
	PoolManager pool5= new PoolManager(5);
	PoolManager pool7= new PoolManager(7);
	PoolManager pool9= new PoolManager(9);
	
	String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);
	
   String [][]tempMemberInfo = DataManager.fetchFieldValue(pool,"member_info","flag_job,flag_21part,flag_bbs,flag_space,flag_blog,mem_name,mem_flag_name,convert(varchar(10),mem_flag_enddate,21),convert(varchar(19),login_last_date,21),login_last_ip"," mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and state=1 ");
	
	String messRent="0",messUsed="0",messParts="0",messFittings="0";//留言信息 租赁、二手、配件、供求、配套
	String mess2Market="0",mess2Used="0";//询价信息  供求、二手 
	    
	String [][]mess = DataManager.fetchFieldValue(pool,"member_message","sum(case when site_flag ='1' then 1 else 0  end),sum(case when site_flag ='2' then 1 else 0  end),sum(case when site_flag ='4' then 1 else 0  end),sum(case when site_flag ='7' then 1 else 0  end),sum(case when site_flag ='2' and sort_flag=2 then 1 else 0  end),sum(case when site_flag ='5' and sort_flag=2 then 1 else 0  end)"," recipients_mem_no='"+Common.getFormatStr(memberInfo.get("mem_no"))+"'"); //留言信息 租赁、二手、配件、供求、配套
	if(mess!=null){
	   messRent = Common.getFormatInt(mess[0][0]);
	   messUsed =Common.getFormatInt(mess[0][1]);
	   messParts =Common.getFormatInt(mess[0][2]);
	   messFittings =Common.getFormatInt(mess[0][3]);
   	   mess2Used =Common.getFormatInt(mess[0][4]);
   	   mess2Market =Common.getFormatInt(mess[0][5]);
	}

   String[][] usedInfoBuy = null,usedInfoSell=null,partsInfoBuy=null,partsInfoSell=null,marketInfoBuy=null,rentInfo=null,fittingsInfo=null,fittingsProductsInfo=null;
   
   String purview_name    = Common.getFormatStr(request.getParameter("purview_name"));  
  
   if(!purview_name.equals("")){
       purview_name = Common.decryptionByDES(purview_name); //解密
   }
   int marketCount=0;//发布的供求数
   String sift_flag  = Common.getFormatStr(request.getParameter("site_flag"));
   if(sift_flag.equals("19")){ //供求
	   marketInfoBuy = DataManager.fetchFieldValue(pool5,"sell_buy_market","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_show=1 ");
	   if(marketInfoBuy!=null){marketCount =  Integer.parseInt(Common.getFormatInt(marketInfoBuy[0][0]));}	   
   }
   
   int usedBuyCount=0,usedSellCount=0;  //二手求购、出售的数量
   if(sift_flag.equals("22")){  //二手
	   usedInfoBuy  = DataManager.fetchFieldValue(pool4,"buy","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1 ");
	   if(usedInfoBuy!=null){usedBuyCount = Integer.parseInt(Common.getFormatInt(usedInfoBuy[0][0]));} //求购
	   
	   usedInfoSell = DataManager.fetchFieldValue(pool4,"sell","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1 ");
	   if(usedInfoSell!=null){usedSellCount = Integer.parseInt(Common.getFormatInt(usedInfoSell[0][0]));}//出售
   }
   
   int partsBuyCount=0,partsSellCount=0; //配件求购、出售的数量
   if(sift_flag.equals("23")){ //配件
	   partsInfoBuy = DataManager.fetchFieldValue(pool7,"buy","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1 ");
	   if(partsInfoBuy!=null){partsBuyCount = Integer.parseInt(Common.getFormatInt(partsInfoBuy[0][0]));}
	   
	   partsInfoSell = DataManager.fetchFieldValue(pool7,"supply","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1 ");
	   if(partsInfoSell!=null){partsSellCount = Integer.parseInt(Common.getFormatInt(partsInfoSell[0][0]));}
   }
   
   int rentBuyCount=0,rentSellCount=0;//求租、出租 租赁数量
   if(sift_flag.equals("24")){ //租赁
		 rentInfo = DataManager.fetchFieldValue(pool3,"rent_info","sum(case when class ='0' then 1 else 0  end),sum(case when class ='1' then 1 else 0  end)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_pub=1 ");
		 if(rentInfo!=null){rentBuyCount = Integer.parseInt(Common.getFormatInt(rentInfo[0][0]));}
   }
   
   int fittingsCoopCount=0,fittingsBussCount=0,fittingsBuyCount=0,fittingsSupplyCount=0,fittingsProdCount=0; //配套数量
  
   if(sift_flag.equals("27")){ //配套网  1:配套合作;2:代理招商;3:求购信息;4:供应信
	  	fittingsInfo = DataManager.fetchFieldValue(pool9,"fittings_business_info","sum(case when flag ='1' then 1 else 0  end),sum(case when flag ='2' then 1 else 0  end),sum(case when flag ='3' then 1 else 0  end),sum(case when flag ='4' then 1 else 0  end)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_show=1 ");
		if(fittingsInfo!=null){
		   fittingsCoopCount = Integer.parseInt(Common.getFormatInt(fittingsInfo[0][0]));
		   fittingsBussCount = Integer.parseInt(Common.getFormatInt(fittingsInfo[0][1]));
		   fittingsBuyCount  = Integer.parseInt(Common.getFormatInt(fittingsInfo[0][2]));
		   fittingsSupplyCount = Integer.parseInt(Common.getFormatInt(fittingsInfo[0][3]));
		}
	    
		fittingsProductsInfo = DataManager.fetchFieldValue(pool9,"fittings_products","count(*)"," mem_no ='"+Common.getFormatStr(memberInfo.get("mem_no"))+"' and is_show=1 ");
	    if(fittingsProductsInfo!=null){
	      fittingsProdCount = Integer.parseInt(Common.getFormatInt(fittingsProductsInfo[0][0]));
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
<span class="swsinformation" style="width:400px"><a style="color:#3f4244;font-size:16px;font-family:微软雅黑"><%=Common.getFormatStr(memberInfo.get("mem_name"))%></a></span>
<div class="loginok_center" style="width:545px;float:left;margin-right:0px">
  <div class="loginok_center1" style="width:522px;border:1px #e4eef8 solid">
   <!--<div class="swszwpic"><img src="../images/zwpic.gif" /></div>-->
   <div class="swsinformation" style="width:400px"><font style="color:#3778ba;font-family:微软雅黑;font-size:19px">您好！<%=Common.getFormatStr(memberInfo.get("mem_no"))%></font> <a style="color:#3f4244;font-size:16px;font-family:微软雅黑">[]</a><b style="font-size:14px;color:#ff8900;">　欢迎来到“<%=purview_name%>”</b><br />
   <a style="color:#989796">会员类型：</a><b style="font-size:14px;color:#fc7f04"><%=tempMemberInfo!=null&&tempMemberInfo[0][6]!=null?Common.getFormatStr(tempMemberInfo[0][6]):"-"%></b><br />
   <a style="color:#989796"> 到期时间：</a><a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][7]!=null?Common.getFormatStr(tempMemberInfo[0][7]):"-"%></a><br />
    <a style="color:#989796">上次登陆：</a><a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][8]!=null?Common.getFormatStr(tempMemberInfo[0][8]):"-"%></a>   <a style="color:#989796">在</a>  <a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][9]!=null?Common.getFormatStr(tempMemberInfo[0][9]):"-"%></a></b>  <a style="color:#989796">登录</a></div>
    <img src="dlhbaobao1.jpg" width="70" height="82" style="float:right:margin-right:10px;"/>  </div>
  <div class="loginok_center3" style="width:543px">
    <div class="loginok_center3_1"><span class="bigblueb">信息提醒</span></div>
    <div class="loginok_center3_2"> 
	 
   <%if(sift_flag.equals("19")){%>
	<a style="color:#000">商贸网供求：</a>您共发布了<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=7" target="_parent"><b><%=marketCount%></b></a>条供求信息，<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=27" target="_parent"><b><%=mess2Market%></b></a>条询价&nbsp;&nbsp;&nbsp;&nbsp; <br /><%if(marketCount<5){%>您发布的信息量过少，为获得更多商机，建议您增加信息发布量！<%}%><a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=1" target="_parent">发布供求信息</a><br /><%}%>
	
<%if(sift_flag.equals("22")){%>
<a style="color:#000">我的二手：</a>您共发布了<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=5" target="_parent"><b><%=usedBuyCount%></b></a>条求购信息,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=31" target="_parent"><b><%=usedSellCount%></b></a>条出售信息,收到<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=35" target="_parent"><b><%=messUsed%></b></a>条留言，<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=30" target="_parent"><b><%=mess2Used%></b></a>条询价&nbsp;&nbsp;&nbsp;&nbsp; <br /><%if((usedBuyCount+usedSellCount)<5){%>您发布的信息量过少，为获得更多商机，建议您增加信息发布量！<%}%><a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=5" target="_parent">发布求购信息</a>&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=6" target="_parent">发布出售信息</a><br /><%}%>
 
 <%if(sift_flag.equals("24")){%>
<a style="color:#000">我的租赁：</a>您共发布了<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=37" target="_parent"><b><%=rentBuyCount%></b></a>条求租信息,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=37" target="_parent"><b><%=rentSellCount%></b></a>条出租信息,收到<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=38" target="_parent"><b><%=messRent%></b></a>条留言&nbsp;&nbsp;&nbsp; <br /><%if((rentBuyCount+rentSellCount)<5){%>您发布的信息量过少，为获得更多商机，建议您增加信息发布量！<%}%><a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=4" target="_parent">发布租赁信息</a><br /><%}%>

<%if(sift_flag.equals("23")){%>
<a style="color:#000">配件网空间站：</a>您共发布了<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=40" target="_parent"><b><%=partsBuyCount%></b></a>条求购信息,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=41" target="_parent"><b><%=partsSellCount%></b></a>条供应信息,收到<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=43" target="_parent"><b><%=messParts%></b></a>条留言&nbsp;&nbsp;&nbsp;&nbsp; <br /><%if((partsBuyCount+partsSellCount)<5){%>您发布的信息量过少，为获得更多商机，建议您增加信息发布量！<%}%><a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=8" target="_parent">发布配件求购</a>&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=2" target="_parent">发布配件供应</a><br /><%}%>

 <%if(sift_flag.equals("27")){%>
<a style="color:#000">配套网空间站：</a>您共发布了<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=18" target="_parent"><b><%=fittingsCoopCount%></b></a>条配套合作,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=19" target="_parent"><b><%=fittingsBussCount%></b></a>条代理招商,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=22" target="_parent"><b><%=fittingsProdCount%></b></a>条产品,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=21" target="_parent"><b><%=fittingsBuyCount%></b></a>条配套求购,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=20" target="_parent"><b><%=fittingsSupplyCount%></b></a>条配套供应&nbsp;&nbsp;&nbsp; <br />
您发布的信息量过少，为获得更多商机，建议您增加信息发布量！<a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=11" target="_parent">发布配套合作</a>&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=12" target="_parent">发布代理招商</a><%}%>
	
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
            (<a href="http://bbs.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂论坛吗？')){return false;} "><font color="#FF0000">点击开通</font></a>)
            <%}%>
            <br/>
              <span class="data"><a href="http://bbs.21-sun.com" target="_blank">bbs.21-sun.com</a></span></li>
          <li><a href="http://space.21-sun.com" target="_blank"><img src="/images/tbsplogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://space.21-sun.com" target="_blank">铁臂社区</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][3]!=null&&Common.getFormatStr(tempMemberInfo[0][3]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://space.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂社区吗？')){return false;} "><font color="#FF0000">点击开通</font></a>)
            <%}%> <br/>
              <span class="data"><a href="http://space.21-sun.com" target="_blank">space.21-sun.com</a></span></li>
          <li><a href="http://blog.21-sun.com" target="_blank"><img src="/images/smwlogo.gif" class="imgleft" border="0"/></a><span class="main141"><a href="http://blog.21-sun.com" target="_blank">铁臂博客</a></span>
              <%if(tempMemberInfo!=null&&tempMemberInfo[0][4]!=null&&Common.getFormatStr(tempMemberInfo[0][4]).equals("1")){%>
            (已开通)
            <%}else{%>
            (<a href="http://blog.21-sun.com/sso/sso_reg.jsp?key=<%=keyPar%>" target="_blank" class="hong" onclick="if(!confirm('您确认要开通铁臂博客吗？')){return false;} "><font color="#FF0000">点击开通</font></a>)
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
        <li><a target="_blank" href="http://data.21-sun.com" class="blue12">2010-2012年中国液压破碎锤市场发展研究及前景预测</a></li>
		<li><a target="_blank" href="http://data.21-sun.com" class="blue12">
			电子版：9800元/份。<br />电话：0535- 6722555  6727766  6723251</a> </li>
      </ul>
	   <div class="loginok_right_2_2_1"><a href="http://www.21-cmjob.com/" target="_blank"><img src="/images/rencai200.gif" alt="中国工作机械人才网" width="200" height="78"  border="0"/></a></div></div>
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