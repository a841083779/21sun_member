<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*"%><%@ include file ="/manage/config.jsp"%><%
HashMap memberInfo = (HashMap)session.getAttribute("memberInfo");

PoolManager poolRent = new PoolManager(3);//租赁
PoolManager poolused = new PoolManager(4);//二手
PoolManager poolMarket = new PoolManager(5);//供求
PoolManager poolPart = new PoolManager(7);//配件

String rents[][] = DataManager.fetchFieldValue(poolRent,"rent_info","top 4 id,title","is_pub=1 and (class=1 or class=0) order by id desc");
String useds[][] = DataManager.fetchFieldValue(poolused,"equipment","top 4 id,title,1","is_pub=1 order by id desc");
String markets[][] = DataManager.fetchFieldValue(poolMarket,"sell_buy_market","top 4 id,title","is_show=1 and (business_flag=10 or business_flag=11)  order by id desc");
String partsSupply[][] = DataManager.fetchFieldValue(poolPart,"supply","top 4 id,title","is_pub=1  order by id desc");
String partsBuy[][] = DataManager.fetchFieldValue(poolPart,"buy","top 4 id,title","is_pub=1  order by id desc");


//String city = Common.getFormatStr((String)session.getAttribute("city")).replace("市","");
//====根据ip地址取城市===
String city="";
String ip=Common.getRemoteAddr(request,1);
String addr = Common.getAddressForIp(request,ip,1);

String [][]provinces = (String[][])application.getAttribute("provinces");
String [][]citys = (String[][])application.getAttribute("citys");

for(int i=0;citys!=null && i<citys.length;i++){
	if(addr.indexOf(citys[i][0])!=-1){
		city=Common.getFormatStr(citys[i][0]);
	}
}

if(city!=null)
{if(city.equals(""))
 city="烟台";
city=city.replace("市","");}

//=====通过ip地址取省份完毕====

//out.println("city:==="+city);
//String city = "烟台";
//System.out.println("1111111111111111");
String weathers = WeatherReport.getweather(city);
//System.out.println("2222");
String weatherArr[] = weathers.split(",");
//System.out.println("33333");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/menu.css" rel="stylesheet" type="text/css" />
<script src="prototype.lite.js" type="text/javascript"></script>
<script src="moo.fx.js" type="text/javascript"></script>
<script src="moo.fx.pack.js" type="text/javascript"></script>
</head>
<body>
<div class="loginok_center3" style="width:350px;">
  
  <div class="loginok_center3_2">
    <div class="tan01"><span class="red14"><%=Common.getFormatStr(memberInfo.get("mem_name"))%></span><br />您好。
      欢迎您登录<b>21-SUN</b></div>
    <div class="tan03"><!--<%=city+"-"+weathers%>-->
	<%if(weatherArr!=null && weatherArr.length==4){%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50" rowspan="2"><img src="http://www.google.com/<%=weatherArr[3]%>" /></td>
    <td><%=city%>：<%=weatherArr[1]+"°C-"+weatherArr[2]+"°C"%></td>
  </tr>
  <tr>
    <td><%=weatherArr[0]%></td>
  </tr>
</table>
<%}%>
    </div>
    <div class="tanxian">
      <div class="tan02">
        <ul>
		  <%for(int i=0;markets!=null && i<markets.length && i<2;i++){%>
          <li><span class="yellow">供求</span> <a href="http://market.21-sun.com/viewSellBuy_for_<%=Common.getFormatStr(markets[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(markets[i][1])%>"><%=Common.getFormatStandard(markets[i][1],2,10)%></a></li>
         <%}%>
		 <%for(int i=0;partsSupply!=null && i<partsSupply.length && i<2;i++){%>
          <li><span class="red">配件</span> <a href="http://part.21-sun.com/sale/saledetail_for_<%=Common.getFormatStr(partsSupply[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(partsSupply[i][1])%>"><%=Common.getFormatStandard(partsSupply[i][1],2,10)%></a></li>
         <%}%>
        </ul>
      </div>
      <div class="tan02">
        <ul>
         <%for(int i=2;markets!=null && i<markets.length;i++){%>
          <li><a href="http://market.21-sun.com/viewSellBuy_for_<%=Common.getFormatStr(markets[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(markets[i][1])%>"><%=Common.getFormatStandard(markets[i][1],2,10)%></a></li>
         <%}%>
		 <%for(int i=2;partsBuy!=null && i<partsBuy.length;i++){%>
          <li><a href="http://part.21-sun.com/buy/buydetail_for_<%=Common.getFormatStr(partsBuy[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(partsBuy[i][1])%>"><%=Common.getFormatStandard(partsBuy[i][1],2,10)%></a></li>
         <%}%>
        </ul>
      </div>
	  <div class="tan02">
        <ul>  
		  <%for(int i=0;useds!=null && i<useds.length && i<2;i++){%>
          <li><span class="lu">二手</span> 
	<%if(Common.getFormatStr(useds[i][2]).equals("0")){%>	  
		  <a href="http://used.21-sun.com/supply/supplydetail_for_<%=Common.getFormatStr(useds[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(useds[i][1])%>"><%=Common.getFormatStandard(useds[i][1],2,10)%></a>
	<%}else{%>	  
		  <a href="http://used.21-sun.com/equipment/equipmentdetail_for_<%=Common.getFormatStr(useds[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(useds[i][1])%>"><%=Common.getFormatStandard(useds[i][1],2,10)%></a>
	 <%}%> 	  
		  </li>
		
         <%}%>
		 <%for(int i=0;rents!=null && i<rents.length && i<2;i++){%>
          <li><span class="lu">租赁</span> <a href="http://rent.21-sun.com/rent/rentdetail_for_<%=Common.getFormatStr(rents[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(rents[i][1])%>"><%=Common.getFormatStandard(rents[i][1],2,13)%></a></li>
         <%}%>
        </ul>
      </div>
	  <div class="tan02">
        <ul>
          <%for(int i=2;useds!=null && i<useds.length;i++){%>
          <li><%if(Common.getFormatStr(useds[i][2]).equals("0")){%>	  
		  <a href="http://used.21-sun.com/supply/supplydetail_for_<%=Common.getFormatStr(useds[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(useds[i][1])%>"><%=Common.getFormatStandard(useds[i][1],2,10)%></a>
	<%}else{%>	  
		  <a href="http://used.21-sun.com/equipment/equipmentdetail_for_<%=Common.getFormatStr(useds[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(useds[i][1])%>"><%=Common.getFormatStandard(useds[i][1],2,10)%></a>
	 <%}%> 	  </li>
         <%}%>
          <%for(int i=2;rents!=null && i<rents.length;i++){%>
          <li><a href="http://rent.21-sun.com/rent/rentdetail_for_<%=Common.getFormatStr(rents[i][0])%>.htm" target="_blank" title="<%=Common.getFormatStr(rents[i][1])%>"><%=Common.getFormatStandard(rents[i][1],2,13)%></a></li>
         <%}%>
        </ul>
      </div>

    </div>
    <div class="tanxian1"><span class="bigblue"></span></div>
  </div>
</div>
</body>
</html>
