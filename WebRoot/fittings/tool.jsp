<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%>
	<%
		PoolManager pool = new PoolManager(9);
		String tableName = Common.getFormatStr(request.getParameter("tableName"));
		String flag = Common.getFormatStr(request.getParameter("flag"));
		String id = Common.getFormatStr(request.getParameter("id"));
		String []ids = id.split(",,");
		String updateSql = "";
		if(flag.equals("1")){//更新
			for(int i=0;ids!=null && i<ids.length;i++){
				updateSql = " update "+tableName+" set update_date = '"+Common.getToday("yyyy-MM-dd HH:mm:ss",0)+"' where id = '"+Common.decryptionByDES(ids[i])+"' ";
				DataManager.dataOperation(pool,updateSql);
			}
		}else if(flag.equals("2")){//暂停
			for(int i=0;ids!=null && i<ids.length;i++){
				updateSql = " update "+tableName+" set is_show = 0 where id = '"+Common.decryptionByDES(ids[i])+"' ";
				DataManager.dataOperation(pool,updateSql);
			}
		}else if(flag.equals("3")){//显示
			for(int i=0;ids!=null && i<ids.length;i++){
				updateSql = " update "+tableName+" set is_show = 1 where id = '"+Common.decryptionByDES(ids[i])+"' ";
				DataManager.dataOperation(pool,updateSql);
			}
		}
		
	%>