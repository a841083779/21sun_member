<%@page contentType="text/html;charset=utf-8"import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%>
	<% 
	PoolManager pool7 = new PoolManager(7);
	String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
	String mypy=Common.getFormatStr(request.getParameter("mypy"));

	int result = 0;
	try{
	   if(Common.getFormatInt(request.getParameter("rand")).equals(Common.getFormatInt((String)session.getAttribute("loginRand")))){	
       result =DataManager.dataInsUpt(request, pool7, mypy,2,0);	  
  }else{%>
		<script>
			alert("验证码不正确,请重新输入!");
		try{
			window.document.location.href='<%=urlpath%>';
					
		}catch(e){}	
		
		</script>
  <%}
	
	if(result>0){
%>
	<script>
		alert("发布求购信息成功！");
	try{	
	window.document.location.href='<%=urlpath%>';
	//parent.location.reload();	 
	}catch(e){}	
	
	</script>
	<%}else{%>
	<script>
		alert("操作失败！");
		history.back();
		//parent.location.reload();
	</script>
<%
	}	
}catch(Exception e){
	e.printStackTrace();
}finally{
	urlpath=null;
	mypy=null;
}	
%>