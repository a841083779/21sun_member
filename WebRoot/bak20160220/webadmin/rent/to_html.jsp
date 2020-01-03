<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.freemaker.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%
//===调租赁库====
PoolManager pool3 = new PoolManager(3);
TechToHtml techToHtml = new TechToHtml();
techToHtml.indexNewHtml(request, pool3, "700301");
%>