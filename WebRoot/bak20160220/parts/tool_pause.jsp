<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%>
<%@ include file ="../manage/config.jsp"%>
<%
	PoolManager pool7 = new PoolManager(7);
	 Connection conn =null;
    
	String description="";
	
	String []delValues = request.getParameterValues("checkdel");
	String tablename =  Common.decryptionByDES(Common.getFormatStr(request.getParameter("tablename")));

try{conn = pool7.getConnection();
    
	String updateSql = "";
			
	
		for(int i = 0;delValues!=null && i < delValues.length; i++){
			   if(tablename.equals("supply_partstore")){
				     updateSql = " update "+tablename+" set is_pub=2 where id = '"+delValues[i]+"' "; }
			   else if(tablename.equals("supply")){
				     updateSql = " update "+tablename+" set is_pause=1 where id = '"+delValues[i]+"' "; }
			   else{
				     updateSql = " update "+tablename+" set is_pub=0 where id = '"+delValues[i]+"'";
				   }
		  DataManager.dataOperation(conn,updateSql);  
			}
		
		description="批量暂停信息成功！"; //更新成功XX条信息
		

		
}catch(Exception e){
		e.printStackTrace();
	}finally{
		pool.freeConnection(conn);
	}
%>
<script language="javascript" type="text/javascript">
	alert('<%=description%>');
	window.parent.location.reload();
</script>