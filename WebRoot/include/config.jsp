<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%><jsp:useBean id="pool" scope="application" class="com.jerehnet.cmbol.database.PoolManager"/>
<%HashMap adminInfo = (HashMap) session.getAttribute("memberInfo");
String usern="";
String realname="";
if(adminInfo!=null&&adminInfo.get("mem_no")!=null){
	usern = (String)adminInfo.get("mem_no");
}
if(adminInfo!=null&&adminInfo.get("mem_name")!=null){
	realname = (String)adminInfo.get("mem_name");
}
//====加密处理======

//=================

DecimalFormat df = new DecimalFormat("########.00");

//====统一网站地址==============================================================================================
//====日期显示效果=====
SimpleDateFormat dateformat = new SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
SimpleDateFormat dateformat1 = new SimpleDateFormat(
				"yyyy-MM-dd");
				
//=====每页显示的条数===
int PAGESIZE =15;%>