<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="../manage/config.jsp"%><% 
if(pool==null){
	pool = new PoolManager();
}
//=================
String myvalue =request.getParameter("myvalue");
myvalue=Common.decryptionByDES(myvalue);

String mypy =request.getParameter("mypy");

// ====保存日志====
//Common.saveLogs(pool, request, mypy, myvalue,"3",1,5);
//================================
//===调租赁库====
PoolManager pool3 = new PoolManager(3);
//更新首页静态页面===
//String tempInfo[][]=DataManager.fetchFieldValue(pool3,Common.decryptionByDES(mypy),"catalog_no","id="+myvalue);

int result =DataManager.deleteData(pool3,request,mypy,myvalue,2,7);

/*if(tempInfo!=null)
{RentToHtml rentToHtml=new RentToHtml();
rentToHtml.indexAllHtml(request,pool3,Common.getFormatStr(tempInfo[0][0]));
}*/
//=====
if(result>0){
	out.print("1");

}else{
	out.print("0");
}
%>