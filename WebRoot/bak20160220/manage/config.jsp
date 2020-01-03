<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%><jsp:useBean id="pool" scope="application" class="com.jerehnet.cmbol.database.PoolManager"/>
<%HashMap adminInfo = (HashMap) session.getAttribute("memberInfo");
String usern="";
String realname="",qq="",email1="";
if(adminInfo!=null&&adminInfo.get("mem_no")!=null){
	usern = (String)adminInfo.get("mem_no");
}
if(adminInfo!=null&&adminInfo.get("mem_name")!=null){
	realname = (String)adminInfo.get("mem_name");
}
if(adminInfo!=null&&adminInfo.get("per_qq")!=null){
	qq = (String)adminInfo.get("per_qq");
}
if(adminInfo!=null&&adminInfo.get("per_email")!=null){
	email1 = (String)adminInfo.get("per_email");
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
int PAGESIZE =15;
String fittingsUrl = "http://www.21peitao.com";

//个人完善信息 url
//企业完善信息 url
String mem_type_url = "/manage/memberinfo_new.jsp";
if(adminInfo!=null&&adminInfo.get("mem_type")!=null){
	if(adminInfo.get("mem_type").equals("2")){
		mem_type_url = "/manage/memberinfo_new.jsp?controlflag=2";
	}
}
//检测用户是否完善了信息
String userInfoFlag = "1";
if (adminInfo!=null) {
	String mem_type = String.valueOf(adminInfo.get("mem_type")); //   用户类别：企业（1），个人（2）
	String comp_mode = Common.getFormatStr((String) adminInfo.get("comp_mode"));
	String per_phoneStr = Common.getFormatStr((String) adminInfo.get("per_phone"));
	String comp_phoneStr = Common.getFormatStr((String) adminInfo.get("comp_phone"));
	//企业用户
	if("1".equals(mem_type)){
		// 判断信息是否完善
		if ("".equals(per_phoneStr)||"".equals(comp_mode)) {
			userInfoFlag = "1";
		}else{
			userInfoFlag = "2";
		}
	}
	//个人用户
	if("2".equals(mem_type)){
		// 判断信息是否完善
		if ("".equals(per_phoneStr) && "".equals(comp_phoneStr)) {
			userInfoFlag = "1";
		}else{
			userInfoFlag = "2";
		}
	}
}
%>