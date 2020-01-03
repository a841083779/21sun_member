<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page import="org.apache.commons.httpclient.HttpMethod"%>
<%@page import="com.jerehnet.util.DesEncrypt"%>
<%@page import="com.jerehnet.util.Common"%>
<%@page import="com.jerehnet.cmbol.database.DataManager"%>
<%@page import="com.jerehnet.cmbol.database.PoolManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="org.apache.commons.httpclient.HttpClient"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="com.jerehnet.util.common.UTF8PostMethod"%>
<%@page import="org.apache.commons.httpclient.NameValuePair"%>
<%@page import="org.apache.commons.httpclient.HttpStatus"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.*"%>
<%@page import="java.lang.reflect.Array"%>
<%         int i=1;
			Map filterMap = (Map) application.getAttribute("filterkeywords");
            if(filterMap!=null){
			
			Iterator it = filterMap.keySet().iterator();  
            while (it.hasNext()){  
            String key;  
            key=(String)it.next();
            i++;			
            if(key.indexOf("财")>=0){
			

%>
            <%=key%><br>
<%          
	        }
            } 

			}else{
%>
            222222222
<%}%>
<%=i%>