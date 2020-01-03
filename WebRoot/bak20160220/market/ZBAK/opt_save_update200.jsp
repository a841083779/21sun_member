<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*,org.apache.commons.httpclient.*"
	%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
	<%@ include file ="/manage/config.jsp"%>
	<% 
	//过滤二手信息
	HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
	String zd_title =  Common.getFormatStr(request.getParameter("zd_title"));
	String zd_descr =  Common.getFormatStr(request.getParameter("zd_descr"));
	boolean is_good_person = zd_title.matches("[^`]*[小|调|白|女|学|夜|冬][^`]{1,3}[姐|教|领|王|生|情|虫][^`]*");
	if(!is_good_person){
		is_good_person = zd_descr.matches("[^`]*[小|调|白|女|学|夜|冬][^`]{1,3}[姐|教|领|王|生|情|虫][^`]*");
	}
	String ly = Common.getFormatStr(request.getHeader("referer"));
    if((ly.indexOf("member.21-sun.com") != 0 || ly.indexOf("localhost") !=0 || ly.indexOf("127.0.0.1")!=0)){
	//把品牌放到session中
	String zd_probrand = Common.getFormatStr(request.getParameter("zd_probrand"));
	String brand_name = (String)request.getParameter("pro_brand_name") ;
	session.setAttribute("brandname",brand_name) ;
	// 把机型和类别放入session中
	String product_flag = Common.getFormatStr(request.getParameter("zd_product_flag")) ; 
	String part_flag  = Common.getFormatStr(request.getParameter("zd_part_flag")) ;
	if(!"".equals(product_flag))
	{
	 session.setAttribute("sessionProbrand",product_flag) ;
	}
	if(!"".equals(part_flag))
	{
		 session.setAttribute("sessionPartflag",part_flag) ;
	}
	String filter_keyword = Common.getFormatStr((session.getAttribute("_filter_keyword"))) ;
	String mem_flag = Common.getFormatStr(memberInfo.get("mem_flag")) ;
//===调租赁库====
PoolManager pool5 = new PoolManager(5);

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));   // 插入数据库的表名
String randflag=Common.getFormatInt(request.getParameter("randflag"));

String brand = Common.getFormatStr(request.getParameter("brand_3")) ;
//=====生成静态页的相关控制===
String zd_catalog_no=Common.getFormatStr(request.getParameter("zd_catalog_no"));
int result = 0;
//UsedToHtml usedToHtml=new UsedToHtml();
try{
	//若会员不存在，不允许发布信息
	boolean isMem = false;
	PoolManager pool1 = null;
	Connection memConn = null;
	String mem_no = Common.getFormatStr(request.getParameter("zd_mem_no"));
	try{
		pool1 = new PoolManager();
		memConn = pool1.getConnection();
		String memSql = " select top 1 id from member_info where mem_no = '"+mem_no+"'  ";
		ResultSet memRs = DataManager.executeQuery(memConn, memSql);
		if(memRs.next() && !mem_no.equals("")){
			isMem = true;
		}
	}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		pool1.freeConnection(memConn);
	}
if(isMem){//会员信息存在
  if(zd_title.indexOf("二手") >= 0 || zd_descr.indexOf("二手") >= 0){
	  %>
		<script>
			alert("二手信息请您到二手栏目发布，谢谢。");
		    parent.location.href = "/manage/membermain.jsp?addflag=62"; 
		</script>
		<%
  }else{
	// 把表单中数据插入数据库
	//result =DataManager.dataInsUpt(request, pool5, mypy,2,7);
	// 注册码验证
	if(Common.getFormatInt(request.getParameter("rand")).equals( Common.getFormatInt((String)session.getAttribute("loginRand")) )){
	   	result =DataManager.dataInsUpt(request, pool5, mypy,2,7);
	}else{
		result = -1;
	} 
 //=====更新首页相关静态页====
 //   usedToHtml.indexAllHtml(request,pool5,zd_catalog_no);	
	if(result>0){
		String zd_id = Common.getFormatInt(request.getParameter("zd_id"));
		if(null==zd_id||"".equals(zd_id)||"0".equals(zd_id)){
			zd_id = result+"";
		}
		try{
			//更新索引
			HttpClient httpClient = new HttpClient();
			PostMethod postMethod = new PostMethod("http://search.21-rent.com/writer/market.21-sun.com/sell_create_one.jsp");
			postMethod.addParameter("id",zd_id);
			httpClient.executeMethod(postMethod);
		}catch(Exception e){
			e.printStackTrace();
		}
%>
	<script type="text/javascript">
		alert("OK！操作成功！");
		parent.location.replace(parent.location.href); 
	</script>
	<%
	}else if(result==-1){
	%>
	<script>
		alert("验证码输入不正确，请重新输入！");
		history.back();
	</script>
	<%}else if(1==1){  // A 类会员提示敏感词
	%>
	<script>
		alert("含有如下敏感词汇<%=Common.getFormatStr((session.getAttribute("_filter_keyword"))).equals("")?"":":"+Common.getFormatStr((session.getAttribute("_filter_keyword")))%>，请您重新发布！");
		history.back();
	</script>
<%
	}else{
		%>
		<script>
			alert("您发布的信息中涉及有与机械无关的敏感词汇，请您重新发布！");
			history.back();
		</script>
	<%
		
	}
  }
}else{
	  session.invalidate();
%>
  <script>
		alert("信息有误，请您重新发布！");
		window.parent.location.href="/";
	</script>
  <%
	}
}catch(Exception e){
}finally{
	urlpath=null;
	mypy=null;
}	
    }else{
    //	session.invalidate();
%>
<script>
		alert("操作有误!!!");
		//window.parent.location.href="/";
</script>
<%}%>