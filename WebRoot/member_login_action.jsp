<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@ include file ="include/config.jsp"%>
<%
	if(pool==null){
		pool = new PoolManager();
	}
	Connection conn =null;
	PreparedStatement pstmt = null;	
	ResultSet rs = null;
	ResultSetMetaData rsmd = null;
	HashMap memberInfo = new HashMap();
	int isLogon = 0;
	
	//是否从配件网来---added by gaopeng---20130819
	String source = CommonString.getFormatPara(request.getParameter("source"));
	
	String refer = Common.getFormatStr(request.getHeader("Referer"));
	String memNo = Common.getFormatStr(request.getParameter("mem_no"));
	
	String passw = Common.getFormatStr(request.getParameter("passw"));
	passw = DesEncrypt.MD5(passw);
	String rand = Common.getFormatStr(request.getParameter("rand"));
	String randSession = Common.getFormatStr((String)session.getAttribute("loginRand"));
	boolean isRandOK = false;
	if(rand.equals(randSession)){
		isRandOK = true;
	}
	if(refer.indexOf("member.21-sun.com")==-1){
		isRandOK=true;
	}
	String redirectfile="/manage/memberhome.jsp";
	String f = Common.getFormatStr(request.getParameter("f"));
	if(!"".equals(f)){
		if("used".equals(f)){
			redirectfile = "/manage/used.jsp";
		}else if("sell".equals(f)){
			redirectfile = "/manage/used.jsp?f=sell";
		}else if("buy".equals(f)){
			redirectfile = "/manage/used.jsp?f=buy";
		}else if("sale".equals(f)){
			redirectfile = "/manage/used.jsp?f=sale";
		}
	}
		
	if(isRandOK){
		String querySql = "select * from vi_member_info where mem_no=? and passw=?";
		try{
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(querySql);
			pstmt.setString(1, memNo);
			pstmt.setString(2, passw);
		
			rs = pstmt.executeQuery();
		
			if (rs != null && rs.next()) {
				if (rs.getString("mem_no").equalsIgnoreCase(memNo)&& rs.getString("passw").equalsIgnoreCase(passw)) {
					if (Common.getFormatStr(rs.getString("state")).equals("1")) {
						rsmd = rs.getMetaData();
						String mid="-1";
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
						   memberInfo.put(rsmd.getColumnName(i), rs.getString(rsmd.getColumnName(i)));
						   if(rsmd.getColumnName(i).equalsIgnoreCase("id")){
						   		mid = rs.getString(rsmd.getColumnName(i));  //   取出id 
						   }
						}
						session.setAttribute("memberInfo",memberInfo);  // 设置session
						isLogon = 1;
						String ip=Common.getRemoteAddr(request,1);
				// 		String loginCity = Common.getAddressForIp(request,Common.getIp(request,1),1);  //   根据ip 获得地址
						String loginCity = CommonString.getFormatPara(request.getParameter("loginCity")) ;
						String province="";
						String city="";
					
						String [][]provinces = (String[][])application.getAttribute("provinces");
						String [][]citys = (String[][])application.getAttribute("citys");
					
						for(int i=0;provinces!=null && i<provinces.length;i++){
							if(loginCity.indexOf(provinces[i][0])!=-1){
								province=provinces[i][0];
							}
						}
						session.setAttribute("province",province);
						for(int i=0;citys!=null && i<citys.length;i++){
							if(loginCity.indexOf(citys[i][0])!=-1){
								city=citys[i][0];
							}
						}
						session.setAttribute("city",city);

						String uptSql = "update member_info set login_count=isnull(login_count,0)+1, login_last_city='"+loginCity+"',login_last_ip='"+ Common.getRemoteAddr(request,1) + "',login_last_date='"+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0)+ "' where id=" + mid + "";
						DataManager.dataOperation(conn, uptSql);
						
						//创建cookie，识别是机器发布还是人为发布
						Common.createCookie(response,"is_per_pub","per_pub",36000);
						
						//如果从配件网来，跳转到配件网---edited by gaopeng---20130819
						if(source!=null  &&  source.equals("part")){
							redirectfile = "http://member.21-sun.com/home/part/product/list.jsp";
						}
						
					} else {
						isLogon = -1;
					}
				}
			}else{
				isLogon = -3;
			}	
		}catch(Exception e){e.printStackTrace();}
		finally{
			pool.freeConnection(conn);
		}
	}else{
		isLogon = -2;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员注册 - 中国工程机械商贸网</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style_new.css" rel="stylesheet" type="text/css" />
<link href="style/tablestyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.4.1.min.js"></script>
<script type="text/javascript" src="/scripts/common.js"></script>
<script type="text/javascript" src="/scripts/sha1.js"></script>
</head>
<body>
<jsp:include page="manage/top_new.jsp" />
<div class="weizhi">
  <div class="weizhi_1">您的位置 >> 我的商贸网</div>
</div>
<div class="center">
<div style="float:left;width:98px;height:125px;margin-top:10px;margin-left:760px!important;margin-left:700px;display:inline;position:absolute;z-index:100;"><img src="/images/baobao.gif" width="98" height="125"></div>
  <div class="zhuce">
    <ul class="step">
    <li class="steparrow"></li>
<%
	if(isLogon==1){
%>
      <li class="step4_c"></li>
<%
	 }else if(isLogon!=1){
%>
      <li class="step5_c"></li>
<%
	 }
%>
    </ul>
  </div>
  <div class="zhuce1">
<%
	if(isLogon==1){
		out.println(memNo) ;
%>
    <span  class="blue14">欢迎登陆<b>中国工程机械商贸网</b>，登录后会自动跳转进入会员商务室，如果没有跳转，
    <!--<span id="daojishi">3</span>秒后将自动跳转到＂<a href="/manage/membermain.jsp">我的商贸网</a>＂，-->
    <a href="<%=redirectfile%>" style="color:#014099;">请您点击此处</a>。</span>
    <%}else if(isLogon==-2){%>
    <a href="member_login.jsp" class="blue14">验证码不正确，请点击此处重新登录</a>。
    <%}else if(isLogon==-3){%>
    <a href="member_login.jsp" class="blue14">用户名或密码不正确，请点击此处重新登录</a>。
    <%}else if(isLogon==-1){%>
    您的用户已经被管理员禁用，请与我们客服联系，客服电话为：0535-6792761，<a href="member_login.jsp" class="blue14">点击此处重新登录</a>。
    <%}%></div>
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
<jsp:include page="manage/foot_new.jsp" />
<%
	if(isLogon==1){
%>

<script language="javascript" type="text/javascript">
	  window.location.href="<%=redirectfile%>";
</script>

<%
	}
%>
</body>
</html>