<%@page contentType="text/html;charset=utf-8"
	import="java.io.File,java.sql.*,java.util.*,jerehnet.database.*,jerehnet.util.*"
	%>
<%
String fieldname=Common.getFormatStr(request.getParameter("filename"));
String subPath=Common.getFormatStr(request.getParameter("subPath"));
String uploaddir=request.getRealPath("/")+"uploadfiles\\"+subPath+"\\";
String watermarkdir=request.getRealPath("/")+"images\\";
//System.out.println(dirname+"21sun_logo.png---======------"+dirname+fieldname);
//Common.waterMark(dirname+"21sun_logo.png",dirname+fieldname,0,0);
Common.waterMark(watermarkdir+"watermarkLog.png",uploaddir+fieldname,0,0);
%>



