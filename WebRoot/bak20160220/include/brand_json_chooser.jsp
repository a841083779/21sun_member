<%@page contentType="text/html;charset=utf-8"
	
	%>
<%@page import="com.jerehnet.cmbol.database.PoolManager"%>
<%@page import="com.jerehnet.cmbol.database.DataManager"%>
<%@page import="com.jerehnet.util.Common"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%><%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache" %>
	/**
* 本页面生成一段javascript，用于返回 品牌的数据
*/
zd_probrandcallback(
{"brands":[
{"id":"0","title":"品牌推荐","text":"品牌推荐","caption":"true","disabled":"true"},

<% // 

//判断用户是否已经登陆
Map memberInfo = null ;
memberInfo = (HashMap) session.getAttribute("memberInfo") ; ;
String sessionMemNo = "" ;
if(null != memberInfo)
{
	  sessionMemNo  =((String)memberInfo.get("mem_no"));  // 获得session 中的登陆名
	  
}else
{
	sessionMemNo = "error" ; //如果用户没有登陆，
}
PoolManager pool5 = new PoolManager(5) ;  //  sell_buy_market
PoolManager pool = (PoolManager)application.getAttribute("poolAPP");

if(pool==null){
	pool = new PoolManager();
}						

	String[][] recommendIndex  = DataManager.fetchFieldValue(pool5,"sell_buy_market","distinct probrand","mem_no='"+sessionMemNo+"' and probrand <> 'null'  group by probrand ") ;
	String[][] recommendFactorys = null ;
	String recommendfacName = null ;
	if(null != recommendIndex)
	{
		for(int k=0;k<recommendIndex.length;k++)
		{
			recommendFactorys = DataManager.fetchFieldValue(pool,"pro_agent_factory","id,name","id='"+recommendIndex[k][0]+"'") ;
			if(null==recommendFactorys){
				recommendFactorys = new String[0][0] ;
			}
			for(int i=0;i<recommendFactorys.length;i++)
			{
				recommendfacName=Common.getFormatStr(recommendFactorys[i][1]) ;
				out.println("{\"id\":\""+Common.getFormatStr(recommendFactorys[i][0])+"\",\"title\":\""+recommendfacName+"\",\"text\":\""+recommendfacName+"\"},");
			}
			
		}
	}
//
//select pro_agent_factory.id,pro_agent_factory.name,count(*)  from pro_agent_factory,pro_products WHERE pro_agent_factory.flag=1 and pro_agent_factory.upper_index='S' and pro_agent_factory.id=pro_products.factoryid group by pro_agent_factory.id,pro_agent_factory.name order by count(*) desc,pro_agent_factory.name
	%>
<cache:cache key="allbrands1" cron="8 1 * * 1">
<%
String[][] upperIndex = DataManager.fetchFieldValue(pool, "pro_agent_factory",
						" upper_index", "(flag = 1) AND (upper_index IS NOT NULL) GROUP BY upper_index");
String letter = "";
String[][] factorys = null;
String facName="";
for(int i=0;upperIndex!=null && i<upperIndex.length;i++){
	letter = Common.getFormatStr(upperIndex[i][0]).toUpperCase();
	out.println("{\"id\":\""+letter+"\",\"title\":\""+letter+"\",\"text\":\""+letter+"\",\"caption\":\"true\",\"disabled\":\"true\"},");
	//System.out.println("{\"id\":\""+letter+"\",\"title\":\""+letter+"\",\"text\":\""+letter+"\",\"caption\":\"true\",\"disabled\":\"true\"},");
	factorys = DataManager.fetchFieldValue(pool, "pro_agent_factory,pro_products",
				" pro_agent_factory.id,pro_agent_factory.name,count(*)", "pro_agent_factory.flag=1 and pro_agent_factory.upper_index='"+letter+"' and pro_agent_factory.id=pro_products.factoryid group by pro_agent_factory.id,pro_agent_factory.name order by count(*) desc,pro_agent_factory.name");	
	for(int m=0;factorys!=null && m<factorys.length;m++){
		facName=Common.getFormatStr(factorys[m][1]) ;
		out.println("{\"id\":\""+Common.getFormatStr(factorys[m][0])+"\",\"title\":\""+facName+"\",\"text\":\""+facName+"\"},");
		//System.out.println("{\"id\":\""+Common.getFormatStr(factorys[m][0])+"\",\"title\":\""+facName+"\",\"text\":\""+facName+"\"},");
	}   
  	
}


%>
</cache:cache>
]})
