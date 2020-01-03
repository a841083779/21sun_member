<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="include/config.jsp"%><%
if(pool==null){
	pool = new PoolManager();
}
Connection conn =null;
PreparedStatement pstmt = null;	
ResultSet rs = null;
ResultSetMetaData rsmd = null;
HashMap memberInfo = new HashMap();
int isLogon = 0;
String refer = Common.getFormatStr(request.getHeader("Referer"));
String memNo = Common.getFormatStr(request.getParameter("mem_no"));
String passw = Common.getFormatStr(request.getParameter("passw"));

String rand = Common.getFormatStr(request.getParameter("rand"));
String randSession = Common.getFormatStr((String)session.getAttribute("loginRand"));
boolean isRandOK = false;
if(rand.equals(randSession)){
	isRandOK = true;
}

if(refer.indexOf("member.21-sun.com")==-1){
	isRandOK=true;
}
//System.out.println("==:"+rand+"--"+randSession);
String redirectfile="/manage/memberhome.jsp";

if(isRandOK){

	//组装查询语句
	//String querySql = "select * from member_info where mem_no=? and passw=?";
	String querySql = "select * from vi_member_info where mem_no=? and passw=?";
	//System.out.println(querySql+"--"+memNo+"-----"+passw);
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
					   		mid = rs.getString(rsmd.getColumnName(i));
					   }
					}
					session.setAttribute("memberInfo",memberInfo);
					
					isLogon = 1;
					String ip=Common.getRemoteAddr(request,1);
					//ip="221.0.90.164";
					//String []ips = ip.split("\\.");
					//String ipStr = df.format(Double.parseDouble(ips[0]) * 256 * 256 * 256 + Double.parseDouble(ips[1]) * 256 * 256 + Double.parseDouble(ips[2]) * 256 + Double.parseDouble(ips[3]) - 1);
					//System.out.println("555555555555");
					//String [][]addrs = DataManager.fetchFieldValue(pool,"ip","top 1 ip3,ip4","ip1<="+ipStr+" and ip2>="+ipStr+"");
					String loginCity = Common.getAddressForIp(request,Common.getRemoteAddr(request,1),1);
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

					//regCity = addrs!=null?addrs[0][0]:"";
					String uptSql = "update member_info set login_last_city='"+loginCity+"',login_last_ip='"+ Common.getRemoteAddr(request,1) + "',login_last_date='"+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0)+ "' where id=" + mid + "";
					
					DataManager.dataOperation(conn, uptSql);
					
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
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>会员注册 - 中国工程机械商贸网</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style_new.css" rel="stylesheet" type="text/css" />
<link href="style/tablestyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.4.1.min.js"></script>
<script type="text/javascript" src="/scripts/common.js"></script>
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
      <%
	if(isLogon==1){
	%>
      <li class="step4_c"></li>
      <%
	 }
	 %>
      <li class="steparrow"></li>
      <%
	if(isLogon!=1){
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
%>
    欢迎您登陆中国工程机械商贸网，
    <!--<span id="daojishi">3</span>秒后将自动跳转到＂<a href="/manage/membermain.jsp">我的商贸网</a>＂，-->
    <a  href="<%=redirectfile%>" class="blue14">点击此处立刻登录</a>。
    <%}else if(isLogon==-2){%>
    <a href="member_login.jsp" class="blue14">验证码不正确，请点击此处重新登录</a>。
    <%}else if(isLogon==-3){%>
    <a href="member_login.jsp" class="blue14">用户名或密码不正确，请点击此处重新登录</a>。
    <%}else if(isLogon==-1){%>
    您的用户已经被管理员禁用，请与我们客服联系，客服电话为：0535-6727765，<a href="member_login.jsp" class="blue14">点击此处重新登录</a>。
    <%}%></div>
</div>
<div class="top2">
  <div class="centertext_1">
    <div class="renarrow">会员介绍</div>
  </div>
  <div class="centertext">
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_vip.htm" class="b14" target="_blank">VIP会员</a><br/>
        ·市场调研服务<br/>
        ·新闻采访服务<br/>
        ·市场支持服务<br/>
        ·品牌宣传服务</div>
      <div class="centertext3" ><a href="http://www.21-sun.com/service/huiyuan/member_vip.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_b.htm" class="b14" target="_blank">B类会员</a> <br/>
        ·数据信息支持服务<br/>
        ·新闻采集、报道、采访<br/>
        ·市场信息支持服务<br/>
      ·广告服务支持</div>
      <div class="centertext3" ><a href="http://www.21-sun.com/service/huiyuan/member_b.htm" target="_blank">查看详情</a></div>
    </div>
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_a.htm" class="b14" target="_blank">A类会员</a> <br/>
        ·网站建设服务<br/>
        ·信息支持服务<br/>
        ·广告服务支持<br/><br/></div>
      <div class="centertext3" ><a href="http://www.21-sun.com/service/huiyuan/member_a.htm" target="_blank">查看详情</a></div>
    </div><!--
    <div class="centertext1">
      <div class="centertext2"> <a href="http://www.21-sun.com/service/huiyuan/member_edt.htm" class="b14" target="_blank">E点通会员</a> <br/>·免费下载浏览图纸资料<br/>
        ·信息支持服务<br/>
        ·广告服务<br/>
        <br/></div>
      <div class="centertext3" ><a href="http://www.21-sun.com/service/huiyuan/member_edt.htm" target="_blank">查看详情</a></div>
    </div>-->
    <div class="centertext1_1">
      <div class="centertext2"> <a href="http://www.21-cmjob.com/member/service/index.shtm" class="b14" target="_blank">人才网会员</a> <br/>
        ·金伯乐会员<br/>
        ·超级银伯乐会员<br/>
        ·银伯乐会员<br/>
        ·季度会员</div>
      <div class="centertext3" ><a href="http://www.21-cmjob.com/member/service/index.shtm" target="_blank">查看详情</a></div>
    </div>
  </div>
</div>
<jsp:include page="manage/foot_new.jsp" />
<%
	if(isLogon==1){
	%>
<script type="text/javascript">
function goturl(){
 window.location.href='<%=redirectfile%>';
}
goturl();
</script> 
<%
}
%>
</body>
</html>