<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*,org.apache.commons.httpclient.*"
	%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
	<%@ include file ="/manage/config.jsp"%>
	<% 
    String prxStr = "zx";//字段前缀
    String state2 =  Common.getFormatStr((String) adminInfo.get("state2"));//限定状态

	String ok_word="";
	//过滤二手信息
	int newsover=0;
	HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");
	String 	mem_type  = Common.getFormatStr(memberInfo.get("mem_type"));//公司or个人
	String 	mem_flag  = Common.getFormatStr(memberInfo.get("mem_flag"));
	String 	mem_nos  = Common.getFormatStr(memberInfo.get("mem_no"));
	String  comp_phone  = Common.getFormatStr(memberInfo.get("comp_phone"));//电话
	String 	mem_name  = Common.getFormatStr(memberInfo.get("mem_name"));//名称
	String 	comp_name  = Common.getFormatStr(memberInfo.get("comp_name"));//公司名称
	String 	comp_intro  = Common.getFormatStr(memberInfo.get("comp_intro"));//公司简介
	String 	main_product  = Common.getFormatStr(memberInfo.get("main_product"));//公司简介
	
	//判断是否完善信息
	if(mem_type.equals("1")){//公司
	   if(comp_intro.equals("")||comp_phone.equals("")||mem_name.equals("")||main_product.equals("")||comp_name.equals("")){
	      newsover=1;
	   }
	}else if(mem_type.equals("2")){//个人
	     if(comp_phone.equals("")||mem_name.equals("")){
	      newsover=1;
	   }
	}

	String zd_title =  Common.getFormatStr(request.getParameter(prxStr+"_title"));
	       zd_title=zd_title.replaceAll("<\\s*img\\s+([^>]*)\\s*>","");
           zd_title=zd_title.replaceAll("&nbsp;","");
           zd_title=zd_title.replaceAll("<[^<|^>]+>","");
		   zd_title=zd_title.replaceAll(" ","");
		   zd_title=zd_title.replaceAll("　","");
		   
	String zd_descr =  Common.getFormatStr(request.getParameter(prxStr+"_descr"));
	       zd_descr=zd_descr.replaceAll("<\\s*img\\s+([^>]*)\\s*>","");
           zd_descr=zd_descr.replaceAll("&nbsp;","");
           zd_descr=zd_descr.replaceAll("<[^<|^>]+>","");
		   zd_descr=zd_descr.replaceAll(" ","");
		   zd_descr=zd_descr.replaceAll("　","");
		   
	boolean is_good_person = zd_title.matches("[^`]*[小|调|白|女|学|夜|冬][^`]{1,3}[姐|教|领|王|生|情|虫][^`]*");
	if(!is_good_person){
		is_good_person = zd_descr.matches("[^`]*[小|调|白|女|学|夜|冬][^`]{1,3}[姐|教|领|王|生|情|虫][^`]*");
	}
	
	String  info=zd_title+zd_descr;
	int filterkeywords=0;
	if(mem_flag.equals("1003")||mem_nos.equals("hwasung")){
	//验证A类会员词汇
	Map filterkeywords_a = (Map) application.getAttribute("filterkeywords_a");
    if(filterkeywords_a!=null){
			    filterkeywords_a.put("磨簧机", "1");
				filterkeywords_a.put("卷簧机", "1");
				filterkeywords_a.put("票", "1");//20150729
				Iterator it = filterkeywords_a.keySet().iterator();  
                while (it.hasNext()){  
                String key;  
                key=(String)it.next();
				    if(info.indexOf(key)>=0&&!key.equals("")){
				      filterkeywords=1;
					  ok_word="A"+key;
					  break ;
				    }
				}
	}
	}else{
	//验证普通会员词汇
	Map filterMap = (Map) application.getAttribute("filterkeywords");
    if(filterMap!=null){
			    filterMap.put("磨簧机", "1");
				filterMap.put("卷簧机", "1");
				filterMap.put("票", "1");//20150729
				Iterator it = filterMap.keySet().iterator();  
                while (it.hasNext()){  
                String key;  
                key=(String)it.next();
				    if(info.indexOf(key)>=0&&!key.equals("")){
				      filterkeywords=1;
					   ok_word=key;
					  break ;
				    }
				}
	}
    }
	String ly = Common.getFormatStr(request.getHeader("referer"));
    if((ly.indexOf("member.21-sun.com") != 0 || ly.indexOf("localhost") !=0 || ly.indexOf("127.0.0.1")!=0)){
	//把品牌放到session中
	String zd_probrand = Common.getFormatStr(request.getParameter(prxStr+"_probrand"));
	String brand_name = (String)request.getParameter("pro_brand_name") ;
	session.setAttribute("brandname",brand_name) ;
	// 把机型和类别放入session中
	String product_flag = Common.getFormatStr(request.getParameter(prxStr+"_product_flag")) ; 
	String part_flag  = Common.getFormatStr(request.getParameter(prxStr+"_part_flag")) ;
	if(!"".equals(product_flag))
	{
	 session.setAttribute("sessionProbrand",product_flag) ;
	}
	if(!"".equals(part_flag))
	{
		 session.setAttribute("sessionPartflag",part_flag) ;
	}
	String filter_keyword = Common.getFormatStr((session.getAttribute("_filter_keyword"))) ;
//===调租赁库====
PoolManager pool5 = new PoolManager(5);

String urlpath=Common.getFormatStr(request.getParameter("urlpath"));
String mypy=Common.getFormatStr(request.getParameter("mypy"));   // 插入数据库的表名
String randflag=Common.getFormatInt(request.getParameter("randflag"));

String brand = Common.getFormatStr(request.getParameter("brand_3")) ;
//=====生成静态页的相关控制===
String zd_catalog_no=Common.getFormatStr(request.getParameter(prxStr+"_catalog_no"));
int result = 0;
//UsedToHtml usedToHtml=new UsedToHtml();
try{
	//若会员不存在，不允许发布信息
	boolean isMem = false;
	PoolManager pool1 = null;
	Connection memConn = null;
	String mem_no = Common.getFormatStr(request.getParameter(prxStr+"_mem_no"));
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
	//edited by gaopeng---20130928-begin
	boolean isPub = true;//是否可以发布
	int limitCount = 0;
	try{
	//添加限定状态---只能发布5条-begin
	String limitWhere = " mem_no='"+(String)adminInfo.get("mem_no")+"' and CONVERT(varchar(100), add_date, 23) = '"+CommonDate.getToday("yyyy-MM-dd")+"' ";
	String[][] sellLimit = DataManager.fetchFieldOneValue(pool5,"sell_buy_market", " count(id) ",limitWhere); // 查询出会员发出卖买的数量
	//System.out.println("limitWhere:"+limitWhere);
	String limitCountStr = "0";
	if(sellLimit!=null && !sellLimit.equals("")){
		limitCountStr = sellLimit[0][0];
		try{
			limitCount = Integer.parseInt(limitCountStr);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	System.out.println("limitCount:"+limitCount);
	//添加限定状态---只能发布5条-end
	} catch (Exception e) {
		e.printStackTrace();
	} 
	
	if(state2.equals("1")&&limitCount>=5){
		isPub = false;
		result = 5;
		//System.out.println("超了5条！");
	}
	//System.out.println("isPub:"+isPub);
	
	//没有完善信息不能发布
	if(newsover==1){
	  isPub = false;
	  result = 6;
	}
	 
	 String zx_checks= Common.getFormatStr(request.getParameter("zx_checks"));//正常入口验证
	 
	if(isPub){
		// 把表单中数据插入数据库
		//result =DataManager.dataInsUpt(request, pool5, mypy,2,7);
		
		//是否通过过滤词和信息完善
		if(filterkeywords==0&&newsover==0){
		// 注册码验证
		
	   
		if(Common.getFormatStr(request.getParameter("rand")).equalsIgnoreCase( Common.getFormatStr((String)session.getAttribute("loginRand")) )&&zx_checks.equals("会员供求入口")){
			result =DataManager.dataInsUpt(request, pool5, mypy,2,7,prxStr);
		}else{
			result = -1;
		} 
		}else{
		    result = 0;
		}
		//System.out.println("=================================:"+result+":"+zd_title+":"+mem_no+":"+ly+":"+Common.getToday("yyyy-MM-dd HH:mm:ss", 0));
	}
	//edited by gaopeng---20130928-end
 //=====更新首页相关静态页====
 //   usedToHtml.indexAllHtml(request,pool5,zd_catalog_no);	
     String zd_id = Common.getFormatInt(request.getParameter(prxStr+"_id"));
	

	if(result>0||(result==0&&!zd_id.equals("0"))){
		if(null==zd_id||"".equals(zd_id)||"0".equals(zd_id)){
			zd_id = result+"";
		}
		try{
			//更新索引
			//HttpClient httpClient = new HttpClient();
			//PostMethod postMethod = new PostMethod("http://sowa.21-sun.com/writer/market.21-sun.com/sell_create_one.jsp");
			//postMethod.addParameter("id",zd_id);
			//httpClient.executeMethod(postMethod);
			Map postMap = new HashMap();
			postMap.put("id",zd_id);
			if(zx_checks.equals("会员供求入口")){
			Common.doPostHttpAsync("http://sowa.21-sun.com/writer/market.21-sun.com/sell_create_one.jsp", postMap);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		 if(filterkeywords==1){
%>
	<script type="text/javascript">
		alert("您发布的信息中涉及有与机械无关的敏感词汇，请您重新发布！");
		parent.location.replace(parent.location.href); 
	</script>
	<% }else{%>
	 <script type="text/javascript">
		alert("OK！操作成功！");
		parent.location.replace(parent.location.href); 
	</script>
	<%}}else if(result==-1){ %>
	<script>
		alert("验证码输入不正确，请重新输入！");
		history.back();
	</script>
	<%}else if(result==6){ //未完善信息不能发布%>
	<script>
		alert("发布信息前，请先完善您的个人资料，便于您的潜在客户及时联系到您！");
		history.back();
	</script>
	<%}else if(1==1){  // A 类会员提示敏感词%>
	<script>
		alert("您发布的信息含有非法词汇，请您重新发布！");
		history.back();
	</script>
	<%	}else{%>
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