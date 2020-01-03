<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ include file ="/manage/config.jsp"%>
<%
	pool = new PoolManager(5);
	Connection conn = null;
	try{
	
		conn = pool.getConnection();
		int maxCount = 0;
		String today= Common.getToday("yyyy-MM-dd",0);
		String sql = " select count(*) from sell_buy_market where mem_no='"+(String)adminInfo.get("mem_no")+"' and convert(varchar(10),pub_date,21)='"+today+"' ";
		ResultSet rs = DataManager.executeQuery(conn,sql);
		
		if(rs!=null && rs.next()){
			maxCount = Integer.parseInt(Common.getFormatInt(rs.getString(1)));
		}
		out.println(maxCount);
	
	}catch(Exception e){
		Common.println(e);
	}finally{
		pool.freeConnection(conn);
	}
%>