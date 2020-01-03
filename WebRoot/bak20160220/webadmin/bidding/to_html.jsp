<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,java.net.*,com.jerehnet.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.freemaker.*"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%><%@ include file ="../manage/config.jsp"%>
<%

if(pool==null){
	pool = new PoolManager();
}

BiddingToHtml bidding = new BiddingToHtml();
bidding.indexNewBidding(request,pool,"8");

bidding.indexBiddingSort(request,pool,"8","1000");
bidding.indexBiddingSort(request,pool,"8","2000");
bidding.indexBiddingSort(request,pool,"8","3000");
bidding.indexBiddingSort(request,pool,"8","4000");
bidding.indexBiddingSort(request,pool,"8","5000");

bidding.indexBiddingNews(request,pool,"8");
%>