<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,org.json.*"%>
<%@ include file ="/manage/config.jsp"%>
<%
	HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
	String zd_mem_no = Common.getFormatStr(request.getParameter("zd_mem_no"));
	String zd_mem_name  =  Common.getFormatStr(request.getParameter("zd_mem_name"));
	String zd_comp_name =  Common.getFormatStr(request.getParameter("zd_comp_name"));
	String zd_telephone =  Common.getFormatStr(request.getParameter("zd_telephone"));
	String zd_email     =  Common.getFormatStr(request.getParameter("zd_email"));
	String zd_content   =  Common.getFormatStr(request.getParameter("zd_content"));
	String zd_youhui_num   =  Common.getFormatStr(request.getParameter("zd_youhui_num"));
	if(zd_youhui_num.equals("")){
		zd_youhui_num = Common.getFormatStr(memberInfo.get("randNum"));	
	}
	String sql="";
	int result=0;
	
	String[][] tempInfo=null;
	try{			
		sql="insert into member_applyonline(mem_no,add_date,add_ip,mem_name,comp_name,telephone,email,content,apply_mem_flag,catalog_no,youhui_num)"+"values('"+zd_mem_no+"',getdate(),'"+Common.getRemoteAddr(request,1)+"','"+zd_mem_name+"','"+zd_comp_name+"','"+zd_telephone+"','"+zd_email+"','"+zd_content+"','1003','market','"+zd_youhui_num+"')";
		result=DataManager.dataOperation(pool,sql);
		if(result>0){
			out.print("1");
		}else{
		   out.print("0");
		}	
		//邮件发送
		String emailText = "";
		emailText += "【"+Common.getFormatStr(memberInfo.get("per_province"));
		if(!Common.getFormatStr(memberInfo.get("per_province")).equals(Common.getFormatStr(memberInfo.get("per_city")))){
			emailText += Common.getFormatStr(memberInfo.get("per_city"));
		}
		emailText += "】的";
		emailText += "【"+zd_mem_name + "】申请加入A类会员<br />";
		emailText += "邮箱是："+zd_email+"<br />";
		emailText += "电话是："+zd_telephone+"<br />";
		if(!Common.getFormatStr(memberInfo.get("comp_name")).equals("")){
			emailText += "公司是："+Common.getFormatStr(memberInfo.get("comp_name"))+"<br />";	
		}
		if(!zd_youhui_num.equals("")){
			//emailText += "优惠券号码："+zd_youhui_num+"<br />";	
		}
		emailText += "留言内容是："+zd_content+"<br />";
		HttpClient httpClient = new HttpClient();
		PostMethod postMethod = new PostMethod("http://service.21-sun.com/http/utils/sendmail.jsp");
		postMethod.getParams().setContentCharset("UTF-8");
		postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
		postMethod.addParameter("to","zhangchen@21-sun.com,zhenghj@21-sun.com");
		postMethod.addParameter("cc","zhuch@21-sun.com,wanggq@21-sun.com");
		postMethod.addParameter("title","A类会员加入申请");
		postMethod.addParameter("content",emailText);
		postMethod.addParameter("fixed","21sun");
		httpClient.executeMethod(postMethod);
			
	}catch(Exception e){
		e.printStackTrace();
	}
%>