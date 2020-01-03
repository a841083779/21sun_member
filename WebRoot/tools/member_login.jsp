<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,java.io.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%>
<%
	PoolManager pool = null;
	pool = new PoolManager();
	String callback=request.getParameter("callback");
	String mem_no = Common.getFormatStr(request.getParameter("usern")); 	
	String passw = Common.getFormatStr(request.getParameter("passw")); 
	try{	
		String [][]member = DataManager.fetchFieldValue(pool,"member_info","id,mem_no,mem_name,per_sex,per_phone,per_email,comp_address,comp_postcode,comp_name"," mem_no='"+mem_no+"' and passw='"+passw+"' and state=1");
		String result="-1";
		if(member!=null && member.length>0){
			result=member[0][0]+","+member[0][1]+","+member[0][2]+","+member[0][3]+","+member[0][4]+","+member[0][5]+","+member[0][6]+","+member[0][7]+","+member[0][8];
		}
		out.print(callback+"({ status:'"+result+"'})");
	} catch (Exception e) {
		out.print(callback+"({ status:'-1'})");
	}
	%>
