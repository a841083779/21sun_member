<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%><%@ include
	file="/include/config.jsp"%>
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
	String referer = request.getHeader("referer");// 来自新浪或qq用户不需要验证码
	String addflag = Common.getFormatInt(request.getParameter("addflag")); //操作标识
	String reg_source = "0";
	//====根据addflag取出站点相应信息====
	String[][] tempSiteInfo = DataManager.fetchFieldValue(pool, "member_purview_new", "site_flag,css_num", "flag=1 and add_flag='" + addflag + "'");
	System.out.println(referer+"----") ; 
	if (tempSiteInfo != null && tempSiteInfo[0][0] != null) {
		reg_source = Common.getFormatInt(tempSiteInfo[0][0]);
	}

	String addIp = Common.getFormatStr(Common.getRemoteAddr(request, 1));
	String addDate = Common.getFormatStr(Common.getToday("yyyy-MM-dd HH:mm:ss", 0));
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
	String sina_id = Common.getFormatStr(request.getParameter("sina_id")); //新浪微博用户登录 id
	String qq_id = Common.getFormatStr(request.getParameter("qq_id"));
	boolean strIsNotNull = false;

	if (addIp.length() > 5 && addDate.length() > 10 && memNo.length() >= 4 && passw.length() >= 4) {
		strIsNotNull = true;
	}

	//验证码处理
	String rand = Common.getFormatStr(request.getParameter("rand"));
	String randSession = Common.getFormatStr((String) session.getAttribute("loginRand"));
	boolean isRandOK = false;
	if (rand.equals(randSession)) {
		isRandOK = true;
	}
	if ((isRandOK && strIsNotNull)|| referer.indexOf("openplatform/member_reg.jsp") != -1) {
		//组装INSERT语句
		String insSql = "insert into member_info(add_ip,add_date,mem_no,mem_name,passw,passw_question,passw_answer,per_sex,per_phone,per_email,per_province,per_city,regi_ip,regi_city,regi_date,state,mem_flag,mem_flag_name,login_count,flag_job,flag_bbs,flag_blog,flag_space,flag_21part,comp_name,comp_address,comp_intro,reg_source,mem_flag_enddate,sina_id,qq_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		/*System.out.println("insert into member_info(add_ip,add_date,mem_no,mem_name,passw,passw_question,passw_answer,per_sex,per_phone,per_email,per_province,"+"per_city,regi_ip,regi_city,regi_date,state,mem_flag,mem_flag_name,login_count,flag_job,flag_bbs,flag_blog,flag_space,flag_21part,comp_name,comp_address,comp_intro)"+"values('"+addIp+"','"+addDate+"','"+memNo+"','"+memName+"','"+passw+"','"+passwQuestion+"','"+passwAnswer+"','"+perSex+"','"+perPhone+"','"+perEmail+"','"+perProvince+"','"+perCity+"','"+Common.getRemoteAddr(request,1)+"','"+regCity+"','"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0)+"',1,'-1','普通会员','1','0','0','0','0','0','"+comp_name+"','"+comp_address+"','"+comp_intro+"')");
		 */
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
			
			if(referer.indexOf("openplatform/member_reg.jsp") != -1){
				pstmt.setString(16, "1");   // state 如果为邦定帐号 ，则state=1
			}else{
				pstmt.setString(16, "0");   // state 如果不为邦定帐号 ，则state=0
			}
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
			pstmt.executeUpdate();
			pstmt = null;

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("login -1 -1 -1");
			isReg = -1;
		} finally {
			pool.freeConnection(conn);
		}
	} else {
		System.out.println("login -2 -2 -2 验证码错误");
		isReg = -2;
	}
	if (!strIsNotNull) {
		isReg = -1;
	}

	String keyPar = ((String) memberInfo.get("mem_no")) + "--" + ((String) memberInfo.get("passw")) + "--" + Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
	keyPar = Common.encryptionByDES(keyPar);
	
	if (isReg == 1 && referer.indexOf("openplatform/member_reg.jsp") != -1) { 

		String querySql = "select top 1 * from member_info where 1=1";
		if(!"".equals(sina_id)){
			querySql += " and sina_id=? " ;
		}
		if(!"".equals(qq_id)){
			querySql += " and qq_id=? " ;
		}
		try{
			conn = pool.getConnection();
			pstmt = conn.prepareStatement(querySql);
			if(!"".equals(sina_id)){
				pstmt.setString(1, sina_id);
			}
			if(!"".equals(qq_id)){
				pstmt.setString(1, qq_id);
			}
			rs = pstmt.executeQuery();
			if (rs != null && rs.next()) {
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
						String ip=Common.getRemoteAddr(request,1);
						String loginCity = Common.getAddressForIp(request,Common.getRemoteAddr(request,1),1);  //   根据ip 获得地址
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
					} 
			}	
		}catch(Exception e){e.printStackTrace();}
		finally{
			pool.freeConnection(conn);
		}
	response.sendRedirect("/manage/memberhome.jsp") ;
	}else{
		response.sendRedirect("/") ;
	}
%>
