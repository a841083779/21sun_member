<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*,jerehnet.database.*,jerehnet.action.*,jerehnet.util.*"
	%>
	<% 
PoolManager pool = (PoolManager)application.getAttribute("poolAPP");
if(pool==null){
	pool = new PoolManager();
}
	
ToHtmlAction toHtml = new ToHtmlAction();
toHtml.init(request);

//System.out.println("0000000000000");

String flag=request.getParameter("flag");
if(flag==null){
	flag="";
}

if(flag.equals("10")){
    //更新产品大全首页面类别
	//System.out.println("22222");
	toHtml.productIdexToHtml(pool,request);
	//System.out.println("1111");
}

if(flag.equals("1")){
	//所有产品
	toHtml.allProductToHtml(pool,request);
}
if(flag.equals("2")){
	//产品图片
	toHtml.toHtmlIndexPicComm(pool,request);
	toHtml.toHtmlIndexPicConv(pool,request);
}
if(flag.equals("3")){
	//机型推荐
	toHtml.toHtmlIndexCommend(pool,request);
}
if(flag.equals("4")){
	//热点产品
	toHtml.toHtmlIndexHot(pool,request);
	toHtml.toHtmlIndexHotPic(pool,request);
}
if(flag.equals("5")){
	//首页
	toHtml.fontpageHottoHtml(pool,request,"7",50);
	toHtml.fontpagePictoHtml(pool,request,"7",18);
	toHtml.fontpagePricetoHtml(pool,request,"7");
	toHtml.fontpageAgenttoHtml(pool,request);
	toHtml.fontpageNewstoHtml(pool,request,"8","5");

}
if(flag.equals("6")){
	//所有厂商
	toHtml.allFactoryToHtml(pool,request);
}
if(flag.equals("7")){
	//所有代理商
	toHtml.allAgentToHtml(pool,request);
}

if(flag.equals("9")){
    //更新品牌大全
	toHtml.brandToHtml(pool,request,1);
	toHtml.brandToHtml(pool,request,2);
}

if(flag.equals("11")){
	toHtml.leftTree1ToHtml(pool,request);
}

if(flag.equals("8")){
	//产品图片
	toHtml.toHtmlIndexPicComm(pool,request);
	toHtml.toHtmlIndexPicConv(pool,request);
	
	//所有产品
	toHtml.allProductToHtml(pool,request);
	
	//机型推荐
	toHtml.toHtmlIndexCommend(pool,request);
	
	//热点产品
	toHtml.toHtmlIndexHot(pool,request);
	toHtml.toHtmlIndexHotPic(pool,request);
	
	//首页
	toHtml.fontpageHottoHtml(pool,request,"7",50);
	toHtml.fontpagePictoHtml(pool,request,"7",18);
	toHtml.fontpagePricetoHtml(pool,request,"7");
	toHtml.fontpageAgenttoHtml(pool,request);
	toHtml.fontpageNewstoHtml(pool,request,"8","5");
	
	    //更新品牌大全
	toHtml.brandToHtml(pool,request,1);
	toHtml.brandToHtml(pool,request,2);
}


	%>