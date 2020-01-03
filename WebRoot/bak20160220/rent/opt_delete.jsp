<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*,com.jerehnet.cmbol.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="/manage/config.jsp"%><% 
	
 PoolManager pool1 = new PoolManager(1);
 PoolManager pool3 = new PoolManager(3);
//=================
String myvalue =request.getParameter("myvalue");
myvalue=Common.decryptionByDES(myvalue);

String mypy =request.getParameter("mypy");

// ====保存日志====
//Common.saveLogs(pool, request, mypy, myvalue,"3",1,5);
//================================
//更新首页静态页面===
Connection conn =null;
String sql="";
 conn = pool1.getConnection();
String zd_mem_no ="",zd_class="";


String tempInfo[][]=null;

if(!Common.decryptionByDES(mypy).equals("rent_news")){
    tempInfo  =DataManager.fetchFieldValue(pool3,Common.decryptionByDES(mypy),"catalog_no,mem_no,class","id="+myvalue);
}else{
    tempInfo  =DataManager.fetchFieldValue(pool3,Common.decryptionByDES(mypy),"catalog_no,mem_no","id="+myvalue);
 }
 
int result =DataManager.deleteData(pool3,request,mypy,myvalue,2,7);
 
if(tempInfo!=null){
   // RentToHtml rentToHtml=new RentToHtml();
    //rentToHtml.indexAllHtml(request,pool3,Common.getFormatStr(tempInfo[0][0]));
    zd_mem_no     =  Common.getFormatStr(tempInfo[0][1]);	
	if(!Common.decryptionByDES(mypy).equals("rent_news")){
	  zd_class    =  Common.getFormatStr(tempInfo[0][2]);
	}
}

String tempInfo1[][]= null;
String  amount="0";
if(zd_class.equals("1")){
	tempInfo1=DataManager.fetchFieldValue(pool3,"rent_info","count(*)"," class=1 and mem_no='"+zd_mem_no+"'" );
	amount = Common.getFormatInt(tempInfo1[0][0]);
	
	sql="update member_info set rent_outcount='"+amount+"' from member_info where  mem_no='"+zd_mem_no+"'";
	DataManager.dataOperation(conn,sql);
}

if(result>0){
	out.print("1");
}else{
	out.print("0");
}

try{
 pool1.freeConnection(conn);
 }catch(Exception e){
   
 }
%>