<%@ page language="java" import="java.util.*,com.jerehnet.util.Common,com.jerehnet.cmbol.database.*,java.sql.Connection" pageEncoding="UTF-8"%><%
	String rs = "fail";
	String flag = Common.getFormatStr(request.getParameter("flag"));
	PoolManager usedPool = new PoolManager(4);
	Connection connection = null;
	String uuid = Common.getFormatStr(request.getParameter("uuid"));
	String sql = "";
	try{
		connection = usedPool.getConnection();
		if(flag.equals("sell_one")){
			sql = " update used_sell set pub_date = '"+Common.getToday("yyyy-MM-dd HH:mm:ss")+"' where uuid = '"+uuid+"' ";
			if(DataManager.dataOperation(connection,sql)>0){
				rs = "ok";
			}
		}
		if(flag.equals("buy_one")){
			sql = " update used_buy set pub_date = '"+Common.getToday("yyyy-MM-dd HH:mm:ss")+"' where uuid = '"+uuid+"' ";
			if(DataManager.dataOperation(connection,sql)>0){
				rs = "ok";
			}
		}
		if(flag.equals("sell")){
			String [] uuidArr = uuid.split(",");
			String idStr = "";
			for(int i=0;i<uuidArr.length;i++){
				idStr += "'"+uuidArr[i]+"'";
				if(i<(uuidArr.length-1)){
					idStr+=",";
				}
			}
			sql = " update used_sell set pub_date = '"+Common.getToday("yyyy-MM-dd HH:mm:ss")+"' where uuid in ("+idStr+")  ";
			if(DataManager.dataOperation(connection,sql)>0){
				rs = "ok";
			}
		}
		if(flag.equals("buy")){
			String [] uuidArr = uuid.split(",");
			String idStr = "";
			for(int i=0;i<uuidArr.length;i++){
				idStr += "'"+uuidArr[i]+"'";
				if(i<(uuidArr.length-1)){
					idStr+=",";
				}
			}
			sql = " update used_buy set pub_date = '"+Common.getToday("yyyy-MM-dd HH:mm:ss")+"' where uuid in ("+idStr+")  ";
			if(DataManager.dataOperation(connection,sql)>0){
				rs = "ok";
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		usedPool.freeConnection(connection);		
	}
	out.print(rs);
%>