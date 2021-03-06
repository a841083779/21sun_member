<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@ include file ="include/config.jsp"%>
<%
	if(pool==null){
		pool = new PoolManager();
	}
	Connection conn =null;
	PreparedStatement pstmt = null;	
	ResultSet rs = null;
	ResultSetMetaData rsmd = null;
	int isReg = 0;

   	String Email= Common.getFormatStr(request.getParameter("per_email")); 
   	String MemberNo= Common.getFormatStr(request.getParameter("mem_no")); 

	//验证码处理
	String rand = Common.getFormatStr(request.getParameter("rand"));
	String randSession = Common.getFormatStr((String)session.getAttribute("loginRand"));
	boolean isRandOK = false;
	if(rand.equals(randSession)){
		isRandOK = true;
	}
	if(isRandOK && Email!=null && !Email.equals("") && MemberNo!=null && !MemberNo.equals("")){
		try{
			conn = pool.getConnection();
			String sql = " SELECT mem_no,passw from member_info WHERE per_email='"+Email+"' and mem_no = '"+MemberNo+"' ";
			rs = DataManager.executeQuery(conn, sql);
			if(rs != null && rs.next()){
				isReg = 1;
			}
		}catch(Exception e){
			e.printStackTrace();
			isReg = -1;
		}
		finally{
			pool.freeConnection(conn);
		}
		
	}else{
		isReg = -2;
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>找回密码 - 中国工程机械商贸网</title>
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
      <li class="step01"></li>
      <li class="steparrow01"></li>
	    <%
if(isReg!=1){
%>
      <li class="step02_c"></li>
<%}%>	  
      <li class="steparrow01"></li>
	    <%
if(isReg==1){
%>	  
      <li class="step03_c"></li>
<%}%>	  
    </ul>
  </div>
  <div class="zhuce1">
  <%
if(isReg==1){
	//发送验证邮件
	try{
		
		String uuid = Common.createUUID(1);
		Common.createCookie(response,"code",uuid,259200);
 		boolean result = WEBEmail.sendMailByUrl(Email,null,null,"商贸网找回密码邮件","http://member.21-sun.com/tools/data/pass_find_email.jsp?email="+Email+"&no="+MemberNo+"&code="+uuid,"utf-8");
	}catch (Exception e){
		e.printStackTrace();
	}

%>
   <table width="60%" border="0" align="center">
      <tr>
    <td width="69%" height="43"><span style="color:#F60;font-weight:bold; font-size:14px">找回密码：</span></td>
  </tr>
  <tr>
    <td valign="top">
      <span>邮件已经发送到您的邮箱：<a class="blue12" href="http://mail.<%=Email.substring(Email.indexOf("@")+1)%>" target="_blank"><%=Email%></a>，请点击其中的链接重设密码。</span><br /><br />
      没有收到确认邮件？您可以：</br></br>
      1、<span>到邮箱中的垃圾邮件、广告邮件目录中找找</span><br />
      2、如果确认没有收到，可以<a href="/member_pass_find.jsp" class="blue12">点此重发找回密码邮件</a><br />
      3、如有疑问，请电话联系：0535-6792736</td>
  </tr>
</table>
<%}else{
//session.setAttribute("regRand","");
%>
<table width="60%" border="0" align="center">
  <tr>
    <td width="31%" rowspan="2"><img src="images/zcsb01.gif" alt="" /></td>
    <td width="69%" height="48"><img src="images/fssb.gif" alt="" /></td>
  </tr>
  <tr>
    <td>
    	<%
    		if(isReg==-2){
    	%>
    	您输入的验证码有误， <a href="javascript:history.back();" class="blue14" >返回修改</a>。
    	<%
    		}else{
    	%>
    	您的信息有误，确认后再次提交， <a href="javascript:history.back();" class="blue14" >返回修改</a>。
    	<%}%>
    </td>
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
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_sj.htm" class="b14" target="_blank">VIP会员</a><br/>
        ·市场调研服务<br/>
        ·新闻采访服务<br/>
        ·市场支持服务<br/>
        ·品牌宣传服务</div>
      <div class="centertext3" ><a href="http://www.21-sun.com/service/huiyuan/member_vip.htm" target="_blank">查看详情</a></div>
    </div>
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
</body>
</html>
