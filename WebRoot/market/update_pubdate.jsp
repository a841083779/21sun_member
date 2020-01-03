<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*" errorPage=""%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="java.util.Date"%><%
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
String per_phone = "";
String mem_flag = "";
String mem_flag_enddate = "" ; // 会员到期日期
String mem_no = "";
if(session.getAttribute("memberInfo")!=null){ 
	per_phone   = Common.getFormatStr(memberInfo.get("per_phone"));    //电话
	mem_flag   = Common.getFormatStr(memberInfo.get("mem_flag"));    //会员类别
	mem_no = Common.getFormatStr(memberInfo.get("mem_no"));
	boolean endTime = false ;   
	String nowdate=CommonDate.getToday("yyyy-MM-dd") ;
	mem_flag_enddate = CommonString.getFormatPara(memberInfo.get("mem_flag_enddate")) ;
	if(mem_flag_enddate.length()>=10){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(mem_flag_enddate);  // 过期日期
		endTime = d.before(sdf.parse(nowdate)); 
	}
	if(endTime){ // 如果到期 则改成普通会员 
		mem_flag = "-1" ;
	}
}
PoolManager pool5= new PoolManager(5);
String tablename="";
String id="";
String sql="";
String urlpath="";
String description ="";
 
try{
   
	tablename=Common.decryptionByDES(Common.getFormatStr(request.getParameter("mypy")));
	id=Common.decryptionByDES(Common.getFormatStr(request.getParameter("myvalue")));
	urlpath = Common.getFormatStr(request.getParameter("urlpath"));
	
	//判断是否可以更新--免费会员每天只能更新20条--begin
	String isUpdate = "no";
	int totalCount = 20;//限制总数为20条
	if(mem_flag.equals("1003")){
		isUpdate = "ok";
	}else{
		int cookie_count = Common.getMarketCookie(request,mem_no);
		if(totalCount-cookie_count>0){
			Common.setMarketCookie(response,mem_no,cookie_count+1);
			isUpdate = "ok";
		}
	}
	//判断是否可以更新--免费会员每天只能更新20条--end
	if(isUpdate.equals("ok")){
		sql="update "+tablename+" set pub_date=getdate(),tel='"+per_phone+"',mem_flag='"+mem_flag+"',orderno=replace(replace(replace(left(convert(varchar(30),getdate(),21),19),'-',''),':',''),' ','') where id='"+id+"'";
		DataManager.dataOperation(pool5,sql);
		description="信息成功更新！";
	}else{
		description = "尊敬的会员，您好：您的会员级别每天限更新20条数据，您今天更新条数已达上限，请明天继续使用，谢谢!";
	}
	

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script src="/scripts/jquery-1.4.1.min.js"></script>
<script type="text/javascript">
<% if(isUpdate.equals("ok") && !id.equals("")){ %>
	updateSellData("<%=id %>");
<% }%>
alert('<%=description%>');
try{
	setTimeout('goBack()', 100);
}catch(e){}	

function goBack(){
	window.document.location.href='<%=urlpath%>';
}
function updateSellData(ids){
	jQuery.ajax({
		type: "POST",
		url: "/tools/ajax.jsp",
		cache: false,
		data: "flag=updateSellData&ids="+ids,
		success:function(msg){
			if(jQuery.trim(msg)=='1'){
				//alert(msg);
			}
		}
	}) ;
}
</script>
</head>
<body></body>
</html>
<%
}catch(Exception ex)
{;}
finally{
	tablename=null;
	id=null;
	sql=null;
}
%>