<%@ page language="java" pageEncoding="UTF-8" import="com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.*" %>
<%
	PoolManager pool = (PoolManager)application.getAttribute("poolAPP");
	if(pool == null){
		pool = new PoolManager();
	}
	DataManager dataManager = new DataManager();
	
	Connection conn = null;
	ResultSet rs = null;
	String jiang = "";
	String jiang_new = "";
	String jiang_chuli = "";
	String jiang_chuli_new = "";
	int	result = 0;
	
	String id = Common.getFormatStr(request.getParameter("id"));
	String flag = Common.getFormatStr(request.getParameter("flag"));
	//out.println(id+"-1-"+flag);
	try{
		conn = pool.getConnection();
		String selQuery = "select jiang,ISNULL(jiang_chuli, '') as jiang_chuli from member_info where id ="+id;
		System.out.println(selQuery);
		rs = dataManager.executeQuery(conn,selQuery);
		while(rs.next()){
			jiang = Common.getFormatStr(rs.getString("jiang"));
			jiang_chuli = Common.getFormatStr(rs.getString("jiang_chuli"));
			if(!jiang.equals("") && jiang!=null){
				//从jiang中减去
				jiang_new = jiang.replaceFirst(flag,"");
				//jiang_chuli加上
				if(jiang_chuli.equals("")){
					jiang_chuli_new = flag;
				}else{
					jiang_chuli_new = jiang_chuli+","+flag;
				}
				//处理全是逗号的情况
				int count = jiang_new.length();
				String tempFlag = "";
				for(int i=0;i<count;i++){
					tempFlag = tempFlag + ",";					
				}
				if(jiang_new.equals(tempFlag)){
					jiang_new = "";
				}
				//更新jiang,jiang_chuli
				String upQuery = "update member_info set jiang='"+jiang_new+"',jiang_chuli=',"+jiang_chuli_new+",' where id="+id;
				result = DataManager.dataOperation(conn,upQuery);
				System.out.println(upQuery);
				if(result!=0){
					out.println("ok");
				}else{
					out.println("error");
				}
			}
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
	
%>