<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,java.net.*,com.jerehnet.cmbol.action.*"
	%>
<%HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
	if(null==memberInfo){
		response.sendRedirect("/");
		return;
	}
	PoolManager pool = new PoolManager();
	PoolManager pool11 = new PoolManager(11);
	Connection conn = null;
	Connection conn11 = null;
	ResultSet rs = null;
	
	String membertype = Common.getFormatStr(request.getParameter("membertype"));
	String usern =Common.getFormatStr(memberInfo.get("mem_no"));
	String password =Common.getFormatStr(memberInfo.get("passw"));
	try{
	conn = pool.getConnection();
	conn11 = pool11.getConnection();
	//查询人才网中是否已存在
	ResultSet rs0 = DataManager.executeQuery(conn11,"select count(*) from parts_admin_user where usern='"+usern+"'");
	//System.out.print("usern:===="+usern);
	if(rs0.next()&&rs0.getInt(1)>0){
		%>
			<script>
				//alert("该帐号提交至杰配网，正在审核中，请稍后刷新再试！");
				window.parent.location.href="http://www.21part.com/storeadmin/fromotherlogin.jsp?Submit=1&tempusern=<%=Common.encryptionByDES(usern)%>&temppassw=<%=Common.encryptionByDES(password)%>";
				
				//window.close();
			</script>
		<%
	}else{
	
	String mainSql = " select add_ip,add_date,mem_no,mem_name,passw,per_sex,per_phone,per_email,per_province,per_city,state,mem_flag,mem_flag_name from member_info where mem_no='"+usern+"' and passw = '"+password+"' ";
	
		rs = DataManager.executeQuery(conn,mainSql);
		
		if(rs!=null && rs.next()){//插入到杰配网会员表
			String subSql = " insert into parts_admin_user(state,type,last_ip,add_date,usern,realname,passw,sex,telphone,email,province,city) values('1','"+membertype+"','"+Common.getFormatStr(rs.getString("add_ip"))+"','"+Common.getFormatStr(rs.getString("add_date"))+"','"+Common.getFormatStr(rs.getString("mem_no"))+"','"+Common.getFormatStr(rs.getString("mem_name"))+"','"+Common.getFormatStr(rs.getString("passw"))+"','"+rs.getString("per_sex")+"','"+Common.getFormatStr(rs.getString("per_phone"))+"','"+Common.getFormatStr(rs.getString("per_email"))+"','"+Common.getFormatStr(rs.getString("per_province"))+"','"+Common.getFormatStr(rs.getString("per_city"))+"') ";	  
			DataManager.dataOperation(conn11,subSql);
			
			/*ManageAction mAction2 = new ManageAction();
			int result = mAction2.adminLogon2(pool,request,Common.getFormatStr(rs.getString("mem_no")),Common.getFormatStr(rs.getString("passw")));
			
			if(result > 0){*/
			//更新会员站开通标识
			String updateSql = " update member_info set flag_21part = '1' where mem_no='"+usern+"' and passw = '"+password+"'  ";
			//System.out.println(updateSql);
			DataManager.dataOperation(conn,updateSql);
			%>
			 <%
	
	String keyPar = usern+"--"+password+"--"+Common.getToday("yyyy-MM-dd HH:mm:ss",0);
		
	keyPar = Common.encryptionByDES(keyPar);

%>
<script type="text/javascript" src="/scripts/jquery-1.4.1.min.js"></script>
<script type="text/javascript">
$.getJSON("http://www.21-part.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://market.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21-used.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21-rent.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://bbs.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://blog.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21part.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21-cmjob.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://space.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://member.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://data.21-sun.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
$.getJSON("http://www.21peitao.com/sso/sso.jsp?callback=?&key=<%=keyPar%>");
</script>

			
				<script>
					<%if(membertype.equals("2")){%>
					   window.parent.location.href="http://www.21part.com/storeadmin/fromotherlogin.jsp?Submit=1&tempusern=<%=Common.encryptionByDES(usern)%>&temppassw=<%=Common.encryptionByDES(password)%>";
					<%}else{%>
					  window.parent.location.href="http://www.21part.com/storeadmin/fromotherlogin.jsp?Submit=1&tempusern=<%=Common.encryptionByDES(usern)%>&temppassw=<%=Common.encryptionByDES(password)%>";
					<%}%>
				</script>
			<%
			//}
		//mAction2 = null;
		}else{
			%>
				<script language="javascript" type="text/javascript">
					alert("该通行证在会员商务室中不存在");
					window.parent.location.href="http://www.21part.com/storeadmin/login.jsp";
				</script>
			<%
		}
		}
	}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		pool.freeConnection(conn);
		pool11.freeConnection(conn11);
	}
	
%>
