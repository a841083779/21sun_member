<%@ page language="java" import="com.jerehnet.cmbol.database.*,java.util.*,java.sql.Connection" pageEncoding="UTF-8"%><%
	PoolManager pool3 = new PoolManager(3);
	Connection conn = null;
	String flag = request.getParameter("flag");
	try {
		conn = pool3.getConnection();  //SQL查询	
		if("tuijian".equals(flag)){
			String id = request.getParameter("id");
			DataManager.dataOperation(conn," update equipment set is_recom = '"+request.getParameter("is_recom")+"' where id = '"+id+"' ");
		}
		if("xianshi".equals(flag)){
			String id = request.getParameter("id");
			DataManager.dataOperation(conn," update equipment set is_pub = '"+request.getParameter("is_pub")+"' where id = '"+id+"' ");
		}
		if("xianshi_rent_info".equals(flag)){
			String id = request.getParameter("id");
			DataManager.dataOperation(conn," update rent_info set is_pub = '"+request.getParameter("is_pub")+"' where id = '"+id+"' ");
		}
		if("tuijian_qiye".equals(flag)){
			String id = request.getParameter("id");
			DataManager.dataOperation(conn," update rent_company_info set comp_recom = '"+request.getParameter("is_recom")+"' where id = '"+id+"' ");
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool3.freeConnection(conn);
	}
%>