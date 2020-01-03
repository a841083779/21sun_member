<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="org.apache.commons.httpclient.params.HttpMethodParams"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.sun.mail.iap.Response"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@ include file="include/config.jsp"%>
<%

	if (pool == null) {
		pool = new PoolManager();
	}
	Connection conn = null;
	Connection conn_name = null;
	Connection conn_phone = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt_name = null;
	PreparedStatement pstmt_name = null;

	ResultSet rs = null;
	ResultSet rs_name = null;
	ResultSet rs_phone = null;
	ResultSetMetaData rsmd = null;
	HashMap memberInfo = new HashMap();
	int isReg = 1;
	String referer = request.getHeader("referer");// 来自新浪或qq用户不需要验证码
	String addflag = Common.getFormatInt(request.getParameter("addflag")); //操作标识
	String reg_source = "0";
	//====根据addflag取出站点相应信息====
	String[][] tempSiteInfo = DataManager.fetchFieldValue(pool, "member_purview_new", "site_flag,css_num", "flag=1 and add_flag='" + addflag + "'");
	//System.out.println(referer+"----") ; 
	if (tempSiteInfo != null && tempSiteInfo[0][0] != null) {
		reg_source = Common.getFormatInt(tempSiteInfo[0][0]);
	}

	String addIp = Common.getFormatStr(Common.getRemoteAddr(request, 0));
	String reg_ips=Common.getFormatStr(Common.getRemoteAddr(request,1));//ip过滤
	//addIp = "127.0.0.1";
	String addDate = Common.getFormatStr(Common.getToday("yyyy-MM-dd HH:mm:ss", 0));
	String memNo = Common.getFormatStr(request.getParameter("mem_no"));
	String memName = Common.getFormatStr(request.getParameter("mem_name"));
	if(memNo.equals("小伙")||memName.equals("小伙")){return;}
	String password_bak = Common.getFormatStr(request.getParameter("passw"));
	String passw = DesEncrypt.MD5(password_bak);  
	String perPhone = Common.getFormatStr(request.getParameter("per_phone"));
	String perEmail = Common.getFormatStr(request.getParameter("per_email"));
	String perProvince = Common.getFormatStr(request.getParameter("zd_province"));
	if(perProvince.equals("天津")){return;}
	String perCity = Common.getFormatStr(request.getParameter("zd_city"));
	String purpose = Common.getFormatStr(request.getParameter("purpose"));
	
	//String regCity = Common.getFormatStr(request.getParameter("regCity"));
	//String comp_name = Common.getFormatStr(request.getParameter("comp_name"));
	//String comp_address = Common.getFormatStr(request.getParameter("comp_address"));
	//String comp_intro = Common.getFormatStr(request.getParameter("comp_intro"));
	//String sina_id = Common.getFormatStr(request.getParameter("sina_id")); //新浪微博用户登录 id
	//String qq_id = Common.getFormatStr(request.getParameter("qq_id"));
	//String passwQuestion = Common.getFormatStr(request.getParameter("passw_question"));
	//String passwAnswer = Common.getFormatStr(request.getParameter("passw_answer"));
	//String perSex = Common.getFormatStr(request.getParameter("per_sex"));
	
	//过滤特殊字符
	memNo = memNo.replace("'", "").replace("\"", "").replace("<", "").replace(">", "").replace("script", "").replace(" or ", "").replace(
			" and ", "").replace("iframe", "").replace(" href ", "").replaceAll(".*([';]+|(--)+).*", " ").trim();
	perPhone = perPhone.replace("'", "").replace("\"", "").replace("<", "").replace(">", "").replace("script", "").replace(" or ", "").replace(
			" and ", "").replace("iframe", "").replace(" href ", "").replaceAll(".*([';]+|(--)+).*", " ").trim();
	perEmail = perEmail.replace("'", "").replace("\"", "").replace("<", "").replace(">", "").replace("script", "").replace(" or ", "").replace(
			" and ", "").replace("iframe", "").replace(" href ", "").replaceAll(".*([';]+|(--)+).*", " ").trim();
	
	
	//是否从配件网来---added by gaopeng---20130819
	String source = CommonString.getFormatPara(request.getParameter("source"));
	
	//用户名重复验证
	String nameSql = "select * from member_info where mem_no=?";
	int cheak_name=0;
	try{
		conn_name = pool.getConnection();
		pstmt_name = conn_name.prepareStatement(nameSql);
		pstmt_name.setString(1, memNo);		
		rs_name = pstmt_name.executeQuery();
		if(rs_name.next()){
			cheak_name=1;
		}
		
	}catch(Exception e){e.printStackTrace();}
	finally{
		pool.freeConnection(conn_name);
	}
	
    //ip注册次数统计
	int inquriyCount=0;
	if( session.getAttribute(reg_ips)!=null){
	inquriyCount=(Integer) session.getAttribute(reg_ips) ;
	}
	session.setAttribute(reg_ips,inquriyCount+1);
	
	//获取注册次数
	String countSql = "select count(id) from member_info where  add_ip='"+reg_ips+"'";
	try{
		conn_name = pool.getConnection();
		pstmt_name = conn_name.prepareStatement(countSql);
		pstmt_name.setString(1, memNo);		
		rs_name = pstmt_name.executeQuery();
		if(rs_name.next()){
			cheak_name=1;
		}
		
	}catch(Exception e){e.printStackTrace();}
	finally{
		pool.freeConnection(conn_name);
	}
	
	
	//用户手机重复验证
	String tel =perPhone;
	String querySql = "select per_phone from member_info where per_phone=?";
	int cheak_phone=0;
	try{
		conn_phone = pool.getConnection();
		pstmt = conn_phone.prepareStatement(querySql);
		pstmt.setString(1, tel);		
		rs_phone = pstmt.executeQuery();
		if(rs_phone.next()){
			cheak_phone=1;
		}
		
	}catch(Exception e){e.printStackTrace();}
	finally{
		pool.freeConnection(conn_phone);
	}
	
	
	boolean strIsNotNull = false;
    
	if (addIp.length() > 5 && addDate.length() > 10 && memNo.length() >= 4 && passw.length() >= 4 && inquriyCount<=7 && cheak_phone==0 &&cheak_name==0) {
		strIsNotNull = true;
	}
	//out.println("addIp:"+addIp+"addDate:"+addDate+"memNo:"+memNo+"passw:"+passw);
	//验证码处理
	String rand = Common.getFormatStr(request.getParameter("rand"));
	String randSession = Common.getFormatStr((String) session.getAttribute("loginRand"));
	boolean isRandOK = false;
	if (rand.equals(randSession)) {
		isRandOK = true;
	}
	if(referer!=null && !referer.equals("") &&!perPhone.equals("18888888888")&&!memName.equals("王磊")){
		if ((isRandOK && strIsNotNull)|| referer.indexOf("openplatform/member_reg.jsp") != -1) {
			//组装INSERT语句
			String insSql = "insert into member_info(add_ip,add_date,add_user,mem_no,mem_name,passw,per_phone,per_email,per_province,per_city,regi_ip,regi_city,regi_date,state,mem_flag,mem_flag_name,login_count,flag_job,flag_bbs,flag_blog,flag_space,flag_21part,reg_source,mem_flag_enddate,purpose,password_bak) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			String aa="insert into member_info(add_ip,add_date,add_user,mem_no,mem_name,passw,per_phone,per_email,per_province,"+"per_city,regi_ip,regi_city,regi_date,state,mem_flag,mem_flag_name,login_count,flag_bbs,flag_blog,flag_space,flag_21part)"+"values('"+addIp+"','"+addDate+"','注册入口','"+memNo+"','"+memName+"','"+passw+"','"+perPhone+"','"+perEmail+"','"+perProvince+"','"+perCity+"','"+Common.getRemoteAddr(request,1)+"','"+perCity+"','"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0)+"',1,'-1','普通会员','1','0','0','0','0')";
	
			try {
				conn = pool.getConnection();
				
				DataManager.dataOperation(pool,aa);

				//pstmt = conn.prepareStatement(insSql);
			
	
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
				
				//add by gaopeng 20130409--begin
				//注册目的发邮件
				if(purpose.equals("2") || purpose.equals("3") || purpose.equals("4")){
					String purposeStr = "";
					if(purpose.equals("2")){
						purposeStr = "希望了解网站所有提供的服务";
					}else if(purpose.equals("3")){
						purposeStr = "人工指导我成为付费会员，查看收费项目信息";
					}else if(purpose.equals("4")){
						purposeStr = "我想了解网建、会员、邮局、3D展厅、管理软件等服务项目的价格";
					}
					HttpClient client = new HttpClient();
					PostMethod method =new PostMethod("http://service.21-sun.com/http/utils/sendmail.jsp");
					method.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
					String fixed = "21sun";
					String mailto="zhangchen@21-sun.com";
					String mailcc="songlf@21-sun.com";
					String title="会员注册邮件";
					String content = "";
					
					//内容
					content = "<table cellpadding='5' cellspacing='5'>";
					content += "<tr><td colspan='2'><b>会员注册信息</b></td></tr>";
					content += "<tr>";
					content += "<td>注册目的：</td><td>"+purposeStr+"</td>";
					content += "</tr>";
					content += "<tr>";
					content += "<td>用户名：</td><td>"+ memNo+"</td>";
					content += "</tr>";
					content += "<tr>";
					content += "<td>邮箱：</td><td>"+ perEmail+"</td>";
					content += "</tr>";
					content += "<tr>";
					content += "<td>手机：</td><td>"+ perPhone+"</td>";
					content += "</tr>";
					content += "</table>";
					String fromName="来自21-sun";
					NameValuePair[] data ={ new NameValuePair("to",mailto),new NameValuePair("cc",mailcc),new NameValuePair("title",title),new NameValuePair("content",content),new NameValuePair("fromName",fromName),new NameValuePair("fixed",fixed)};
					method.setRequestBody(data);
					Object a = client.executeMethod(method);
					if(a!=null){
						String resultBack = a.toString();
						if(resultBack.equals("200")){
							//System.out.println("邮件发送成功！");
						}else{
							//System.out.println("邮件发送不成功！");
						}
					}else{
						//System.out.println("邮件发送不成功！");
					}
					// 释放连接
					method.releaseConnection();
				}
				//add by gaopeng 20130409--end
			} catch (Exception e) {
				e.printStackTrace();
				//out.println("login -1 -1 -1");
				isReg = -1;
			} finally {
				pool.freeConnection(conn);
			}
		} else {
			//System.out.println("login -2 -2 -2 验证码错误");
			isReg = -2;
		}
		if (!strIsNotNull) {
			isReg = -1;
		}
	}else{
		response.sendRedirect("http://member.21-sun.com");
		return;
	}
	String keyPar = ((String) memberInfo.get("mem_no")) + "--" + ((String) memberInfo.get("passw")) + "--" + Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
	keyPar = Common.encryptionByDES(keyPar);
	//added by gaopeng at 20130416--begin
	
	if (isReg == 1) {
		//注册成功后登录并跳转到完善信息页面
		int isLogon = 0;
		String querySqls = "select * from vi_member_info where mem_no=? and passw=?";
		try{
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(querySqls);
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
					// 	String loginCity = Common.getAddressForIp(request,Common.getRemoteAddr(request,1),1);  //   根据ip 获得地址
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
		//如果从配件网来，跳转到配件网---edited by gaopeng---20130819
		if(source!=null  &&  source.equals("part")){
			response.sendRedirect("http://member.21-sun.com/home/part/product/list.jsp");
		}else{
			response.sendRedirect("http://member.21-sun.com/manage/memberinfo_new.jsp");
		}
		return;
	}
	//added by gaopeng at 20130416--end
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>会员注册 - 中国工程机械商贸网</title>
		<link href="style/style.css" rel="stylesheet" type="text/css" />
		<link href="style/tablestyle.css" rel="stylesheet" type="text/css" />
		<script src="scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
		<script src="scripts/citys.js" type="text/javascript"></script>
		<script src="scripts/zhucheyanzheng.js" type="text/javascript"></script>
	</head>
	<body>
		<jsp:include page="manage/top.jsp" />
		<div class="weizhi">
			<div class="weizhi_1">
				您的位置 >> 我的商贸网
			</div>
		</div>
		<div class="center">
			<div class="zhuce">
				<ul class="step">
					<li class="step1"></li>
					<%
						if (isReg != 1) {
					%>
					<li class="steparrow"></li>
					<li class="step2_c"></li>
					<%
						}
					%>
					<li class="steparrow"></li>
					<%
						if (isReg == 1) {
					%>
					<li class="step3_c"></li>
					<%
						}
					%>
					<li class="steparrow"></li>
					<li class="step6"></li>
				</ul>
			</div>
			<div class="zhuce1">
				<%
					if (isReg == 1) { // 邦定帐号不发送邮件
						//发送验证邮件
						if(referer!=null && !referer.equals("") ){
							if(referer.indexOf("openplatform/member_reg.jsp") == -1){
							try {
								//WEBEmail.sendMailByUrl(perEmail, null, null, "商贸网注册激活邮件AD", "http://member.21-sun.com/tools/data/active_to_email.jsp?no=" + memNo + "&pa="+ Common.getFormatStr(request.getParameter("passw")) + "&em=" + perEmail, "utf-8");
							} catch (Exception e) {
								e.printStackTrace();
							}
							}
						}
				%>
				<form id="repeat" name="repeat" method="post"
					action="member_reg_action_repeat.jsp">
					<input type="hidden" id="mem_no" name="mem_no" value="<%=memNo%>" />
					<input type="hidden" id="passw" name="passw" value="<%=Common.getFormatStr(request.getParameter("passw"))%>" />
					<input type="hidden" id="perEmail" name="perEmail"
						value="<%=perEmail%>" />
				</form>
				<table width="60%" border="0" align="center">
					<tr>
						<td width="31%" rowspan="2">
							<img src="images/zccg01.gif" />
						</td>
						<td width="69%" height="43">
							<img src="images/zccg02.gif" />
						</td>
					</tr>
					<tr>
						<td valign="top">
							恭喜您注册成为中国工程机械商贸网的会员
							<br />
							<span style="color: #F60; font-weight: bold;">激活邮件已发送,请到邮箱<a
								class="blue12"
								href="http://mail.<%=perEmail.substring(perEmail.indexOf("@") + 1)%>"
								target="_blank"><%=perEmail%></a>中激活完成注册</span>
							<br />
							<br />
							若没有收到激活邮件：
							<br />
							1、到邮箱中的垃圾邮件、广告邮件目录中找找
							<br />
							2、如果确认没有收到，可以
							<a href="#" onclick="document.getElementById('repeat').submit();"
								class="blue12">点此重发激活邮件</a>
							<br />
							3、如有疑问，请电话联系：0535-6792736
						</td>
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

				<%
					} else {
						//session.setAttribute("regRand","");
				%>
				<table width="60%" border="0" align="center">
					<tr>
						<td width="31%" rowspan="2">
							<img src="images/zcsb01.gif" alt="" />
						</td>
						<td width="69%" height="48">
							<img src="images/zcsb02.gif" alt="" />
						</td>
					</tr>
					<tr>
						<td>
							<%
								if (isReg == -2) {
							%>您输入的验证码有误，
							<a href="javascript:history.back();" class="blue14">点击此处返回</a>。<%
								} else {
							%>请仔细检查您的注册信息是否符合要求后，再次提交。问题提示：<% if(cheak_name==1){%><span style="color:red;font-weight: bolder;">用户名已经存在,<span><%}%><% if(cheak_phone==1){%><span style="color:red;font-weight: bolder;">一个手机号码只能注册一个账户,</span><%}%><% if(inquriyCount>7){%><span style="color:red;font-weight: bolder;">用户信息提交频繁</span><%}%>
							<a href="javascript:history.back();" class="blue14">点击此处返回</a>。<%
								}
							%>
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
				<div class="renarrow">
					会员介绍
				</div>
			</div>
			<div class="centertext">
				<div class="centertext1">
					<div class="centertext2">
						<a href="http://www.21-sun.com/service/huiyuan/member_sj.htm"
							class="b14" target="_blank">VIP会员</a>
						<br />
						·市场调研服务
						<br />
						·新闻采访服务
						<br />
						·市场支持服务
						<br />
						·品牌宣传服务
					</div>
					<div class="centertext3">
						<a href="http://www.21-sun.com/service/huiyuan/member_vip.htm"
							target="_blank">查看详情</a>
					</div>
				</div>
				<div class="centertext1">
					<div class="centertext2">
						<a href="http://www.21-sun.com/service/huiyuan/member_a.htm"
							class="b14" target="_blank">A类会员</a>
						<br />
						·网站制作服务
						<br />
						·信息支持服务
						<br />
						·广告服务支持
						<br />
						<br />
					</div>
					<div class="centertext3">
						<a href="http://www.21-sun.com/service/huiyuan/member_a.htm"
							target="_blank">查看详情</a>
					</div>
				</div>

				<div class="centertext1">
					<div class="centertext2">
						<a href="http://www.21-sun.com/service/huiyuan/member_zl.htm"
							class="b14" target="_blank">租赁通会员</a>
						<br />
						·租赁信息排名靠前
						<br />
						·获得网上租赁店铺
						<br />
						·查看客户的留言回馈
						<br />
						·超值广告服务
					</div>
					<div class="centertext3">
						<a href="http://www.21-sun.com/rent/gg/huiyuan.htm"
							target="_blank">查看详情</a>
					</div>
				</div>
				<div class="centertext1_1">
					<div class="centertext2">
						<a href="http://www.21-cmjob.com/member/service/index.shtm"
							class="b14" target="_blank">人才网会员</a>
						<br />
						·金伯乐会员
						<br />
						·超级银伯乐会员
						<br />
						·银伯乐会员
						<br />
						<br />
					</div>
					<div class="centertext3">
						<a href="http://www.21-cmjob.com/member/service/index.shtm"
							target="_blank">查看详情</a>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="manage/foot.jsp" />
		<%
			if (isReg == 1) {
		%>

		<script language="javascript" type="text/javascript">


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
