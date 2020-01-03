<%@page contentType="text/html;charset=utf-8"import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.jobs.action.*,com.jerehnet.cmbol.freemaker.*"
	%><%@ include file ="../manage/config.jsp"%>
	<% 
//===调租赁库====
PoolManager pool1 = new PoolManager(10);

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));
String id=Common.getFormatStr(request.getParameter("myvalue"));
String ip=Common.getFormatStr(request.getParameter("zd_add_ip"));
String date=Common.getFormatStr(request.getParameter("zd_add_date"));
String name=Common.getFormatStr(request.getParameter("zd_name"));
String nodeid=Common.getFormatStr(request.getParameter("zd_nodeid"));
String image=Common.getFormatStr(request.getParameter("zd_image"));
String cake = "";
//=====生成静态页的相关控制===
Connection conn = null;
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
String sql;
int result = 0;
//RentToHtml rentToHtml=new RentToHtml();
try{
	conn = pool1.getConnection();
	//生成cake
	String lenid = nodeid;
	String xie = "&gt;&gt;<a href=\"../search/cattype0s_1_"+nodeid+"_0_0_0.htm\">"+name+"<a>";
	while(lenid.length()>2){
		lenid = lenid.substring(0,lenid.length()-2);
		String len = "select * from zhidao_type where nodeid = '"+lenid+"'";
		ResultSet ls = DataManager.executeQuery(conn,len);
		if(ls!=null&&ls.next()){
			String x = "&gt;&gt;<a href=\"../search/cattype0s_1_"+Common.getFormatStr(ls.getString("nodeid"))+"_0_0_0.htm\">"+Common.getFormatStr(ls.getString("name"))+"<a>";
			xie = x + xie;
		}
	}
	cake = xie.substring(8);
	//结束
	if(id==null||id.equals("")||id.equals("0")){
		sql="insert into zhidao_type (add_user,add_ip,add_date,nodeid,name,parent,par,image,cake) "
			+"values ('','"+ip+"',getDate(),'"+nodeid+"','"+name+"','','','"+image+"','"+cake+"')";
	}else{
		sql="update zhidao_type set add_ip='"+ip+"',add_date=convert(datetime,'"+date+"'),name='"+name+"',nodeid='"+nodeid+"',cake='"+cake+"',image='"+image+"'"
		+" where id="+id;
	}
	result =DataManager.dataOperation(conn,sql);
	 //=====更新首页相关静态页====
  // rentToHtml.indexAllHtml(request,pool1,zd_catalog_no);
    if(result>0){
%>
	<script>
		alert("OK！操作成功！");
	try{
	//window.document.location.reload();
	window.document.location.href='<%=urlpath%>';
	}catch(e){}	
	
	</script>
	<%}else{%>
	<script>
		alert("操作失败！");
		history.back();
	</script>
<%
	}	
}catch(Exception e){
	e.printStackTrace();
}finally{
	urlpath=null;
	mypy=null;
	zd_catalog_no=null;
	pool1.freeConnection(conn);
	//rentToHtml=null;
}	
%>