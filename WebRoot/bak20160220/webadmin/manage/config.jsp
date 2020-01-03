<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%><jsp:useBean id="pool" scope="application" class="com.jerehnet.cmbol.database.PoolManager"/><%HashMap adminInfo = (HashMap) session.getAttribute("adminInfo");
String usern="";
String realname="";
String admin_mem_flag="";
String admin_passw="";
if (adminInfo == null||adminInfo.get("type")==null)
out.print("<script>parent.location.href='/webadmin/21sunlogin.jsp';</script>");
else if (adminInfo != null&&adminInfo.get("type")!=null&&!adminInfo.get("type").equals("3"))
out.print("<script>alert('您没有相应的权限，请退出重新登录!');parent.location.href='/webadmin/21sunlogin.jsp';</script>");
else
{
	usern=Common.getFormatStr((String)adminInfo.get("usern"));
	realname=Common.getFormatStr((String)adminInfo.get("realname"));
	admin_mem_flag=Common.getFormatStr((String)adminInfo.get("mem_flag"));
	admin_passw=Common.getFormatStr((String)adminInfo.get("passw"));
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