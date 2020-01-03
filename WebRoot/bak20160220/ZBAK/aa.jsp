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

</head>
<body id="home">

<%

String weathers = WeatherReport.getweather("yantai");
out.println(weathers+"<br>");
String weatherArr[] = weathers.split(",");
out.println(weatherArr.length+"<br>");
if(weatherArr!=null || weatherArr.length==4){
	out.println(weatherArr[0]+"<br>");
	out.println(weatherArr[1]+"°C-"+weatherArr[2]+"°C<br>");
	out.println(weatherArr[3]+"<br>");
}


%>

</body>
</html>