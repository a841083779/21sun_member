<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.Common"%>
<%@page import="com.jerehnet.cmbol.freemaker.TechToHtml"%>
<%@page import="com.jerehnet.cmbol.database.PoolManager"%>
<%
	PoolManager pool = new PoolManager();
	String flag = Common.getFormatStr(request.getParameter("flag")) ;  // flag 维修一线 1生成全部静态页 2生成首页静态页
	try{
	if(flag.equals("1")){ // 生成全部静态页
		TechToHtml techToHtml=new TechToHtml();
		techToHtml.allHtml(request, pool,"700301");
	} 
	if(flag.equals("2")){ // 生成首页静态页
		TechToHtml techToHtml=new TechToHtml();
		techToHtml.indexNewHtml(request, pool,"700301");
	}
	}catch(Exception e){
		out.println(e.getMessage()) ;
	}
out.println("ok") ;
%>