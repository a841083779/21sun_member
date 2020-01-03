<%@ page language="java" import="com.jerehnet.cmbol.database.DataManager,com.jerehnet.cmbol.database.PoolManager,com.jerehnet.util.common.CommonString,java.util.HashMap,javax.servlet.ServletContext,javax.servlet.ServletContextEvent,javax.servlet.ServletContextListener" pageEncoding="UTF-8"%>
<%





    PoolManager pool = new PoolManager();
    String[][] keywordArys = DataManager.fetchFieldValue(pool, "comm_filter_keywords", "keyword", "1=1");
    String filterKeywords = "";
    String kw = "";
    HashMap filterkeywords = new HashMap();
    HashMap filterkeywords_a = new HashMap();
    int i = 1;
    for (String[] keywordAry : keywordArys){
      kw = CommonString.getFormatPara(keywordAry[0]);
      kw = kw.replace("\\", "\\\\").replace("|", "@@").replace("-", "\\-").replace(".", "\\.").replace("?", "\\?").replace("[", "\\[").replace("]", "\\]").replace("{", "\\{").replace("}", "\\}").replace("+", "\\+").replace("*", "\\*").replace(":", "\\:").replace("(", "\\(").replace(")", "\\)").replace("^", "\\^");
      if ((kw != null) && (!"".equals(kw))) {
        filterkeywords.put(kw, Integer.toString(i));
      }
      i++;
    }
    application.setAttribute("filterkeywords", filterkeywords);







%>