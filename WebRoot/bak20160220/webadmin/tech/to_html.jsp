<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.freemaker.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%

if(pool==null){
	pool = new PoolManager();
}

TechToHtml techToHtml = new TechToHtml();
techToHtml.indexNewHtml(request, pool, "700301");
%>