<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*"%>
<%@ include file ="/manage/config.jsp"%>
<% 
	if(pool==null){
		pool = new PoolManager();
	}
	String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
	String mypy=Common.getFormatStr(request.getParameter("mypy"));
	String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
	String zd_sort_num=Common.getFormatStr(request.getParameter("zd_sort_num"));
	String myvalue=Common.getFormatInt(request.getParameter("myvalue"));
	String manage=Common.getFormatStr(request.getParameter("manage"));
	String tempInfo[][]=null;
	int result = 0;
	TechToHtml techToHtml=new TechToHtml();
	//myflag 等于2表示删除,更新首页文件
	String myflag=Common.getFormatInt(request.getParameter("myflag"));
	try{//不是删除时的操作
	   if(!myflag.equals("2")){
		   if(!"manage".equals(manage)){
			   result =DataManager.dataInsUpt(request, pool, mypy,2,7);
			   mypy = Common.decryptionByDES(mypy) ;
		   }
		 //单个文件生成
	 	if(myvalue.equals("0") || "manage".equals(manage)){
	 		tempInfo=DataManager.fetchFieldValue(pool,mypy,"max(id)", " catalog_no='" + zd_catalog_no + "'");
	        if(tempInfo!=null&&tempInfo[0][0]!=null){
	        	myvalue=Common.getFormatInt(tempInfo[0][0]);
	        	}
	     } 
		techToHtml.singleToHtml(pool,request,zd_catalog_no,myvalue);
	 }
	    // 生成静态页
		techToHtml.indexList(request,pool,zd_catalog_no,zd_sort_num);
		if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
	window.document.location.href='<%=urlpath%>';
	}catch(e){}	
	</script>
	<%}else{%>
	<script>
		alert("操作失败！");
		history.back();
	</script>
<%
	}	
}catch(Exception e){
	e.printStackTrace();
}finally{
	urlpath=null;mypy=null;zd_catalog_no=null;myvalue=null;techToHtml=null;
}	
%>