<%@page import="org.apache.commons.httpclient.methods.GetMethod"%>
<%@page contentType="text/html;charset=utf-8" import="java.sql.*,java.util.*,com.jerehnet.cmbol.database.*,com.jerehnet.cmbol.action.*,com.jerehnet.util.*,com.jerehnet.cmbol.freemaker.*,org.apache.commons.httpclient.*"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="org.apache.commons.httpclient.methods.PostMethod"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@ include file ="/manage/config.jsp"%>
	<% 
    String prxStr = "zx";//字段前缀
	
	//过滤二手信息
	String zd_title =  Common.getFormatStr(request.getParameter(prxStr+"_title"));
	String zd_descr =  Common.getFormatStr(request.getParameter(prxStr+"_descr"));
	boolean is_good_person = zd_title.matches("[^`]*[小|调|白|女|学|夜|冬][^`]{1,3}[姐|教|领|王|生|情|虫][^`]*");
	if(!is_good_person){
		is_good_person = zd_descr.matches("[^`]*[小|调|白|女|学|夜|冬][^`]{1,3}[姐|教|领|王|生|情|虫][^`]*");
	}
	
	String  info=zd_title+zd_descr;
	int filterkeywords=0;
	//验证普通会员词汇
	Map filterMap = (Map) application.getAttribute("filterkeywords");
    if(filterMap!=null){
			    filterMap.put("磨簧机", "1");
				filterMap.put("卷簧机", "1");
				filterMap.put("票", "1");//20150729
				Iterator it = filterMap.keySet().iterator();  
                while (it.hasNext()){  
                String key;  
                key=(String)it.next();
				    if(info.indexOf(key)>=0){
				      filterkeywords=1;
					  break ;
				    }
				}
	}
    
	out.print(filterkeywords);

%>