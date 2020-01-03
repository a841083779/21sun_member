<%@page contentType="text/html;charset=utf-8"import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="/manage/config.jsp"%>
	<% 
//===调租赁库====
PoolManager pool4 = new PoolManager(4);

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
//=====生成静态页的相关控制===
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
String zd_category=Common.getFormatStr(request.getParameter("zd_category"));

//====得到myvalue的值====
String myvalue=Common.getFormatInt(request.getParameter("myvalue"));
String tempInfo[][]=null;

//=============
int result = 0;
RentToHtml rentToHtml=new RentToHtml();
//=myflag 等于2表示删除,更新首页文件===
String myflag=Common.getFormatInt(request.getParameter("myflag"));
try{//====不是删除时的操作=====
   if(!myflag.equals("2"))
 {result =DataManager.dataInsUpt(request, pool4, mypy,2,7);
	 //====单个文件生成====
	if(myvalue.equals("0"))
      {tempInfo=DataManager.fetchFieldValue(pool4,Common.decryptionByDES(mypy),"max(id)", " catalog_no='" + zd_catalog_no + "'");
        if(tempInfo!=null&&tempInfo[0][0]!=null)
         {myvalue=Common.getFormatInt(tempInfo[0][0]);}
     } 
	rentToHtml.singleToHtml(pool4,request,zd_catalog_no,myvalue);
	//==================
 }
    //=====生成静态页====
	rentToHtml.indexList(request,pool4,zd_catalog_no,zd_category);
	
		
	if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
	//window.document.location.reload();
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
	urlpath=null;
	mypy=null;
	zd_catalog_no=null;
	myvalue=null;
	rentToHtml=null;
}	
%>