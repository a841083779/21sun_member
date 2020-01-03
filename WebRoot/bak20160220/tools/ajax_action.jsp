<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.Common"%>
<%@page import="com.jerehnet.cmbol.database.PoolManager"%>
<%@page import="com.jerehnet.cmbol.database.DataManager"%>
<%
    PoolManager pool5 = new PoolManager(5);
    DataManager dataManager = new DataManager() ;
	String title = Common.getFormatStr(request.getParameter("title")).trim() ;
	String tableName = Common.decryptionByDES(request.getParameter("mypy")) ;
	String mem_no = Common.getFormatStr(request.getParameter("mem_no")) ;
	StringBuffer whereStr = new StringBuffer(" 1=1 ") ;
	if(!"".equals(mem_no)){
		whereStr.append(" and mem_no='").append(mem_no).append("'") ;
	}
	if(!"".equals(title)){
		whereStr.append(" and rtrim(ltrim(title)) ='").append(title).append("' ") ;
	}
	String[][] result = dataManager.fetchFieldOneValue(pool5,tableName,"count(*) as total",whereStr.toString()) ;
	out.println(Common.getFormatStr((result!=null && result.length>0)?result[0][0]:"")) ;
%>

