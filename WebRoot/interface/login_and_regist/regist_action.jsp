<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><%@ include file ="/include/config.jsp"%><%
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
	passw = DesEncrypt.MD5(passw);
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
System.out.println(addIp+"--"+addDate+"--"+memNo+"--"+passw+"--");

//验证码处理
String rand = Common.getFormatStr(request.getParameter("rand"));
String randSession = Common.getFormatStr((String)session.getAttribute("loginRand"));
boolean isRandOK = false;
if(rand.equals(randSession)){
	isRandOK = true;
}


System.out.println(rand+"--session equls--"+randSession+"--strIsNotNull="+strIsNotNull);
if(isRandOK && strIsNotNull){

	//组装INSERT语句
	String insSql = "insert into member_info(add_ip,add_date,mem_no,mem_name,passw,passw_question,passw_answer,per_sex,per_phone,per_email,per_province,per_city,regi_ip,regi_city,regi_date,state,mem_flag,mem_flag_name,login_count,flag_job,flag_bbs,flag_blog,flag_space,flag_21part,comp_name,comp_address,comp_intro,reg_source,mem_flag_enddate) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
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
		pstmt.setString(16, "1");
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
		String querySql = "select * from member_info where mem_no=? ";
		//System.out.println(querySql+"-"+memNo);
		pstmt = conn.prepareStatement(querySql);
		pstmt.setString(1, memNo);

		rs = pstmt.executeQuery();
		
		if (rs != null && rs.next()) {

			rsmd = rs.getMetaData();
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
				memberInfo.put(rsmd.getColumnName(i), rs.getString(rsmd.getColumnName(i)));
				if(rsmd.getColumnName(i).equals("mem_flag_enddate")){
				}
			}
			session.setAttribute("memberInfo",memberInfo);
			String uptSql = "update member_info set login_last_city='"+regCity+"',login_last_ip='"+ Common.getRemoteAddr(request,1) + "',login_last_date='"+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0)+ "' where mem_no='" + usern + "'";
			DataManager.dataOperation(conn, uptSql);

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
if(!strIsNotNull){
	isReg = -1;
}

String keyPar = ((String)memberInfo.get("mem_no"))+"--"+((String)memberInfo.get("passw"))+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);
if(isReg==1){
	out.print(true);
}else{
	out.print(false);
}
%>