<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
<%@page import="com.jerehnet.webservice.WEBEmail"%><%@ include file ="include/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
PreparedStatement pstmt = null;	
ResultSet rs = null;
ResultSetMetaData rsmd = null;
HashMap memberInfo = new HashMap();
int isReg = 1;

   String addflag= Common.getFormatInt(request.getParameter("addflag"));   //操作标识
   String reg_source="0";
    //====根据addflag取出站点相应信息====
	String[][] tempSiteInfo = DataManager.fetchFieldValue(pool,"member_purview_new","site_flag,css_num","flag=1 and add_flag='"+addflag+"'");
if(tempSiteInfo!=null&&tempSiteInfo[0][0]!=null)
 {reg_source=Common.getFormatInt(tempSiteInfo[0][0]);}
	

	String addIp = Common.getFormatStr(Common.getRemoteAddr(request,1));
	String addDate = Common.getFormatStr(Common.getToday("yyyy-MM-dd HH:mm:ss",0));
	String memNo = Common.getFormatStr(request.getParameter("mem_no"));
	String memName = Common.getFormatStr(request.getParameter("mem_name"));
	String passw = Common.getFormatStr(request.getParameter("passw"));
	String passwQuestion = Common.getFormatStr(request.getParameter("passw_question"));
	String passwAnswer = Common.getFormatStr(request.getParameter("passw_answer"));
	String perSex = Common.getFormatStr(request.getParameter("per_sex"));
	String perPhone = Common.getFormatStr(request.getParameter("per_phone"));
	String perEmail = Common.getFormatStr(request.getParameter("per_email"));
	String perProvince = Common.getFormatStr(request.getParameter("zd_province"));
	String perCity = Common.getFormatStr(request.getParameter("zd_city"));
	String regCity = Common.getFormatStr(request.getParameter("regCity"));
	String comp_name = Common.getFormatStr(request.getParameter("comp_name"));
	String comp_address = Common.getFormatStr(request.getParameter("comp_address"));
	String comp_intro = Common.getFormatStr(request.getParameter("comp_intro"));

boolean strIsNotNull = false;

if(addIp.length()>5 && addDate.length()>10 && memNo.length()>=4 && passw.length()>=4){
	strIsNotNull = true;
}	
//System.out.println(addIp+"--"+addDate+"--"+memNo+"--"+passw+"--");

//验证码处理
String rand = Common.getFormatStr(request.getParameter("rand"));
String randSession = Common.getFormatStr((String)session.getAttribute("loginRand"));
boolean isRandOK = false;
if(rand.equals(randSession)){
	isRandOK = true;
}


