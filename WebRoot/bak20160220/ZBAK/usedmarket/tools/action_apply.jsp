<%@ page language="java" import="java.util.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.Connection" pageEncoding="UTF-8"%><%
	PoolManager usedPool = new PoolManager(4);
	Connection connection = null;
	String rs = "fail";
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String url = request.getRequestURI();
	if (url.indexOf("webadmin") == -1 && DataManager.filterKeyWords(request)) {
		rs = "fail";
	}else{
		String uuid = UUID.randomUUID().toString();
		String sql = " INSERT INTO dbo.used_apply_member (add_user, add_date, add_ip, uuid, mem_no, mem_name, mem_email, mem_contact, intro, apply_mem_flag, apply_date) ";
		sql += " VALUES ('admin','"+Common.getToday("yyyy-MM-dd HH:mm:ss")+"','"+request.getRemoteAddr()+"' , ";
		sql += " '"+uuid+"' , '"+Common.getFormatStr(memberInfo.get("mem_no"))+"' , '"+Common.getFormatStr(request.getParameter("name"))+"' , ";
		sql += " '"+Common.getFormatStr(request.getParameter("email"))+"' , ";
		sql += " '"+Common.getFormatStr(request.getParameter("contact"))+"' , ";
		sql += " '"+Common.getFormatStr(request.getParameter("intro"))+"' , ";
		sql += " '"+Common.getFormatStr(memberInfo.get("mem_flag"))+"' , ";
		sql += " '"+Common.getToday("yyyy-MM-dd HH:mm:ss")+"' ";
		sql += " ) ";
		try{
			connection = usedPool.getConnection();
			if(DataManager.dataOperation(connection,sql)>0){
				rs = "ok";
			}
		}catch(Exception e){
			
		}finally{
			usedPool.freeConnection(connection);		
		}
	}
	out.print(rs);
%>