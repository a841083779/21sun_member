<%@ page language="java" import="org.json.JSONObject,java.sql.ResultSetMetaData,java.sql.Connection,java.util.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.ResultSet" pageEncoding="UTF-8"%><%
	PoolManager poolManager = new PoolManager();
	String mem_no = Common.getFormatStr(request.getParameter("mem_no"));
	String password = Common.getFormatStr(request.getParameter("password"));
	password = DesEncrypt.MD5(password);
	String callback = Common.getFormatStr(request.getParameter("callback"));
	String isback = Common.getFormatStr(request.getParameter("isback"));
	Connection connection = null;
	ResultSet rs = null;
	try {
		connection = poolManager.getConnection();
		String sql = " select top 1 * from vi_member_info where mem_no= '"+mem_no+"' and passw = '"+password+"' and state = 1 ";
		rs = DataManager.executeQuery(connection, sql);
		Map memberInfo = new HashMap();
		JSONObject obj = new JSONObject();
		if(null!=rs&&rs.next()){
			ResultSetMetaData rsmd = rs.getMetaData();
			for (int i = 1; i <= rsmd.getColumnCount(); i++) {
			   memberInfo.put(rsmd.getColumnName(i), Common.getFormatStr(rs.getString(rsmd.getColumnName(i))));
			}
			session.setAttribute("memberInfo",memberInfo);
			obj = new JSONObject(memberInfo);
		}
		if(!"".equals(callback)){
			out.print(callback+"("+obj.toString()+")");
		}else{
			if(isback.equals("true")){
				response.sendRedirect(request.getHeader("Referer"));
				return;
			}else{
				response.sendRedirect("/");
				return;
			}
		}
	} catch (Exception e) {
		
	} finally {
		poolManager.freeConnection(connection);
	}
%>