//System.out.println(rand+"--session equls--"+randSession+"--strIsNotNull="+strIsNotNull);
if(isRandOK && strIsNotNull){

	//组装INSERT语句
	String insSql = "insert into member_info(add_ip,add_date,mem_no,mem_name,passw,passw_question,passw_answer,per_sex,per_phone,per_email,per_province,per_city,regi_ip,regi_city,regi_date,state,mem_flag,mem_flag_name,login_count,flag_job,flag_bbs,flag_blog,flag_space,flag_21part,comp_name,comp_address,comp_intro,reg_source,mem_flag_enddate) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
/*System.out.println("insert into member_info(add_ip,add_date,mem_no,mem_name,passw,passw_question,passw_answer,per_sex,per_phone,per_email,per_province,"+"per_city,regi_ip,regi_city,regi_date,state,mem_flag,mem_flag_name,login_count,flag_job,flag_bbs,flag_blog,flag_space,flag_21part,comp_name,comp_address,comp_intro)"+"values('"+addIp+"','"+addDate+"','"+memNo+"','"+memName+"','"+passw+"','"+passwQuestion+"','"+passwAnswer+"','"+perSex+"','"+perPhone+"','"+perEmail+"','"+perProvince+"','"+perCity+"','"+Common.getRemoteAddr(request,1)+"','"+regCity+"','"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0)+"',1,'-1','普通会员','1','0','0','0','0','0','"+comp_name+"','"+comp_address+"','"+comp_intro+"')");
*/
	try{
		conn = pool.getConnection();
		pstmt = conn.prepareStatement(insSql);
		pstmt.setString(1, addIp);
		pstmt.setString(2, addDate);
		pstmt.setString(3, memNo);
		pstmt.setString(4, memName);
		pstmt.setString(5, passw);
		pstmt.setString(6, passwQuestion);
		pstmt.setString(7, passwAnswer);
		pstmt.setString(8, perSex);
		pstmt.setString(9, perPhone);
		pstmt.setString(10, perEmail);
		pstmt.setString(11, perProvince);
		pstmt.setString(12, perCity);
		pstmt.setString(13, Common.getRemoteAddr(request,1));
		pstmt.setString(14, regCity);
		pstmt.setString(15, Common.getToday("yyyy-MM-dd HH:mm:ss", 0));
		pstmt.setString(16, "0");
		pstmt.setString(17, "-1");
		pstmt.setString(18, "普通会员");
		pstmt.setString(19, "1");
		pstmt.setString(20, "0");
		pstmt.setString(21, "0");
		pstmt.setString(22, "0");
		pstmt.setString(23, "0");
		pstmt.setString(24, "0");
		pstmt.setString(25, comp_name);
		pstmt.setString(26, comp_address);
		pstmt.setString(27, comp_intro);
		pstmt.setString(28, reg_source);
		pstmt.setString(29, Common.getToday("yyyy-MM-dd HH:mm:ss", 3));

		pstmt.executeUpdate();
		pstmt = null;


		//登陆
		//String querySql = "select * from member_info where mem_no=? ";
		//System.out.println(querySql+"-"+memNo);
		//pstmt = conn.prepareStatement(querySql);
		//pstmt.setString(1, memNo);

		//rs = pstmt.executeQuery();
		
		//java.util.Date endDate = null;
		//java.util.Date nowDate = news java.util.Date nowDate();
		//if (rs != null && rs.next()) {

			//rsmd = rs.getMetaData();
			//for (int i = 1; i <= rsmd.getColumnCount(); i++) {
				//memberInfo.put(rsmd.getColumnName(i), rs.getString(rsmd.getColumnName(i)));
				//if(rsmd.getColumnName(i).equals("mem_flag_enddate")){
					//endDate = rs.getDate(rsmd.getColumnName(i));
				//}
			//}
			
			//if(((String)memberInfo.get("mem_flag")).equals("1001"))  
			//session.setAttribute("memberInfo",memberInfo);
			//String uptSql = "update member_info set login_last_city='"+regCity+"',login_last_ip='"+ Common.getRemoteAddr(request,1) + "',login_last_date='"+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0)+ "' where mem_no='" + usern + "'";
			//DataManager.dataOperation(conn, uptSql);

		//}	
		
	
	}catch(Exception e){
		e.printStackTrace();
		System.out.println("login -1 -1 -1");
		isReg = -1;
	}
	finally{
		pool.freeConnection(conn);
	}
	
}else{
	System.out.println("login -2 -2 -2");
	isReg = -2;
}
if(!strIsNotNull){
	isReg = -1;
}

String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
</div>
<div class="center">
  <div class="zhuce">
    <ul class="step">
      <li class="step1"></li>
	    <%
if(isReg!=1){
%>
      <li class="steparrow"></li>
      <li class="step2_c"></li>
<%}%>	  
      <li class="steparrow"></li>
	    <%
if(isReg==1){
%>	  
      <li class="step3_c"></li>
<%}%>
<li class="steparrow"></li>
      <li class="step6"></li>	  
    </ul>
  </div>
  <div class="zhuce1">
  <%
