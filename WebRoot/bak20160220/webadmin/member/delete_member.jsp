<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="/manage/config.jsp"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
<%
if(pool==null){
	pool = new PoolManager();
}
//====得到参数====
int k=0;
String id=Common.getFormatInt(request.getParameter("id"));
String sql="";
try{//====标题的名称====
sql="delete from member_info where id="+id;
k=DataManager.dataOperation(pool,sql);
out.print(k);

}catch(Exception e){e.printStackTrace();}
finally{

}
%>
