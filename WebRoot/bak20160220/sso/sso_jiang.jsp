<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
	%><% 

response.setHeader("P3P","CP=CAO PSA OUR");
String lottery = "";
String count = "";
	
String key = Common.getFormatStr(request.getParameter("key"));
//key = Common.decryptionByDES(key);
String keys[] = key.split("--");
if(keys!=null && keys.length==2){
	lottery=keys[0];
	count=keys[1];
}
//System.out.println("key==="+key);
Common.createCookie(response,"lottery",lottery,(100*24*60*60));
Common.createCookie(response,"count",count,(100*24*60*60));

//Common.createCookie(response,"test2","dddddddddddddddddd",(24*60*60));
//System.out.println("aaaaaaaaa---lottery---aaaaaaaaaa:"+lottery);
%>