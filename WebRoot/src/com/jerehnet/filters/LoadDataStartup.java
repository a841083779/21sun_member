package com.jerehnet.filters;

import java.util.Iterator;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.jerehnet.cmbol.database.DataManager;
import com.jerehnet.cmbol.database.PoolManager;
import com.jerehnet.util.common.CommonString;

public class LoadDataStartup implements ServletContextListener {
	public void contextInitialized(ServletContextEvent event) {
		ServletContext application = event.getServletContext();
		PoolManager pool = new PoolManager();   
		String[][] provinces = DataManager.fetchFieldValue(pool, "ip_prci", "area_name", "flag=3");
		String[][] citys = DataManager.fetchFieldValue(pool, "ip_prci", "area_name", "flag=4");
		application.setAttribute("provinces", provinces);
		application.setAttribute("citys", citys);
		
		loadFilterKeyword(application);
	}
	
	public void loadFilterKeyword(ServletContext application){
		PoolManager pool = new PoolManager();
		String[][] keywordArys = DataManager.fetchFieldValue(pool, "comm_filter_keywords", "keyword", "is_use=1 and keyword_type<>'200002'");
		String filterKeywords = "";
		String kw = "";
		for (String[] keywordAry : keywordArys) {
			kw = CommonString.getFormatPara(keywordAry[0]);
			kw = kw.replace("\\", "\\\\").replace("|", "@@").replace("-", "\\-").replace(".", "\\.").replace("?", "\\?").replace("[", "\\[").replace("]", "\\]").replace("{", "\\{").replace("}", "\\}").replace("+", "\\+").replace("*", "\\*").replace(":", "\\:").replace("(", "\\(").replace(")", "\\)").replace("^", "\\^");
			if ((kw != null) && (!"".equals(kw))) {
				filterKeywords += kw + "|";
			}
		}
		if (!filterKeywords.equals("")) {
			filterKeywords = filterKeywords.substring(0, filterKeywords.length() - 1);
			application.setAttribute("filter_keywords", filterKeywords);
		}
		
		String[][] keywordArys_a = DataManager.fetchFieldValue(pool, "comm_filter_keywords", "keyword", "is_use=1 and keyword_type='200002'");
		String filterKeywords_a = "";
		String kw_a = "";
		for (String[] keywordAry_a : keywordArys_a) {
			kw_a = CommonString.getFormatPara(keywordAry_a[0]);
			kw_a = kw_a.replace("\\", "\\\\").replace("|", "@@").replace("-", "\\-").replace(".", "\\.").replace("?", "\\?").replace("[", "\\[").replace("]", "\\]").replace("{", "\\{").replace("}", "\\}").replace("+", "\\+").replace("*", "\\*").replace(":", "\\:").replace("(", "\\(").replace(")", "\\)").replace("^", "\\^");
			if ((kw_a != null) && (!"".equals(kw_a))) {
				filterKeywords_a += kw_a + "|";
			}
		}
		if (!filterKeywords_a.equals("")) {
			filterKeywords_a = filterKeywords_a.substring(0, filterKeywords_a.length() - 1);
			application.setAttribute("filter_keywords_a", filterKeywords_a);
		}
	}

	public void contextDestroyed(ServletContextEvent event) {

	}
}
