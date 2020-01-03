<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%>
<%@ include file ="../manage/config.jsp"%>
<%
	pool = new PoolManager(9);
	Connection conn =null;
	try{
		conn = pool.getConnection();
		String []delValues = request.getParameterValues("checkdel");
		String flag = Common.getFormatStr(request.getParameter("flag"));
		String tableName = Common.getFormatStr(request.getParameter("tableName"));
		String updateSql = "";
		for(int i = 0;delValues!=null && i < delValues.length; i++){
			if(flag.equals("0")){//删除
				updateSql = " delete from "+tableName+" where id = '"+delValues[i]+"' "; 
			}else{//设置、取消推荐
				updateSql = " update "+tableName+" set is_rec = '"+flag+"' where id = '"+delValues[i]+"' "; 
			}
			DataManager.dataOperation(conn,updateSql);
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
%>
<script language="javascript" type="text/javascript">
	window.parent.location.reload();
</script>