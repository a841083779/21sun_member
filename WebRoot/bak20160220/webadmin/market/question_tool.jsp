<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%>
<%@ include file ="../manage/config.jsp"%>
<%
	pool = new PoolManager(5);
Connection conn =null;
try{
	conn = pool.getConnection();
	String []delValues = request.getParameterValues("checkdel");
	String flag = Common.getFormatStr(request.getParameter("flag"));
	String updateSql = "";
	for(int i = 0;delValues!=null && i < delValues.length; i++){
		if(flag.equals("0")){//删除
			updateSql = " delete from question where id = '"+delValues[i]+"' "; 
		}else{
			updateSql = " update question set posi = '"+flag+"' where id = '"+delValues[i]+"' "; 
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
	alert("操作成功！")
	window.parent.location.reload();
</script>