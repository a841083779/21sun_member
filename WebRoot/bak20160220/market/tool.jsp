<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.*"
%><%@ include file ="../manage/config.jsp"%>
<%
	PoolManager pool5 = new PoolManager(5);
	Connection conn =null;
	pool = new PoolManager(1);

	String mem_no ="",mem_flag="";
	HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
	String per_phone = "";
	if(session.getAttribute("memberInfo")!=null){   
		mem_no     = String.valueOf(Common.getFormatStr(memberInfo.get("mem_no")));    //登陆账号
		mem_flag     = String.valueOf(Common.getFormatStr(memberInfo.get("mem_flag")));    //会员角色
		per_phone   = Common.getFormatStr(memberInfo.get("per_phone"));    //电话
	}	
	int UPDATETOTAL=50;//总的更新次数
	if(!mem_flag.equals("-1")){
		UPDATETOTAL=100;
	}

	int updateCount=0;
	String[][] tempInfo =null; //查询今天共更新了多少条记录	
	String description="";
	String isUpdate = "no"; 
	String ids = "";
	try{
		conn = pool5.getConnection();
		
		String []delValues = request.getParameterValues("checkdel");
		String tablename =  Common.decryptionByDES(Common.getFormatStr(request.getParameter("tablename")));
		
		tempInfo=DataManager.fetchFieldValue(pool,"member_updateinfo","updatenums","mem_no='"+mem_no+"' and tablename='"+tablename+"' and datediff(d,getdate(),update_date)=0");
		
		if(tempInfo!=null){
		   updateCount = Integer.parseInt(Common.getFormatInt(tempInfo[0][0])); //今天共更新次数
		}
		
		String updateSql = "";
		if((UPDATETOTAL-updateCount)>0){
			int leave_count = delValues.length;
			//判断是否可以更新--免费会员每天只能更新20条--begin
			int totalCount = 20;//限制总数为20条
			if(mem_flag.equals("1003")){
				isUpdate = "ok";
			}else{
				int cookie_count = Common.getMarketCookie(request,mem_no);
				if(totalCount-cookie_count-leave_count>0){
					Common.setMarketCookie(response,mem_no,cookie_count+leave_count);
					isUpdate = "ok";
				}else{
					leave_count = totalCount-cookie_count;
					Common.setMarketCookie(response,mem_no,totalCount);
				}
			}
			if(isUpdate.equals("ok")){
				description="批量更新信息成功！"; //更新成功XX条信息
			}else{
				description="尊敬的会员，您好：您的会员级别每天限更新20条数据，您今天更新条数已达上限，请明天继续使用，谢谢!";
			}
			//判断是否可以更新--免费会员每天只能更新20条--end
			for(int i = 0;delValues!=null && i < leave_count; i++){
			    updateSql = " update "+tablename+" set pub_date=getdate(),tel='"+per_phone+"',mem_flag='"+mem_flag+"',orderno=replace(replace(replace(left(convert(varchar(30),getdate(),21),19),'-',''),':',''),' ','')  where id = '"+delValues[i]+"' "; 
				DataManager.dataOperation(conn,updateSql);
				ids += delValues[i]+",";
			}
			//====更新次数=====
			if(updateCount==0)
			{
				updateSql="insert into member_updateinfo(mem_no,tablename,update_date,updatenums)values('"+mem_no+"','"+tablename+"',getdate(),1)";
			}else{
				updateSql="update member_updateinfo set updatenums=updatenums+1 where mem_no='"+mem_no+"' and tablename='"+tablename+"' and datediff(d,getdate(),update_date)=0 ";
			}
			DataManager.dataOperation(pool,updateSql);
		}else{
			description="已达到当日最多【"+UPDATETOTAL+"】次批量更新次数！"; 
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
			pool.freeConnection(conn);
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script src="../scripts/jquery-1.4.1.min.js"></script>
<script type="text/javascript">
<% if(isUpdate.equals("ok") && !ids.equals("")){ %>
	updateSellData("<%=ids %>");
<% }%>
alert('<%=description%>');
try{
	setTimeout('goLoad()', 100);
}catch(e){}	
function goLoad(){
	window.parent.location.reload();
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