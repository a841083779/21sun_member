<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><% 

response.setHeader("P3P","CP=CAO PSA OUR");
String memNo = "";
String passw = "";
String crDate = "";
	
String key = Common.getFormatStr(request.getParameter("key"));
key = Common.decryptionByDES(key);
//System.out.println("key==="+key);
String keys[] = key.split("--");
if(keys!=null && keys.length==3){
	crDate=keys[2];
	memNo=keys[0];
	passw=keys[1];
}
//System.out.println("memNo==="+memNo);
Common.createCookie(response,"cookieMemNo",Common.encryptionByDES(memNo),(6*60*60));
Common.createCookie(response,"cookiePassw",Common.encryptionByDES(passw),(6*60*60));
Common.createCookie(response,"cookieCreatTime",Common.encryptionByDES(crDate),(6*60*60));

//Common.createCookie(response,"test2","dddddddddddddddddd",(24*60*60));
System.out.println("aaaaaaaaaaaaaaaaaaa");
%>