if(isReg==1){
	//发送验证邮件
	try{
 		WEBEmail.sendMailByUrl(perEmail,null,null,"商贸网注册激活邮件","http://member.21-sun.com/tools/data/active_to_email.jsp?no="+memNo+"&pa="+passw+"&em="+perEmail,"utf-8");
	}catch (Exception e){
		e.printStackTrace();
	}

%>
<form id="repeat" name="repeat" method="post" action="member_reg_action_repeat.jsp">
<input type="hidden" id="mem_no" name="mem_no" value="<%=memNo%>"  />
<input type="hidden" id="passw" name="passw" value="<%=passw%>"  />
<input type="hidden" id="perEmail" name="perEmail" value="<%=perEmail%>"  />
</form>
   <table width="60%" border="0" align="center">
      <tr>
    <td width="31%" rowspan="2"><img src="images/zccg01.gif" /></td>
    <td width="69%" height="43"><img src="images/zccg02.gif" /></td>
  </tr>
  <tr>
    <td valign="top">
      恭喜您注册成为中国工程机械商贸网的会员<br/>
     <span style="color:#F60;font-weight:bold;">激活邮件已发送,请到邮箱<a class="blue12" href="http://mail.<%=perEmail.substring(perEmail.indexOf("@")+1)%>" target="_blank"><%=perEmail%></a>中激活完成注册</span><br /><br />若没有收到激活邮件：<br />
     1、到邮箱中的垃圾邮件、广告邮件目录中找找<br />
     2、如果确认没有收到，可以<a href="#" onclick="document.getElementById('repeat').submit();" class="blue12">点此重发激活邮件</a><br />
     3、如有疑问，请电话联系：0535-6792736</td>
  </tr>
</table>
<script type="text/javascript">
//function daoshu(){
//	var djs = document.getElementById("daojishi");
// 	if(djs.innerHTML == 1){
  		//window.location.href='manage/membermain.jsp';
  		//window.location.href="manage/memberinfo_new.jsp?addflag=<%=addflag%>";
//  		window.location.href="manage/memberhome.jsp?addflag=<%=addflag%>";
//  		return false;
 //	}
 //	djs.innerHTML = djs.innerHTML - 1;
//}
//window.setInterval("daoshu()", 1000);

</script>
<script language="javascript" type="text/javascript">
//var hwd;
//var intSec = 2;//这里定义时间：秒
//function reHandle(){
 // 	if(intSec==0){
 // 		window.location.href="manage/memberhome.jsp?addflag=<%=addflag%>";
 // 	}else{
 // 		intSec--;
 // 	}
//  	hwd = setTimeout(reHandle,1000);
//}
//reHandle();
</script>

<%}else{
//session.setAttribute("regRand","");
%>
<table width="60%" border="0" align="center">
  <tr>
    <td width="31%" rowspan="2"><img src="images/zcsb01.gif" alt="" /></td>
    <td width="69%" height="48"><img src="images/zcsb02.gif" alt="" /></td>
  </tr>
  <tr>
    <td><%if(isReg==-2){%>您输入的验证码有误， <a href="javascript:history.back();" class="blue14" >点击此处返回</a>。<%}else{%>请仔细检查您的注册信息是否符合要求后，再次提交， <a href="javascript:history.back();" class="blue14" >点击此处返回</a>。<%}%></td>
  </tr>
</table>
<%
}
%>
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
        ·广告服务支持<br/><br/></div>
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
<%
if(isReg==1){
%>

<script language="javascript" type="text/javascript">
//注册成功，给新用户发送邮
	
//  $.ajax({
//       url:"/tools/mail.jsp?email=<%=perEmail%>&uid="+encodeURIComponent("<%=memNo%>")+"&password=<%=passw%>&fullname="+encodeURIComponent("<%=memName%>"),
//       type:"post",
//       success:function(msg){
//      }
//    });

</script>

<!--	
<script src="http://part.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
<script src="http://market.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
<script src="http://used.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
<script src="http://rent.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
<script src="http://member.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
-->
<%
}
//System.out.println("==:"+isLogon);
%>
</body>
</html>