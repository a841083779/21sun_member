<%@ page language="java" import="java.sql.Connection,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,java.sql.ResultSet" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="org.apache.commons.httpclient.params.HttpMethodParams"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%
PoolManager poolManager = new PoolManager();
Connection connection = null;
try {
	connection = poolManager.getConnection();
	String sql = " insert into member_applyonline ( mem_no , add_date , add_ip , mem_name , comp_name , telephone , email , content , apply_mem_flag , catalog_no ) ";
	sql += " values ( ";
	sql += " '"+Common.getFormatStr(request.getParameter("mem_no"))+"' ";
	sql += " , '"+Common.getToday("yyyy-MM-dd HH:mm:ss")+"' , '"+request.getRemoteAddr()+"' ";
	sql += " , '"+Common.getFormatStr(request.getParameter("mem_name"))+"' , '"+Common.getFormatStr(request.getParameter("comp_name"))+"' ";
	sql += " , '"+Common.getFormatStr(request.getParameter("telephone"))+"' , '"+Common.getFormatStr(request.getParameter("email"))+"' ";
	sql += " , '"+Common.getFormatStr(request.getParameter("content"))+"' , '"+Common.getFormatStr(request.getParameter("apply_mem_flag"))+"' ";
	sql += " , '"+Common.getFormatStr(request.getParameter("catalog_no"))+"' ";
	sql += " ) ";
	int result = DataManager.dataOperation(connection,sql);
	out.print(sql);
	if(result>0){
		String apply_mem_flag = Common.getFormatStr(request.getParameter("apply_mem_flag"));
		String apply_mem_name = "";
		if(apply_mem_flag.equals("1001")){
			apply_mem_name = "VIP会员";
		}else if(apply_mem_flag.equals("1002")){
			apply_mem_name = "B类会员";
		}else if(apply_mem_flag.equals("1003")){
			apply_mem_name = "A类会员";
		}else if(apply_mem_flag.equals("1004")){
			apply_mem_name = "证券咨询类会员";
		}else if(apply_mem_flag.equals("1005")){
			apply_mem_name = "租赁通会员";
		}else if(apply_mem_flag.equals("1006")){
			apply_mem_name = "人才网会员";
		}else if(apply_mem_flag.equals("1007")){
			apply_mem_name = "二手机品牌代理商";
		}else if(apply_mem_flag.equals("1008")){
			apply_mem_name = "二手机品牌厂商";
		}else if(apply_mem_flag.equals("1009")){
			apply_mem_name = "租赁站长";
		}else if(apply_mem_flag.equals("1010")){
			apply_mem_name = "配件网备备通";
		}else if(apply_mem_flag.equals("1011")){
			apply_mem_name = "配件网专卖店";
		}else if(apply_mem_flag.equals("1012")){
			apply_mem_name = "配套网会员";
		}else if(apply_mem_flag.equals("1013")){
			apply_mem_name = "铁塔通会员";
		}else if(apply_mem_flag.equals("1014")){
			apply_mem_name = "二手机认证经销商";
		}else if(apply_mem_flag.equals("1015")){
			apply_mem_name = "品配通会员";
		}
		HttpClient client = new HttpClient();
		PostMethod method =new PostMethod("http://service.21-sun.com/http/utils/sendmail.jsp");
		method.getParams().setContentCharset("UTF-8");
		method.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
		String fixed = "21sun";
		String mailto="zhangchen@21-sun.com";
		String mailcc="zhenghj@21-sun.com";
		String mailbcc="gaopeng@21-sun.com";
		String title=apply_mem_name+"申请邮件";
		String content = "";
		//内容
		content = "<table cellpadding='5' cellspacing='5'>";
		content += "<tr><td colspan='2'><b>申请会员信息</b></td></tr>";
		content += "<tr>";
		content += "<td>申请会员类型：</td><td>"+apply_mem_name+"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "<td>申请人：</td><td>"+ Common.getFormatStr(request.getParameter("mem_name"))+"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "<td>公司名称：</td><td>"+ Common.getFormatStr(request.getParameter("comp_name"))+"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "<td>联系电话：</td><td>"+ Common.getFormatStr(request.getParameter("telephone"))+"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "<td>Email：</td><td>"+ Common.getFormatStr(request.getParameter("email"))+"</td>";
		content += "</tr>";
		content += "<tr>";
		content += "<td>说明：</td><td>"+ Common.getFormatStr(request.getParameter("content"))+"</td>";
		content += "</tr>";
		content += "</table>";
		String fromName="来自21-sun";
		NameValuePair[] data ={ new NameValuePair("to",mailto),new NameValuePair("cc",mailcc),new NameValuePair("bcc",mailbcc),new NameValuePair("title",title),new NameValuePair("content",content),new NameValuePair("fromName",fromName),new NameValuePair("fixed",fixed)};
		method.setRequestBody(data);
		Object a = client.executeMethod(method);
		if(a!=null){
			String resultBack = a.toString();
			if(resultBack.equals("200")){
				//System.out.println("邮件发送成功！");
			}else{
				//System.out.println("邮件发送不成功！");
			}
		}else{
			//System.out.println("邮件发送不成功！");
		}
		// 释放连接
		method.releaseConnection();
	}
} catch (Exception e) {
	 e.printStackTrace();
} finally {
	poolManager.freeConnection(connection);
}
%>