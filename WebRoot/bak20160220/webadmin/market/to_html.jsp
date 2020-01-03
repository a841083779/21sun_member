<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.freemaker.*"%>
<%@ include file ="../manage/config.jsp"%>
<%
	pool = new PoolManager(5);
	
	PoolManager pool2 = new PoolManager();
	
	SellBuyToHtml sellBuy = new SellBuyToHtml();
	//热点(request,pool,productFlag,businessFlag,indexFlag,rows,tName,cName)
	//sellBuy.subIndex(request,pool,"101001","","",5,"/template/hot_index.htm","/include/hot_first_index.htm");//第一大类：挖掘机
	//sellBuy.subIndex(request,pool,"101002","","",5,"/template/hot_index.htm","/include/hot_second_index.htm");//第二大类：装载机
	//sellBuy.subIndex(request,pool,"103","","",5,"/template/hot_index.htm","/include/hot_third_index.htm");//第三大类：混凝土
	//资讯中心
	sellBuy.subNewsIndex(request,pool2,"挖掘机",5,"/template/hot_index.htm","/include/hot_first_index.htm");//第一大类：挖掘机
	sellBuy.subNewsIndex(request,pool2,"装载机",5,"/template/hot_index.htm","/include/hot_second_index.htm");//第二大类：装载机
	sellBuy.subNewsIndex(request,pool2,"混凝土",5,"/template/hot_index.htm","/include/hot_third_index.htm");//第三大类：混凝土
	//供应信息
	sellBuy.subIndex(request,pool,"101001","10","",6,"/template/sell_index.htm","/include/sell_first_index.htm");//第一大类：挖掘机
	sellBuy.subIndex(request,pool,"101002","10","",6,"/template/sell_index.htm","/include/sell_second_index.htm");//第二大类：装载机
	sellBuy.subIndex(request,pool,"103","10","",6,"/template/sell_index.htm","/include/sell_third_index.htm");//第三大类：混凝土
	//求购信息
	sellBuy.subIndex(request,pool,"101001","11","",6,"/template/buy_index.htm","/include/buy_first_index.htm");//第一大类：挖掘机
	sellBuy.subIndex(request,pool,"101002","11","",6,"/template/buy_index.htm","/include/buy_second_index.htm");//第二大类：装载机
	sellBuy.subIndex(request,pool,"103","11","",6,"/template/buy_index.htm","/include/buy_third_index.htm");//第三大类：混凝土
	//配件信息：挖掘机配件101;破碎锤配件102;装载机配件103;混凝土机械配件104;路面设备配件105;其他配件106
	sellBuy.subPartIndex(request,pool2,"101",12,"/template/part_index.htm","/include/part_first_index.htm");//第一大类：挖掘机
	sellBuy.subPartIndex(request,pool2,"103",12,"/template/part_index.htm","/include/part_second_index.htm");//第二大类：装载机
	sellBuy.subPartIndex(request,pool2,"105",12,"/template/part_index.htm","/include/part_third_index.htm");//第三大类：路面设备
	//鼠标放上调对应信息-产品供应
	sellBuy.subIndex(request,pool,"101001","10","",12,"/template/other_all_index.jsp","/include/sell_first_all_index.jsp");//第一大类：挖掘机
	sellBuy.subIndex(request,pool,"101002","10","",12,"/template/other_all_index.jsp","/include/sell_second_all_index.jsp");//第二大类：装载机
	sellBuy.subIndex(request,pool,"103","10","",12,"/template/other_all_index.jsp","/include/sell_third_all_index.jsp");//第三大类：混凝土
	//鼠标放上调对应信息-产品求购
	sellBuy.subIndex(request,pool,"101001","11","",12,"/template/other_all_index.jsp","/include/buy_first_all_index.jsp");//第一大类：挖掘机
	sellBuy.subIndex(request,pool,"101002","11","",12,"/template/other_all_index.jsp","/include/buy_second_all_index.jsp");//第二大类：装载机
	sellBuy.subIndex(request,pool,"103","11","",12,"/template/other_all_index.jsp","/include/buy_third_all_index.jsp");//第三大类：混凝土
	//鼠标放上调对应信息-代理招商
	sellBuy.subIndex(request,pool,"101001","12","",12,"/template/other_all_index.jsp","/include/agent_first_all_index.jsp");//第一大类：挖掘机
	sellBuy.subIndex(request,pool,"101002","12","",12,"/template/other_all_index.jsp","/include/agent_second_all_index.jsp");//第二大类：装载机
	sellBuy.subIndex(request,pool,"103","12","",12,"/template/other_all_index.jsp","/include/agent_third_all_index.jsp");//第三大类：混凝土
	//鼠标放上调对应信息-寻求项目
	sellBuy.subIndex(request,pool,"101001","13","",12,"/template/other_all_index.jsp","/include/project_first_all_index.jsp");//第一大类：挖掘机
	sellBuy.subIndex(request,pool,"101002","13","",12,"/template/other_all_index.jsp","/include/project_second_all_index.jsp");//第二大类：装载机
	sellBuy.subIndex(request,pool,"103","13","",12,"/template/other_all_index.jsp","/include/project_third_all_index.jsp");//第三大类：混凝土
	//鼠标放上调对应信息-技术转让
	sellBuy.subIndex(request,pool,"101001","14","",12,"/template/other_all_index.jsp","/include/tec_first_all_index.jsp");//第一大类：挖掘机
	sellBuy.subIndex(request,pool,"101002","14","",12,"/template/other_all_index.jsp","/include/tec_second_all_index.jsp");//第二大类：装载机
	sellBuy.subIndex(request,pool,"103","14","",12,"/template/other_all_index.jsp","/include/tec_third_all_index.jsp");//第三大类：混凝土
	
%>