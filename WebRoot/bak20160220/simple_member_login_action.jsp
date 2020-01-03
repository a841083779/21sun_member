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
if(isRandOK){

	//组装查询语句
	String querySql = "select * from member_info where mem_no=? and passw=?";
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
				
					String loginCity = Common.getAddressForIp(request,Common.getRemoteAddr(request,1),1);
					String province="";
					String city="";
					
					String [][]provinces = (String[][])application.getAttribute("provinces");
					String [][]citys = (String[][])application.getAttribute("citys");
					
					for(int i=0;provinces!=null && i<provinces.length;i++){
						//System.out.println(provinces[i][0]);
						if(loginCity.indexOf(provinces[i][0])!=-1){
							province=provinces[i][0];
						}
					}
					session.setAttribute("province",province);
					for(int i=0;citys!=null && i<citys.length;i++){
						//System.out.println(provinces[i][0]);
						if(loginCity.indexOf(citys[i][0])!=-1){
							city=citys[i][0];
						}
					}
					session.setAttribute("city",city);					
					String uptSql = "update member_info set login_last_city='"+loginCity+"',login_last_ip='"+ Common.getRemoteAddr(request,1) + "',login_last_date='"+ Common.getToday("yyyy-MM-dd HH:mm:ss", 0)+ "' where id=" + mid + "";
				
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

if(isLogon==1){
String keyPar = memNo+"--"+passw+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0);
keyPar = Common.encryptionByDES(keyPar);
%>	
<!--<script src="http://localhost:9121/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
<script src="http://localhost:9119/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>-->
<!--
<script src="http://part.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
<script src="http://market.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
<script src="http://used.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
<script src="http://rent.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
<script src="http://member.21-sun.com/sso/sso.jsp?key=<%=keyPar%>"  type="text/javascript"></script>
-->
<%}%>
<%if(isLogon==1){%><script type="text/javascript">window.location.href="http://localhost:9119/manage/membermain.jsp";</script> 
<%}else if(isLogon==-2){%><script type="text/javascript">alert("验证码不正确,请重新登录!");history.go(-1);</script>
<%}else if(isLogon==-3){%><script type="text/javascript">alert("用户名或密码不正确，请重新登录!");history.go(-1);</script>
<%}else if(isLogon==-1){%><script type="text/javascript">alert("您的用户已经被管理员禁用，请与我们客服联系，客服电话为：0535-6727765");history.go(-1);</script>
<%}%>