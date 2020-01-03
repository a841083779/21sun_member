<%@ page language="java" import="java.net.*,com.jerehnet.cmbol.database.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*" pageEncoding="UTF-8"%><%
	//自动执行
	PoolManager poolManager = new PoolManager();
	try{
		//更新2012年12月01日之后的所有注册了3天没有完善资料的账号为禁用
		String sql = "";
		//sql = " update member_info set state = 0 ";
		//sql += " where ( per_phone is null or per_phone = '' ) and state = 1 ";
		//sql += " and add_date > '2012-12-01' and datediff(d,add_date,getdate()) >= 3 ";
		sql = " delete from member_info where ( per_phone is null or per_phone = '' ) and state = 1 "
		sql += " and add_date > '2012-12-01' and datediff(d,add_date,getdate()) >= 3 ";
		DataManager.executeSQL(poolManager,sql);
	}catch(Exception e){
		HttpClient httpClient = new HttpClient();
		GetMethod getMethod = new GetMethod("http://service.21-sun.com/http/utils/log.jsp?channelName="+URLEncoder.encode("会员","utf-8")+"&content="+URLEncoder.encode("3天未登录会员自动禁用失败","utf-8")+"&log_level=107002");
		getMethod.addRequestHeader("Referer",request.getRequestURL().toString());
		httpClient.executeMethod(getMethod);
	}
%>