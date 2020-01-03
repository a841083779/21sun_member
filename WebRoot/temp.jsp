<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="org.apache.commons.httpclient.params.HttpMethodParams"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.sun.mail.iap.Response"%>
<%@page import="com.jerehnet.util.common.CommonString"%><%@ include
	file="include/config.jsp"%>
<%

	if (pool == null) {
		pool = new PoolManager();
	}
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ResultSetMetaData rsmd = null;
	HashMap memberInfo = new HashMap();
	int isReg = 1;

	String addIp = Common.getFormatStr(Common.getRemoteAddr(request, 1));
	String addDate = Common.getFormatStr(Common.getToday("yyyy-MM-dd HH:mm:ss", 0));
	String memNo = Common.getFormatStr(request.getParameter("mem_no"));
	String memName = Common.getFormatStr(request.getParameter("mem_name"));
	String password_bak = Common.getFormatStr(request.getParameter("passw"));
	String passw = DesEncrypt.MD5(password_bak);  
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
	String sina_id = Common.getFormatStr(request.getParameter("sina_id")); //新浪微博用户登录 id
	String qq_id = Common.getFormatStr(request.getParameter("qq_id"));
	String purpose = Common.getFormatStr(request.getParameter("purpose"));


			//组装INSERT语句
			String insSql = "insert into member_info(add_ip,add_date,mem_no,mem_name,passw,passw_question,passw_answer,per_sex,per_phone,per_email,per_province,per_city,regi_ip,regi_city,regi_date,state,mem_flag,mem_flag_name,login_count,flag_job,flag_bbs,flag_blog,flag_space,flag_21part,comp_name,comp_address,comp_intro,reg_source,mem_flag_enddate,sina_id,qq_id,purpose,password_bak) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			String aa=("insert into member_info(add_ip,add_date,mem_no,mem_name,passw,passw_question,passw_answer,per_sex,per_phone,per_email,per_province,"+"per_city,regi_ip,regi_city,regi_date,state,mem_flag,mem_flag_name,login_count,flag_job,flag_bbs,flag_blog,flag_space,flag_21part,comp_name,comp_address,comp_intro)"+"values('"+addIp+"','"+addDate+"','"+memNo+"','"+memName+"','"+passw+"','"+passwQuestion+"','"+passwAnswer+"','"+perSex+"','"+perPhone+"','"+perEmail+"','"+perProvince+"','"+perCity+"','"+Common.getRemoteAddr(request,1)+"','"+regCity+"','"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0)+"',1,'-1','普通会员','1','0','0','0','0','0','"+comp_name+"','"+comp_address+"','"+comp_intro+"')");

			try {
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
				pstmt.setString(13, Common.getRemoteAddr(request, 1));
				pstmt.setString(14, regCity);
				pstmt.setString(15, Common.getToday("yyyy-MM-dd HH:mm:ss", 0));
				
				//edit at 20130416
				//if(referer.indexOf("openplatform/member_reg.jsp") != -1){
					pstmt.setString(16, "1");   // state 如果为邦定帐号 ，则state=1
				//}else{
				//	pstmt.setString(16, "0");   // state 如果不为邦定帐号 ，则state=0
				//}
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
				pstmt.setString(30, sina_id);
				pstmt.setString(31, qq_id);
				pstmt.setString(32, purpose);
				pstmt.setString(33, password_bak);
				pstmt.executeUpdate();
				pstmt = null;
			method.releaseConnection();


			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(conn);
			}

%>

