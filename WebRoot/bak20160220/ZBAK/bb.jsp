<%@page	contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.text.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*" errorPage=""%>

<%


out.println(Common.getAddressForIp(request,"221.0.90.164",1)+"---"+Common.getAddressForIp(request,"221.0.90.164",2));

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%//=path %>/css/main.css" type="text/css" media="screen, projection" />
<title>示例程序首页</title>
  <style type="text/css">
      body {font-family: arial,sans-serif;font-size: 12px; color: black} 
	  .forecast{float:left; width:150;white-space:nowrap; }
	  #inforMore{clear:both;}
  </style>
  <script src="/scripts/jquery-1.4.1.min.js"></script>
</head>
<body >

  <SCRIPT LANGUAGE="JavaScript">
  <!--
  var weathInfor="";
	$(document).ready(function() {
    $.post("http://www.google.com/ig/api?hl=zh-cn&weather=Beijing",function(xml){

    weathInfor+="城市："+$(xml).find("forecast_information").children("postal_code").attr("data")+"<br>";
	weathInfor+="日期："+$(xml).find("forecast_information").children("forecast_date").attr("data")+"<br>";
	weathInfor+=" " +"<br>";
	weathInfor+="天气："+$(xml).find("current_conditions").children("condition").attr("data")+"<br>";
	weathInfor+="温度："+$(xml).find("current_conditions").children("temp_c").attr("data")+"<br>";
	weathInfor+=""+$(xml).find("current_conditions").children("humidity").attr("data")+"<br>";
	weathInfor+="<img src=\"http://www.google.com"+$(xml).find("current_conditions").children("icon").attr("data")+"\"><br>";
	weathInfor+=" " +"<br>";
	 


    $(xml).find("forecast_conditions").each
	(
	function()
		{
			weathInfor+="<div class='forecast'> " +"<br>";
			weathInfor+="日期："+$(this).children("day_of_week ").attr("data")+"<br>";
			weathInfor+="低温："+$(this).children("low ").attr("data")+"<br>";
			weathInfor+="高温："+$(this).children("high ").attr("data")+"<br>";
			weathInfor+="天气："+$(this).children("condition ").attr("data")+"<br>";
			weathInfor+="<img src=\"http://www.google.com"+$(this).children("icon ").attr("data")+"\"><br>";
			weathInfor+=" " +"<br>";
			weathInfor+="</div>";
		
		}
	);


	$("#infor").html(weathInfor);
}
)
})

  //-->
  </SCRIPT>

  <div id="infor"></div>
  <div id="inforMore"><a href="http://www.admans.net/weather_cn.html" target="_blank">查看全国天气预报动画</a></div>

</body>
</html>