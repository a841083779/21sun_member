<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %><%HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String sessionMemNo=((String)memberInfo.get("mem_no"));
String cacheName = "membermain_fittings"+sessionMemNo;
%>

<%
	if(pool==null){
		pool = new PoolManager();
	}
	
	PoolManager pool9= new PoolManager(9);
	
	String keyPar = sessionMemNo+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);
	
   String [][]tempMemberInfo = DataManager.fetchFieldValue(pool,"member_info","flag_job,flag_21part,flag_bbs,flag_space,flag_blog,mem_name,mem_flag_name,convert(varchar(10),mem_flag_enddate,21),convert(varchar(19),login_last_date,21),login_last_ip"," mem_no='"+sessionMemNo+"' and state=1 ");
	
	String messFittings="0";//配套留言信息 租赁、二手、配件、供求、
	    
	String [][]mess = DataManager.fetchFieldValue(pool,"member_message","count(id)"," recipients_mem_no='"+sessionMemNo+"' and site_flag ='7' and sort_flag=1 "); //配套留言信息
	if(mess!=null){
	   messFittings =Common.getFormatInt(mess[0][0]);
	}

   String[][] fittingsInfo=null,fittingsProductsInfo=null;
   
   String purview_name    = Common.getFormatStr(request.getParameter("purview_name"));  
  
   if(!purview_name.equals("")){
       purview_name = Common.decryptionByDES(purview_name); //解密
   }
  
   String site_flag  = Common.getFormatStr(request.getParameter("site_flag"));
   int fittingsCoopCount=0,fittingsBussCount=0,fittingsBuyCount=0,fittingsSupplyCount=0,fittingsProdCount=0; //配套数量
  
   if(site_flag.equals("27")){//配套网 1:配套合作;2:代理招商;3:求购信息;4:供应信
	  	fittingsInfo = DataManager.fetchFieldValue(pool9,"fittings_business_info","sum(case when flag ='1' then 1 else 0  end),sum(case when flag ='2' then 1 else 0  end),sum(case when flag ='3' then 1 else 0  end),sum(case when flag ='4' then 1 else 0  end)"," mem_no ='"+sessionMemNo+"' and is_show=1 ");
		if(fittingsInfo!=null){
		   fittingsCoopCount = Integer.parseInt(Common.getFormatInt(fittingsInfo[0][0]));
		   fittingsBussCount = Integer.parseInt(Common.getFormatInt(fittingsInfo[0][1]));
		   fittingsBuyCount  = Integer.parseInt(Common.getFormatInt(fittingsInfo[0][2]));
		   fittingsSupplyCount = Integer.parseInt(Common.getFormatInt(fittingsInfo[0][3]));
		}
	    
		fittingsProductsInfo = DataManager.fetchFieldValue(pool9,"fittings_products","count(id)"," mem_no ='"+sessionMemNo+"' and is_show=1 ");
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
  <div class="loginok_center" style="width:545px;float:left;margin-right:0px">
  <div class="loginok_center1" style="width:522px;border:1px #e4eef8 solid">
   <!--<div class="swszwpic"><img src="../images/zwpic.gif" /></div>-->
   <div class="swsinformation" style="width:430px"><font style="color:#3778ba;font-family:微软雅黑;font-size:14px">您好！<%=sessionMemNo%></font> <a style="color:#3f4244;font-size:14px;font-family:微软雅黑">[<%=Common.getFormatStr(memberInfo.get("mem_name"))%>]</a><b style="font-size:14px;color:#ff8900;">　欢迎来到“<%=purview_name%>”</b><br />
    <a style="color:#989796">会员类型：</a><b style="font-size:14px;color:#fc7f04"><%=tempMemberInfo!=null&&tempMemberInfo[0][6]!=null&&!tempMemberInfo[0][6].equals("")?Common.getFormatStr(tempMemberInfo[0][6]):"-"%></b>&nbsp;&nbsp; 
   <a style="color:#989796"> 到期时间：</a><a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][7]!=null&&!tempMemberInfo[0][7].equals("")?Common.getFormatStr(tempMemberInfo[0][7]):"-"%></a><br />
    <a style="color:#989796">上次登陆：</a><a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][8]!=null&&!tempMemberInfo[0][8].equals("")?Common.getFormatStr(tempMemberInfo[0][8]):"-"%></a>   <a style="color:#989796">在</a>  <a style="font-size:14px;color:#000"><%=tempMemberInfo!=null&&tempMemberInfo[0][9]!=null&&!tempMemberInfo[0][9].equals("")?Common.getFormatStr(tempMemberInfo[0][9]):"-"%></a></b>  <a style="color:#989796">登录</a></div>
  </div>

  <div class="loginok_center3" style="width:543px">
    <div class="loginok_center3_1"><span class="bigblueb">信息提醒</span></div>
    <div class="loginok_center3_2"> 
 <%if(site_flag.equals("27")){%>
<a style="color:#000">配套网空间站：</a>您共发布了<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=18" target="_parent"><b><%=fittingsCoopCount%></b></a>条配套合作,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=19" target="_parent"><b><%=fittingsBussCount%></b></a>条代理招商,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=22" target="_parent"><b><%=fittingsProdCount%></b></a>条产品,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=21" target="_parent"><b><%=fittingsBuyCount%></b></a>条配套求购,<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=20" target="_parent"><b><%=fittingsSupplyCount%></b></a>条配套供应&nbsp;&nbsp;&nbsp; <br />
您发布的信息量过少，为获得更多商机，建议您增加信息发布量！<a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=18" target="_parent">管理配套合作</a>&nbsp;&nbsp;&nbsp;&nbsp; <a style="color:#124b89;text-decoration:underline" href="membermain.jsp?addflag=19" target="_parent">管理代理招商</a>
<%}%>
<br />恭喜您，收到<a style="color:#FF0000;text-decoration:underline" href="/manage/membermain.jsp?addflag=26" target="_parent"><b><%=messFittings%></b></a>条留言	
    </div>
  </div>
  <div class="loginok_center3" style="width:543px">
    <div class="loginok_center3_1"><span class="bigblueb">服务介绍、品牌推广</span></div>
    <div class="loginok_center3_2">
	
	<table width="541" border="0">
      <tr>
        <td width="273"><a href="http://www.21peitao.com/service/service_member.htm" target="_blank"> 配套网会员服务</a></td>
        <td width="273"><a href="http://www.21peitao.com/service/brand_promote.htm" target="_blank">品牌推广解决方案</a></td>
        <td width="273"><a href="http://www.21peitao.com/service/service_member.htm" target="_blank">信息互动服务</a></td>
        <td width="258"><a href="http://www.21peitao.com/service/brand_promote.htm" target="_blank">初级解决方案</a></td>
      </tr>
      <tr>
        <td><a href="http://www.21peitao.com/service/brand_promote.htm" target="_blank">品牌推广服务</a></td>
        <td><a href="http://www.21peitao.com/service/brand_promote.htm" target="_blank">中级解决方案</a></td>
        <td><a href="http://www.21peitao.com/service/service_member.htm" target="_blank">会员增值服务</a></td>
        <td><a href="http://www.21peitao.com/service/brand_promote.htm" target="_blank">高级解决方案</a></td>
      </tr>
    </table>
 </div>
  </div>
 
</div>
</div>
</body>
</html>
